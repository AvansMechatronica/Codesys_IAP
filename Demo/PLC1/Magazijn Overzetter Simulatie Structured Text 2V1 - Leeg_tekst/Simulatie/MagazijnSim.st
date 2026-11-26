(*#### DECLARATIE ####*)
PROGRAM MagazijnSim
VAR
	// Timer om uitstoten en intrekken te vertragen
	Fb_Pulse: BLINK;
	// Timer om intrekken te vertragen
	Fb_Trigger: F_TRIG;
	// Eerste keer om visualisatie te updaten
	Mx_FirstTime: BOOL := TRUE;
	// Afhandeling van het magazijn
	Me_MagState: MAGAZIJNDUT := MAGAZIJNDUT.INGETROKKEN;
	// Kleuren van de blokken in het magazijn, [1] = onderste (wordt als eerste uitgestoten)
	Mw_KleurRij: ARRAY[1..8] OF DWORD;
	// Hulpvariabelen voor het kiezen van een willekeurige kleur
	Mi_Indx: INT;
	Mu_Seed: UDINT := 1;
END_VAR
VAR CONSTANT
	// Metaal blank (zilver): metaal en reflecterend
	METAAL_BLANK: DWORD := 16#FFC0C0C0;
	// Metaal zwart (antraciet): metaal, niet reflecterend
	METAAL_ZWART: DWORD := 16#FF505050;
	// Kunststof rood: geen metaal, wel reflecterend
	KUNSTOF_ROOD: DWORD := 16#FFFF0000;
	// Kunststof zwart: geen metaal, niet reflecterend
	KUNSTOF_ZWART: DWORD := 16#FF000000;
	// Lege plek in het magazijn
	LEEG: DWORD := 16#FFA9A9A9;
END_VAR
(*#### IMPLEMENTATIE ####*)
//
// Common stuff.
//

IF (Mx_FirstTime) THEN
	SIM.Vw_MagBlokAantal := 8;
	SIM.Vx_MagBlokUit:= FALSE;
	
	// Vul het magazijn met blokken in willekeurige kleuren (materiaal + kleur).
	Mu_Seed := DINT_TO_UDINT(TIME_TO_DINT(TIME())) + Mu_Seed;
	FOR Mi_Indx := 1 TO 8 DO
		Mu_Seed := Mu_Seed * 1103515245 + 12345;
		CASE UDINT_TO_INT(SHR(Mu_Seed, 16) AND 3) OF
			0: Mw_KleurRij[Mi_Indx] := METAAL_BLANK;
			1: Mw_KleurRij[Mi_Indx] := METAAL_ZWART;
			2: Mw_KleurRij[Mi_Indx] := KUNSTOF_ROOD;
		ELSE
			Mw_KleurRij[Mi_Indx] := KUNSTOF_ZWART;
		END_CASE
	END_FOR
	Mx_FirstTime := FALSE;
END_IF

					
//
// Handle all pulse and trigger events.
//
Fb_Pulse(ENABLE:=TRUE,TIMELOW:=T#200MS, TIMEHIGH:=T#200MS);
Fb_Trigger(CLK:=Fb_Pulse.OUT);


//
// Only if no emergency active, start handling the simulation.
//
IF (SIM.Ix_MagazijnVullen) THEN
	Mx_FirstTime := TRUE;
	SIM.Ix_MagazijnVullen := FALSE;
	RETURN;
END_IF
	
//
// The pulse determines the speed of the cilinder to move in
// ore move out. The cilinder is only moved if the airpressure 
// is available.
//
IF (Fb_Trigger.Q AND SIM.Vx_MagLuchtDrukError) THEN
		
			
	CASE Me_MagState OF
		MAGAZIJNDUT.INGETROKKEN:
			IF (SIM.Vx_MagBlokUit) THEN
				SIM.Vw_MagBlokAantal := SIM.Vw_MagBlokAantal - 1;
				// Het onderste blok ligt nu klaar voor de overzetter; de rest zakt een plek.
				SIM.Vw_MagKleurAfgifte := Mw_KleurRij[1];
				SIM.Vx_MagBlokKlaar := TRUE;
				FOR Mi_Indx := 1 TO 7 DO
					Mw_KleurRij[Mi_Indx] := Mw_KleurRij[Mi_Indx + 1];
				END_FOR
				Mw_KleurRij[8] := LEEG;
			END_IF
		
			SIM.Vw_MagUitstoterBekerX := 1;
			SIM.Vw_MagBlok1X    	  := SIM.Vw_MagUitstoterBekerX;
			SIM.Vx_MagBlokUit         := FALSE;
	
			IF (Qx_BekerUitstoten) THEN
				Me_MagState := MAGAZIJNDUT.UITSTOTEN;
			END_IF

		MAGAZIJNDUT.INTREKKEN:
			SIM.Vw_MagUitstoterBekerX := SIM.Vw_MagUitstoterBekerX - 30;
			
			IF (SIM.Vw_MagUitstoterBekerX < 0) THEN 
				SIM.Vw_MagUitstoterBekerX := 0; 
			END_IF		
			
			IF (SIM.Vw_MagUitstoterBekerX = 0) THEN
				Me_MagState := MAGAZIJNDUT.INGETROKKEN;				
			END_IF		

			IF (Qx_BekerUitstoten) THEN
				Me_MagState := MAGAZIJNDUT.UITSTOTEN;
			END_IF	
	
		MAGAZIJNDUT.UITGESTOTEN:
			SIM.Vx_MagBlokUit         := SIM.Vx_MagBlok1;
						
			IF (NOT Qx_BekerUitstoten) THEN
				Me_MagState := MAGAZIJNDUT.INTREKKEN;
			END_IF	
		
		MAGAZIJNDUT.UITSTOTEN:
			SIM.Vw_MagUitstoterBekerX := SIM.Vw_MagUitstoterBekerX + 30;
			SIM.Vw_MagBlok1X    	  := SIM.Vw_MagUitstoterBekerX;			
		
			IF (SIM.Vw_MagUitstoterBekerX > 70) THEN
				Me_MagState := MAGAZIJNDUT.UITGESTOTEN;				
			END_IF		

			IF (NOT Qx_BekerUitstoten) THEN
				Me_MagState := MAGAZIJNDUT.INTREKKEN;
			END_IF	
		
	END_CASE

	GVL.Ix_UitstoterBekerIn  := (Me_MagState = MAGAZIJNDUT.INGETROKKEN) AND SIM.Vx_MagIsInError;
	GVL.Ix_UitstoterBekerUit := (Me_MagState = MAGAZIJNDUT.UITGESTOTEN) AND SIM.Vx_MagIsUitError;	
	GVL.Ix_MagazijnLeeg 	 := (SIM.Vw_MagBlokAantal <= 0) AND (Ix_UitstoterBekerIn);	
	
	SIM.Vx_MagBlok[8] := (SIM.Vw_MagBlokAantal >= 8);
	SIM.Vx_MagBlok[7] := (SIM.Vw_MagBlokAantal >= 7);
	SIM.Vx_MagBlok[6] := (SIM.Vw_MagBlokAantal >= 6);
	SIM.Vx_MagBlok[5] := (SIM.Vw_MagBlokAantal >= 5);		
	SIM.Vx_MagBlok[4] := (SIM.Vw_MagBlokAantal >= 4);
	SIM.Vx_MagBlok[3] := (SIM.Vw_MagBlokAantal >= 3);
	SIM.Vx_MagBlok[2] := (SIM.Vw_MagBlokAantal >= 2);
	SIM.Vx_MagBlok[1] := (SIM.Vw_MagBlokAantal >= 1);	

	// Kleur per plek voor de visualisatie
	FOR Mi_Indx := 1 TO 8 DO
		IF SIM.Vx_MagBlok[Mi_Indx] THEN
			SIM.Vw_MagKleur[Mi_Indx] := Mw_KleurRij[Mi_Indx];
		ELSE
			SIM.Vw_MagKleur[Mi_Indx] := LEEG;
		END_IF
	END_FOR
	IF SIM.Vx_MagBlokUit THEN
		SIM.Vw_MagKleurUit := Mw_KleurRij[1];
	ELSE
		SIM.Vw_MagKleurUit := LEEG;
	END_IF
	
END_IF	
