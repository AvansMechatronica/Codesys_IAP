(*#### DECLARATIE ####*)
PROGRAM SorterenSim
VAR
	// Timer om sorteren te vertragen
	Fb_Pulse: BLINK;
	// Timer om sorteren te vertragen
	Fb_Trigger: F_TRIG;
	// Eerste keer om visualisatie te updaten
	Mx_FirstTime: BOOL := TRUE;
	// Afhandeling van de overzetter
	Me_SorState: SORTERENDUT := SORTERENDUT.OPDEBAND;
	// Index voor posities
	Mi_PositieIndx: INT := 1;
	// Index voor goten.
	Mi_GootIndx: INT := 1;
	// Afhandeling blokjes in goot1.
	Mb_Goot1: SorterenGootSim;
	// Afhandeling blokjes in goot2.
	Mb_Goot2: SorterenGootSim;
	// Afhandeling blokjes in goot3.
	Mb_Goot3: SorterenGootSim;
	// Afhandeling blokjes in goot4.
	Mb_Goot4: SorterenGootSim;
	Mx_Geplaatst: BOOL := FALSE;
	// Random nummer om kleur te bepalen
	Mi_Random: UDINT := 1;	
END_VAR
VAR CONSTANT
	// Inverse logica
	INVISABLE: BOOL := TRUE;
	// Inverse logica
	VISABLE: BOOL := FALSE;
	// Kleur rood
	RED: DWORD := 16#00FF0000;
	// Kleur wit
	WHITE: DWORD := 16#00FFFFFF;
	// Stapgrootte voor bewegingen
	STEP: INT := 4;
	// Kleur zwart
	BLACK: DWORD := 16#00000000;
	// Kleur geel
	YELLOW: DWORD := 16#00FFFF00;
	// Metaal blank (zilver): metaal en reflecterend
	METAAL_BLANK: DWORD := 16#FFC0C0C0;
	// Metaal zwart (antraciet): metaal, niet reflecterend
	METAAL_ZWART: DWORD := 16#FF505050;
	// Kunststof rood: geen metaal, wel reflecterend
	KUNSTOF_ROOD: DWORD := 16#FFFF0000;
	// Kunststof zwart: geen metaal, niet reflecterend
	KUNSTOF_ZWART: DWORD := 16#FF000000;
	// Goot 1
	GOOT1: INT := 1;
	// Goot 2
	GOOT2: INT := 2;
	// Goot 3
	GOOT3: INT := 3;
	// Goot 4
	GOOT4: INT := 4;
END_VAR

(*#### IMPLEMENTATIE ####*)
// Initialisatie.

IF (Mx_FirstTime) THEN
	Me_SorState := SORTERENDUT.VOLGENDEBLOK;

	SIM.Vw_SorBlokBand  := VISABLE;
	SIM.Vw_SorKleurBand := SIM.Vw_OvzKleur;
	SIM.Vi_SorBlokBandX := 0;
	SIM.Vi_SorBlokBandY := 0;
	
	FOR Mi_GootIndx := 1 TO 4 DO 
		FOR Mi_PositieIndx := 1 TO 3 DO
			SIM.Vx_SorBlokGoot[Mi_GootIndx, Mi_PositieIndx ]  := INVISABLE;
			SIM.Vw_SorKleurGoot[Mi_GootIndx, Mi_PositieIndx ] := WHITE;			
		END_FOR
	END_FOR
 
	Mx_FirstTime := FALSE;
END_IF

//
// Afhandelen van de pulse events. Hierdoor loopt de simulatie los van de 
// TASK tijd.
//
Fb_Pulse(ENABLE:=TRUE,TIMELOW:=T#50MS, TIMEHIGH:=T#50MS);
Fb_Trigger(CLK:=Fb_Pulse.OUT);


//
// Only if no emergency active, start handling the simulation.
//
IF (SIM.Ix_GotenLegen) THEN
	Mx_FirstTime := TRUE;
	SIM.Ix_GotenLegen := FALSE;
	RETURN;
END_IF


// The pulse determines the speed of the cilinder to move in
// ore move out. The cilinder is only moved if the airpressure 
// is available.
//
IF (Fb_Trigger.Q) THEN
	IF (GVL.Qx_StopperUit) THEN
		SIM.Vw_SorStopperRotate := 90;
	ELSE
		SIM.Vw_SorStopperRotate := 0;		
	END_IF
	
	IF (GVL.Qx_UitvoerGoot1Uit) THEN
		SIM.Vw_SorGoot1Rotate := 45;
	ELSE
		SIM.Vw_SorGoot1Rotate := 0;		
	END_IF	

	GVL.Ix_UitvoerGoot1IsUit := (SIM.Vw_SorGoot1Rotate > 0) AND (SIM.Vx_SorGoot1UitError);
    GVL.Ix_UitvoerGoot1IsIn  := (SIM.Vw_SorGoot1Rotate = 0) AND (SIM.Vx_SorGoot1InError);	
	
	IF (GVL.Qx_UitvoerGoot2Uit) THEN
		SIM.Vw_SorGoot2Rotate := 45;
	ELSE
		SIM.Vw_SorGoot2Rotate := 0;		
	END_IF	

	GVL.Ix_UitvoerGoot2IsUit := (SIM.Vw_SorGoot2Rotate > 0);
    GVL.Ix_UitvoerGoot2IsIn  := (SIM.Vw_SorGoot2Rotate = 0);	

	IF (GVL.Qx_UitvoerGoot3Uit) THEN
		SIM.Vw_SorGoot3Rotate := 45;
	ELSE
		SIM.Vw_SorGoot3Rotate := 0;
	END_IF

	GVL.Ix_UitvoerGoot3IsUit := (SIM.Vw_SorGoot3Rotate > 0);
	GVL.Ix_UitvoerGoot3IsIn  := (SIM.Vw_SorGoot3Rotate = 0);
	
	GVL.Ix_BekerInGoot := SIM.Vx_SorInGootError AND NOT ((SIM.Vx_SorBlokGoot[1,1] = VISABLE) OR (SIM.Vx_SorBlokGoot[2,1] = VISABLE) OR (SIM.Vx_SorBlokGoot[3,1] = VISABLE) OR (SIM.Vx_SorBlokGoot[4,1] = VISABLE) OR ((SIM.Vi_SorBlokBandY > 30) AND (SIM.Vi_SorBlokBandY < 40)));


				
	CASE Me_SorState OF
		SORTERENDUT.VOLGENDEBLOK:
			//
			// Zet alles klaar voor een volgende blokje.
			//

			// Het blok krijgt de kleur van het blok dat de overzetter heeft gelost. Is dat er nog niet,
			// dan wordt de kleur overgenomen zodra het gelost wordt (zie OPDEBAND).
			IF SIM.Vx_SorNieuwBlok THEN
				SIM.Vw_SorKleurBand := SIM.Vw_SorKleurVolgende;
				SIM.Vx_SorNieuwBlok := FALSE;
			END_IF
			
			SIM.Vw_SorBlokBand := VISABLE;
			SIM.Vi_SorBlokBandX := 0;
			SIM.Vi_SorBlokBandY := 0;
	
			Me_SorState := SORTERENDUT.OPDEBAND;
		
		SORTERENDUT.OPDEBAND:
			// Nieuw blok gelost terwijl dit blok nog voor de stopper is: neem de kleur over.
			IF SIM.Vx_SorNieuwBlok THEN
				SIM.Vw_SorKleurBand := SIM.Vw_SorKleurVolgende;
				SIM.Vx_SorNieuwBlok := FALSE;
			END_IF
		
			//
			// Blokje ligt op de band. Verplaats tot voor de stopper.
			//
			
			IF ((GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError)) THEN
				SIM.Vi_SorBlokBandX := SIM.Vi_SorBlokBandX + STEP;
			END_IF
			
			GVL.Ix_StationAfvoerVrij := (SIM.Vi_SorBlokBandX < 20);
			
			IF (SIM.Vi_SorBlokBandX > 50) THEN
				Me_SorState := SORTERENDUT.VOORSTOPPER;
			END_IF
			
		SORTERENDUT.VOORSTOPPER: 
		
			//
			// Indien de stopper uit is, dan stopt het blokje en worden
			// de kleur sensoren geactiveerd. Anders loopt het blokje gewoon door
			// naar goot 1.
			//
			
			IF ((NOT GVL.Qx_StopperUit) AND (GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError)) THEN
				SIM.Vi_SorBlokBandX := SIM.Vi_SorBlokBandX + STEP;	
			END_IF

			IF (GVL.Qx_StopperUit) THEN
				// Eerst de meetwaarden, dan pas 'aanwezig': zo leest het PLC-programma nooit de waarden van het vorige blok.
				GVL.Ix_BekerMetaal       := (SIM.Vw_SorKleurBand = METAAL_BLANK) OR (SIM.Vw_SorKleurBand = METAAL_ZWART);
				GVL.Ix_BekerReflecteerd  := (SIM.Vw_SorKleurBand = METAAL_BLANK) OR (SIM.Vw_SorKleurBand = KUNSTOF_ROOD);
				GVL.Ix_BekerAanwezig := TRUE;
			END_IF
			
			
			IF (SIM.Vi_SorBlokBandX > 60) THEN
				Me_SorState := SORTERENDUT.NAARGOOT1;
			END_IF		
		
		
		SORTERENDUT.NAARGOOT1:
			//
			// Voor goot 1 wordt bepaald of de stopper uit staat en het blokje dus in de goot
			// gaat. Anders loopt het blokje door naar goot 2.
			//

			GVL.Ix_BekerAanwezig := FALSE;
			
			IF ((GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError)) THEN
				SIM.Vi_SorBlokBandX := SIM.Vi_SorBlokBandX + STEP;
			END_IF
			
			IF ((SIM.Vi_SorBlokBandX > 130) AND (GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError) AND (GVL.Qx_UitvoerGoot1Uit)) THEN
				Me_SorState := SORTERENDUT.INGOOT1;
			END_IF		
	
			IF ((SIM.Vi_SorBlokBandX > 130) AND (GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError) AND (NOT GVL.Qx_UitvoerGoot1Uit)) THEN
				Me_SorState := SORTERENDUT.NAARGOOT2;
			END_IF	
	 
		SORTERENDUT.INGOOT1:
			//
			// Blokje valt in goot 1. Hier kunnen 3 blokjes liggen. Het  blokje van de band beweegt de goot 
			// in en aan de hand van welke blokjes er al liggen wordt het eerst volgende blokje bepaald.
			// Dit blokje wordt vervolgens getoond. Daarna is het sorteren gereed. Let op dat de goot vol
			// melding even wordt getriggered als het blokje door de sensor valt.
			//
			
			IF (SIM.Vi_SorBlokBandX < 170) THEN
				SIM.Vi_SorBlokBandX := SIM.Vi_SorBlokBandX + 2*STEP;
			END_IF
			
			SIM.Vi_SorBlokBandY := SIM.Vi_SorBlokBandY + STEP;

			
			Mb_Goot1(Px_YPos:=SIM.Vi_SorBlokBandY, Px_Goot:=GOOT1);
		
			IF (Mb_Goot1.Px_Geplaatst) THEN
				Me_SorState := SORTERENDUT.GEREED;
			END_IF
			
			IF (SIM.Vx_SorBlokGoot[GOOT1, 1] = VISABLE) THEN
				Me_SorState := SORTERENDUT.VOL;
			END_IF
			
		SORTERENDUT.NAARGOOT2: 
			//
			// Voor goot 2 wordt bepaald of de stopper uit staat en het blokje dus in de goot
			// gaat. Anders loopt het blokje door naar goot 3.
			//
		
			IF ((GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError)) THEN
				SIM.Vi_SorBlokBandX := SIM.Vi_SorBlokBandX + STEP;
			END_IF
			
			IF ((SIM.Vi_SorBlokBandX > 230) AND (GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError) AND (GVL.Qx_UitvoerGoot2Uit)) THEN
				Me_SorState := SORTERENDUT.INGOOT2;
			END_IF		
	
			IF ((SIM.Vi_SorBlokBandX > 230) AND (GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError) AND (NOT GVL.Qx_UitvoerGoot2Uit)) THEN
				Me_SorState := SORTERENDUT.NAARGOOT3;
			END_IF	
		
		SORTERENDUT.INGOOT2:
	
			//
			// Blokje valt in goot 2. Hier kunnen 3 blokjes liggen. Het  blokje van de band beweegt de goot 
			// in en aan de hand van welke blokjes er al liggen wordt het eerst volgende blokje bepaald.
			// Dit blokje wordt vervolgens getoond. Daarna is het sorteren gereed. Let op dat de goot vol
			// melding even wordt getriggered als het blokje door de sensor valt.
			//
			
			IF (SIM.Vi_SorBlokBandX < 270) THEN
				SIM.Vi_SorBlokBandX := SIM.Vi_SorBlokBandX + 2*STEP;
			END_IF
			
			SIM.Vi_SorBlokBandY := SIM.Vi_SorBlokBandY + STEP;
					
			Mb_Goot2(Px_YPos:=SIM.Vi_SorBlokBandY, Px_Goot:=GOOT2);
		
			IF (Mb_Goot2.Px_Geplaatst) THEN
				Me_SorState := SORTERENDUT.GEREED;
			END_IF

			IF (SIM.Vx_SorBlokGoot[GOOT2, 1] = VISABLE) THEN
				Me_SorState := SORTERENDUT.VOL;
			END_IF
		
		SORTERENDUT.NAARGOOT3: 
			//
			// Voor goot 3 wordt bepaald of de schuif uit staat en het blokje dus in de goot
			// gaat. Anders loopt het blokje door naar goot 4.
			//
			IF ((GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError)) THEN
				SIM.Vi_SorBlokBandX := SIM.Vi_SorBlokBandX + STEP;
			END_IF

			IF ((SIM.Vi_SorBlokBandX > 330) AND (GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError) AND (GVL.Qx_UitvoerGoot3Uit)) THEN
				Me_SorState := SORTERENDUT.INGOOT3;
			END_IF

			IF ((SIM.Vi_SorBlokBandX > 330) AND (GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError) AND (NOT GVL.Qx_UitvoerGoot3Uit)) THEN
				Me_SorState := SORTERENDUT.NAARGOOT4;
			END_IF

		SORTERENDUT.INGOOT3:
	
			//
			// Blokje valt in goot 3. Hier kunnen 3 blokjes liggen. Het  blokje van de band beweegt de goot 
			// in en aan de hand van welke blokjes er al liggen wordt het eerst volgende blokje bepaald.
			// Dit blokje wordt vervolgens getoond. Daarna is het sorteren gereed. Let op dat de goot vol
			// melding even wordt getriggered als het blokje door de sensor valt.
			//
			
			IF (SIM.Vi_SorBlokBandX < 370) THEN
				SIM.Vi_SorBlokBandX := SIM.Vi_SorBlokBandX + 2*STEP;
			END_IF
			
			SIM.Vi_SorBlokBandY := SIM.Vi_SorBlokBandY + STEP;
			
			Mb_Goot3(Px_YPos:=SIM.Vi_SorBlokBandY, Px_Goot:=GOOT3);
		
			IF (Mb_Goot3.Px_Geplaatst) THEN
				Me_SorState := SORTERENDUT.GEREED;
			END_IF
	
			IF (SIM.Vx_SorBlokGoot[GOOT3, 1] = VISABLE) THEN
				Me_SorState := SORTERENDUT.VOL;
			END_IF
		
		SORTERENDUT.NAARGOOT4: 
			//
			// Er valt niks meer te stoppen. Blokje loopt door naar goot 4.
			//
			IF ((GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError)) THEN
				SIM.Vi_SorBlokBandX := SIM.Vi_SorBlokBandX + STEP;
			END_IF

			IF ((SIM.Vi_SorBlokBandX > 430) AND (GVL.Qx_MotorAfvoerAan) AND (SIM.Vx_SorMotorAfvoerError)) THEN
				Me_SorState := SORTERENDUT.INGOOT4;
			END_IF

		SORTERENDUT.INGOOT4:
			//
			// Blokje valt in goot 4 (zelfde werking als de andere goten).
			//
			IF (SIM.Vi_SorBlokBandX < 470) THEN
				SIM.Vi_SorBlokBandX := SIM.Vi_SorBlokBandX + 2*STEP;
			END_IF

			SIM.Vi_SorBlokBandY := SIM.Vi_SorBlokBandY + STEP;

			Mb_Goot4(Px_YPos:=SIM.Vi_SorBlokBandY, Px_Goot:=GOOT4);

			IF (Mb_Goot4.Px_Geplaatst) THEN
				Me_SorState := SORTERENDUT.GEREED;
			END_IF

			IF (SIM.Vx_SorBlokGoot[GOOT4, 1] = VISABLE) THEN
				Me_SorState := SORTERENDUT.VOL;
			END_IF

		SORTERENDUT.GEREED:
			SIM.Vw_SorKleurBand := WHITE;
			SIM.Vw_SorBlokBand := INVISABLE;
			SIM.Vi_SorBlokBandX := 0;
			SIM.Vi_SorBlokBandY := 0;
			
			IF (NOT GVL.Qx_MotorAfvoerAan) THEN
				Me_SorState := SORTERENDUT.VOLGENDEBLOK;
			END_IF
			
		SORTERENDUT.VOL:
			RETURN;
			
	END_CASE

END_IF
