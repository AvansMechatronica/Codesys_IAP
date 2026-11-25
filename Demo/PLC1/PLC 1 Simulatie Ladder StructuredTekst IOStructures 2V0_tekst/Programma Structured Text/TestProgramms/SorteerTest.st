(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
PROGRAM SorteerTest
VAR
	xInitialaized			: BOOL := FALSE;

	sorteerGootIO			: sorteerGootIO;
	
	sorteerGoot				: SorteerGootClass;
END_VAR

(*#### IMPLEMENTATIE ####*)
IF NOT xInitialaized THEN

	// Forse Persluct aanwezig
	gvl.Ix_PersluchtAanwezig := TRUE;
	
	//Product is naar een van de goten gegaan
	sorteerGootIO.Ix_BekerInGoot 		REF= gvl.Ix_BekerInGoot;
	//Pusher uitvoergoot 1 is in
	sorteerGootIO.Ix_UitvoerGoot1IsIn 	REF= gvl.Ix_UitvoerGoot1IsIn;
	//Pusher uitvoergoot 2 is in
	sorteerGootIO.Ix_UitvoerGoot2IsIn 	REF= gvl.Ix_UitvoerGoot2IsIn;
	sorteerGootIO.Ix_UitvoerGoot3IsIn 	REF= gvl.Ix_UitvoerGoot3IsIn;
	//Beker afvoeren is bezig
	sorteerGootIO.Ix_StationAfvoerVrij	REF= gvl.Ix_StationAfvoerVrij;
	//Pusher uitvoergoot 1 is uit
	sorteerGootIO.Ix_UitvoerGoot1IsUit	REF= gvl.Ix_UitvoerGoot1IsUit;
	//Pusher uitvoergoot 2 is uit
	sorteerGootIO.Ix_UitvoerGoot2IsUit	REF= gvl.Ix_UitvoerGoot2IsUit;
	sorteerGootIO.Ix_UitvoerGoot3IsUit	REF= gvl.Ix_UitvoerGoot3IsUit;

	//Transportband aan
	sorteerGootIO.Qx_MotorAfvoerAan 	REF= gvl.Qx_MotorAfvoerAan;
	//Pusher goot 1 uit
	sorteerGootIO.Qx_UitvoerGoot1Uit 	REF= gvl.Qx_UitvoerGoot1Uit;
	//Pusher goot 2 uit
	sorteerGootIO.Qx_UitvoerGoot2Uit 	REF= gvl.Qx_UitvoerGoot2Uit;
	sorteerGootIO.Qx_UitvoerGoot3Uit 	REF= gvl.Qx_UitvoerGoot3Uit;
	//Beker stoppen op band voor detectie
	sorteerGootIO.Qx_StopperUit 		REF= gvl.Qx_StopperUit;
	//Uitsorteren is bezet
	sorteerGootIO.Qx_StationBezet 		REF= gvl.Qx_StationBezet;

	//Beker aanwezig op detectiepositie
	sorteerGootIO.meetstation.Ix_BekerAanwezig 		REF= gvl.Ix_BekerAanwezig;
	//Beker is van aluminium
	sorteerGootIO.meetstation.Ix_BekerMetaal 			REF= gvl.Ix_BekerMetaal;
	//Beker reflecteert en is dus niet zwart
	sorteerGootIO.meetstation.Ix_BekerReflecteerd 	REF= gvl.Ix_BekerReflecteerd;

	sorteerGootIO.uitvoerGoot1.Ix_UitvoerGootIsIn 	REF= gvl.Ix_UitvoerGoot1IsIn;
	sorteerGootIO.uitvoerGoot1.Ix_UitvoerGootIsUit 	REF= gvl.Ix_UitvoerGoot1IsUit;
	sorteerGootIO.uitvoerGoot1.Qx_UitvoerGootUit 		REF= gvl.Qx_UitvoerGoot1Uit;
	
	sorteerGootIO.uitvoerGoot2.Ix_UitvoerGootIsIn 	REF= gvl.Ix_UitvoerGoot2IsIn;
	sorteerGootIO.uitvoerGoot3.Ix_UitvoerGootIsIn 	REF= gvl.Ix_UitvoerGoot3IsIn;
	sorteerGootIO.uitvoerGoot2.Ix_UitvoerGootIsUit 	REF= gvl.Ix_UitvoerGoot2IsUit;
	sorteerGootIO.uitvoerGoot3.Ix_UitvoerGootIsUit 	REF= gvl.Ix_UitvoerGoot3IsUit;
	sorteerGootIO.uitvoerGoot2.Qx_UitvoerGootUit 		REF= gvl.Qx_UitvoerGoot2Uit;
	sorteerGootIO.uitvoerGoot3.Qx_UitvoerGootUit 		REF= gvl.Qx_UitvoerGoot3Uit;
	
	
	sorteerGoot.initialize(sorteerGootIO);

	xInitialaized	:= TRUE;
END_IF

IF Ix_Startknop THEN
	sorteerGoot.start();
	Ix_Startknop := FALSE;
END_IF

IF Ix_Resetknop THEN
	sorteerGoot.reset();
END_IF

IF Ix_Noodstop THEN
	sorteerGoot.noodstop();
END_IF

IF SIM.Ix_GotenLegen THEN
	sorteerGoot.productTellerReset();
END_IF

Qx_GroeneLamp := sorteerGoot.isKlaar();
Qx_RodeLamp := sorteerGoot.isError();
Qx_GeleLamp := sorteerGoot.isGootVol();
 
sorteerGoot.cycle();
