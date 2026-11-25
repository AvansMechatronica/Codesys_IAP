(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
PROGRAM UitvoerGootTest
VAR
	xInitialaized				: BOOL := FALSE;
	
	//Pusher uitvoergoo is in
	Ix_UitvoerGootIsInRef 		: REFERENCE TO BOOL;
	//Pusher uitvoergoot is uit
	Ix_UitvoerGootIsUitRef 		: REFERENCE TO BOOL;
	//Pusher goot uit
	Qx_UitvoerGootUitRef 		: REFERENCE TO BOOL;
	
	uitvoerGootIO				: uitvoerGootIO;
	
	uitvoerGoot					: UitvoerGootClass;
	
END_VAR

(*#### IMPLEMENTATIE ####*)
IF NOT xInitialaized THEN

	// Forse Persluct aanwezig
	gvl.Ix_PersluchtAanwezig := TRUE;
	
	//Pusher uitvoergoot is in
	uitvoerGootIO.Ix_UitvoerGootIsIn 	REF= gvl.Ix_UitvoerGoot1IsIn;
	//Pusher uitvoergoot is uit
	uitvoerGootIO.Ix_UitvoerGootIsUit 	REF= gvl.Ix_UitvoerGoot1IsUit;
	//Pusher goot uit
	uitvoerGootIO.Qx_UitvoerGootUit 	REF= gvl.Qx_UitvoerGoot1Uit;
		
	uitvoerGoot.initialize(uitvoerGootIO);

	xInitialaized	:= TRUE;
	Ix_Stopknop := FALSE;
END_IF

IF Ix_Startknop THEN
	uitvoerGoot.gaUit();
	Ix_Startknop := FALSE;
END_IF

IF Ix_Stopknop THEN
	uitvoerGoot.gaIn();
	Ix_Stopknop := FALSE;
END_IF

IF Ix_Resetknop THEN
	uitvoerGoot.reset();
END_IF

IF Ix_Noodstop THEN
	uitvoerGoot.noodstop();
END_IF

Qx_GroeneLamp := uitvoerGoot.isIn();
Qx_RodeLamp := uitvoerGoot.isError();
Qx_GeleLamp := uitvoerGoot.isUit();
 
uitvoerGoot.cycle();
