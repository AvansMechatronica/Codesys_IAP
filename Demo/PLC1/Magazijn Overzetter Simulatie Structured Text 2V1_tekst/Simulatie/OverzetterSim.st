(*#### DECLARATIE ####*)
PROGRAM OverzetterSim
VAR
	// Timer om overzetten te vertragen
	Fb_Pulse: BLINK;
	// Timer om overzetten te vertragen
	Fb_Trigger: F_TRIG;
	// Eerste keer om visualisatie te updaten
	Mx_FirstTime: BOOL := TRUE;
	// Afhandeling van de overzetter
	Me_OvzState: OverzetterDUT := OVERZETTERDUT.INHETMIDDEN;	
	// Afhandeling van het blokje
	Me_BlokState: OverzetterDUT := OVERZETTERDUT.INHETMIDDEN;	
	// Duurt even voor het vacuum aanwezig is
	Mi_VacuumCntr: INT := 0;	
	// De overzetter heeft echt een beker vast (FALSE = leeg opgepakt, er lag niets klaar)
	Mx_MetBeker: BOOL := FALSE;
END_VAR
VAR CONSTANT


	// Inverse logica
	INVISABLE: BOOL := TRUE;
	// Inverse logica
	VISABLE: BOOL := FALSE;

END_VAR
(*#### IMPLEMENTATIE ####*)
// Initialisatie.

//
// Afgifteplaats leegmaken (knop in de visualisatie).
//
IF (SIM.Ix_AfgifteLegen) THEN
	SIM.Vi_AfgifteTeller := 0;
	SIM.Vx_AfgifteBeker  := INVISABLE;
	SIM.Vw_AfgifteKleur  := 16#FFA9A9A9;
	SIM.Ix_AfgifteLegen  := FALSE;
END_IF

IF (Mx_FirstTime) THEN
	Me_OvzState := OVERZETTERDUT.INHETMIDDEN;
	Me_BlokState := OVERZETTERDUT.ISLINKS;
	
	Mi_VacuumCntr := 0;
	Mx_MetBeker := FALSE;
	SIM.Vx_OvzRotate := 0;
	Mx_FirstTime := FALSE;
END_IF

//
// Afhandelen van de pulse events. Hierdoor loopt de simulatie los van de 
// TASK tijd.
//
Fb_Pulse(ENABLE:=TRUE,TIMELOW:=T#100MS, TIMEHIGH:=T#100MS);
Fb_Trigger(CLK:=Fb_Pulse.OUT);


//
// Only if no emergency active, start handling the simulation.
//
IF (GVL.Ix_Noodstop) THEN
	Mx_FirstTime := TRUE;	
	RETURN;
END_IF
	
//
// The pulse determines the speed of the cilinder to move in
// ore move out. The cilinder is only moved if the airpressure 
// is available.
//
IF (Fb_Trigger.Q AND SIM.Vx_OvzLuchtDrukError) THEN
	
	//
	// De status van de arm wordt los afgehandeld van het blokje. De beweging
	// van de arm staat hier namelijk helemaal los van.
	//
	
	CASE Me_OvzState OF
		
		OVERZETTERDUT.INHETMIDDEN:
			// 
			// De arm is in beweging naar links of naar rechts.
			// Indien de arm in de uiterste positie is wordt er van 
			// state gewisseld. Aangezien de arm in beweging is staan
			// de eindschakelaars uit.
			//
			
			IF (GVL.Qx_OverzetterLinks) THEN
				IF (SIM.Vx_OvzRotate > -90) THEN
					GVL.Ix_OverzetterIsLinks := FALSE;	
					GVL.Ix_OverzetterIsRechts := FALSE;			
					SIM.Vx_OvzRotate := SIM.Vx_OvzRotate - 10;
				ELSE
					Me_OvzState := OVERZETTERDUT.ISLINKS;			
				END_IF	
				
			END_IF
				 
			IF (GVL.Qx_OverzetterRechts) THEN
				IF (SIM.Vx_OvzRotate < 90) THEN
					GVL.Ix_OverzetterIsLinks := FALSE;	
					GVL.Ix_OverzetterIsRechts := FALSE;				
					SIM.Vx_OvzRotate := SIM.Vx_OvzRotate + 10;
				ELSE
					Me_OvzState := OVERZETTERDUT.ISRECHTS;				
				END_IF			
			END_IF
				
		OVERZETTERDUT.ISLINKS:
		    //
			// Arm staat in een uiterste stand. Eindschakelaar is ingeschakeld.
			// Zodra de arm weer wordt bewogen verandert de state.
			//
			
			GVL.Ix_OverzetterIsLinks := TRUE AND SIM.Vx_OvzIsLinksError;	

			IF (GVL.Qx_OverzetterRechts AND NOT GVL.Qx_OverzetterLinks) THEN
				GVL.Ix_OverzetterIsLinks := FALSE;				
				Me_OvzState := OVERZETTERDUT.INHETMIDDEN;		
			END_IF
			
		OVERZETTERDUT.ISRECHTS:
		    //
			// Arm staat in een uiterste stand. Eindschakelaar is ingeschakeld.
			// Zodra de arm weer wordt bewogen verandert de state.
			//
		
			GVL.Ix_OverzetterIsRechts := TRUE AND SIM.Vx_OvzIsRechtsError;	

			IF (GVL.Qx_OverzetterLinks AND NOT GVL.Qx_OverzetterRechts) THEN
				GVL.Ix_OverzetterIsRechts := FALSE;				
				Me_OvzState := OVERZETTERDUT.INHETMIDDEN;		
			END_IF			
			
		END_CASE

	END_IF	

	//
	// De status van het blokje hangt af van een aantal stuursignalen zoals waar
	// de arm zich bevindt, of er vacuum is en of er een beker lossen wordt gegeven.
	//
	
	CASE Me_BlokState OF
		OVERZETTERDUT.ISLINKS:
			//
			// Als de arm links is moet er eerst een vacuum opgebouwd worden alvorens het blokje 
			// opgepakt kan worden. Daarna verandert de state. Er ligt alleen een blokje links
			// als het magazijn er een heeft uitgestoten (SIM.Vx_MagBlokKlaar).
			//
			
			SIM.Vx_OvzBlokGevallen 	 := INVISABLE;
			SIM.Vx_OvzBlokLinks 	 := NOT SIM.Vx_MagBlokKlaar;
			SIM.Vx_OvzBlokOverzetter := INVISABLE;
			SIM.Vx_OvzBlokRechts 	 := INVISABLE;
			
			IF (GVL.Qx_VacuumAan AND SIM.Vx_OvzVacuumError AND GVL.Ix_OverzetterIsLinks) AND (NOT GVL.Qx_BekerLossen) THEN
				Mi_VacuumCntr := Mi_VacuumCntr + 1;
			END_IF
			
			IF (NOT GVL.Qx_VacuumAan AND SIM.Vx_OvzVacuumError) THEN
				Mi_VacuumCntr := 0;
			END_IF

			GVL.Ix_VacuumAanwezig := (Mi_VacuumCntr > 50);
	
			IF  ( GVL.Ix_VacuumAanwezig AND (Me_OvzState = OVERZETTERDUT.INHETMIDDEN)) THEN
				// Het blok wordt opgepakt en krijgt de kleur van het blok uit het magazijn.
				// Lag er geen blok klaar, dan beweegt de arm leeg (en komt er niets op de afgifteplaats).
				Mx_MetBeker := SIM.Vx_MagBlokKlaar;
				SIM.Vx_MagBlokKlaar := FALSE;
				SIM.Vw_OvzKleur := SIM.Vw_MagKleurAfgifte;
				Me_BlokState := OVERZETTERDUT.INHETMIDDEN;
			END_IF
			
		OVERZETTERDUT.INHETMIDDEN:
			//
			// Het blokje is in beweging zolang er vacuum is. Als er geen vacuum meer is
			// valt het blokje... Indien de arm helemaal rechts is kan het blokje gelost 
			// worden op de afgifteplaats. Dit moet met een Bekerlossen ondanks het feit dat er
			// geen vacuum meer is....
			//
			
			SIM.Vx_OvzBlokGevallen 	 := INVISABLE;
			SIM.Vx_OvzBlokLinks 	 := NOT SIM.Vx_MagBlokKlaar;
			SIM.Vx_OvzBlokOverzetter := NOT Mx_MetBeker;
			SIM.Vx_OvzBlokRechts 	 := INVISABLE;

		 	IF (GVL.Ix_OverzetterIsRechts) AND (NOT GVL.Qx_VacuumAan) AND (GVL.Qx_BekerLossen) THEN
				GVL.Ix_VacuumAanwezig := FALSE;
				IF Mx_MetBeker THEN
					// Beker komt op de afgifteplaats: zelfde kleur, teller omhoog.
					SIM.Vw_AfgifteKleur  := SIM.Vw_OvzKleur;
					SIM.Vx_AfgifteBeker  := VISABLE;
					SIM.Vi_AfgifteTeller := SIM.Vi_AfgifteTeller + 1;
				END_IF
				Me_BlokState := OVERZETTERDUT.ISRECHTS;		
				RETURN;		
			END_IF
			
			IF (NOT GVL.Ix_OverzetterIsRechts) AND (NOT GVL.Ix_OverzetterIsLinks) AND(NOT GVL.Qx_VacuumAan) THEN
				GVL.Ix_VacuumAanwezig := FALSE;
				Me_BlokState := OVERZETTERDUT.GEVALLEN;				
			END_IF

		OVERZETTERDUT.ISRECHTS:	
		    // 
			// Blokje is gelost op de afgifteplaats. Nu is het wachten tot de overzetter terug naar links wordt gestuurd.
			//
			
			SIM.Vx_OvzBlokGevallen 	 := INVISABLE;
			SIM.Vx_OvzBlokLinks 	 := NOT SIM.Vx_MagBlokKlaar;
			SIM.Vx_OvzBlokOverzetter := INVISABLE;
			SIM.Vx_OvzBlokRechts 	 := INVISABLE;
			
			IF (NOT GVL.Ix_OverzetterIsRechts) THEN
				Mx_MetBeker := FALSE;
				Me_BlokState := OVERZETTERDUT.ISLINKS;					
			END_IF

		OVERZETTERDUT.GEVALLEN:
			//
			// Blokje is gevallen..... Situatie herstelt zich zodra de arm helemaal links staat.
			//
				
			SIM.Vx_OvzBlokGevallen 	 := NOT Mx_MetBeker;
			SIM.Vx_OvzBlokLinks 	 := NOT SIM.Vx_MagBlokKlaar;
			SIM.Vx_OvzBlokOverzetter := INVISABLE;
			SIM.Vx_OvzBlokRechts 	 := INVISABLE;
			
			IF (GVL.Ix_OverzetterIsLinks) THEN
				Mx_MetBeker := FALSE;
				Me_BlokState := OVERZETTERDUT.ISLINKS;					
			END_IF				
	END_CASE
