(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
PROGRAM Main
VAR
	sorteerStationIO	: sorteerStationIO;
	sorteerStation 		: SorteerStationClass;
	initialized 		: BOOL := FALSE;
	sorteerStationIORef	: REFERENCE TO sorteerStationIO;
END_VAR

(*#### IMPLEMENTATIE ####*)
IF NOT initialized THEN
	// Forse Persluct aanwezig
	gvl.Ix_PersluchtAanwezig 								:= TRUE;

		// Indrukken resetknop 
	sorteerStationIO.hmi.Ix_Resetknop 					REF= Ix_Resetknop;
	// Keuzeknop staat op hand
	sorteerStationIO.hmi.Ix_Hand 						REF= gvl.Ix_Hand;
	// Keuzeknop staat op auto
	sorteerStationIO.hmi.Ix_Auto 						REF= gvl.Ix_Auto;
	// Indrukken noodstop
	sorteerStationIO.hmi.Ix_Noodstop 					REF= gvl.Ix_Noodstop;
	// Bekers magazijn zijn op

	// Indrukken startknop
	sorteerStationIO.hmi.Ix_Stopknop 					REF= gvl.Ix_Stopknop;
	// Indrukken stopknop
	sorteerStationIO.hmi.Ix_Startknop 					REF= gvl.Ix_Startknop;	
	//Perslucht is aanwezig

	// Visualisatie invisible Gele vlak
	sorteerStationIO.hmi.Qx_GeleLamp 					REF= gvl.Qx_GeleLamp;
	// Visualisatie invisible groene vlak
	sorteerStationIO.hmi.Qx_GroeneLamp 					REF= gvl.Qx_GroeneLamp;
	// Visualisatie invisible rode vlak
	sorteerStationIO.hmi.Qx_RodeLamp 					REF= gvl.Qx_RodeLamp;

	sorteerStationIO.magazijn.Ix_PersluchtAanwezig		REF= gvl.Ix_PersluchtAanwezig;
	sorteerStationIO.magazijn.Ix_MagazijnLeeg			REF= gvl.Ix_MagazijnLeeg;
	sorteerStationIO.magazijn.Ix_UitstoterBekerIn 		REF= gvl.Ix_UitstoterBekerIn;
	sorteerStationIO.magazijn.Ix_UitstoterBekerUit 		REF= gvl.Ix_UitstoterBekerUit;
	sorteerStationIO.magazijn.Qx_BekerUitstoten 		REF= gvl.Qx_BekerUitstoten;

	//Werkstuk door overzetter opgepakt
	sorteerStationIO.overzetter.Ix_VacuumAanwezig 		REF= gvl.Ix_VacuumAanwezig;
	//Overzetter haalt beker op(linker pos.)
	sorteerStationIO.overzetter.Ix_OverzetterIsLinks 	REF= gvl.Ix_OverzetterIsLinks;
	//Overzetter plaatst beker op sorteerpositie
	sorteerStationIO.overzetter.Ix_OverzetterIsRechts 	REF= gvl.Ix_OverzetterIsRechts;
	//Beker aanwezig op detectiepositie
	
		//Beker oppakken
	sorteerStationIO.overzetter.Qx_VacuumAan 			REF= gvl.Qx_VacuumAan;
	//Beker loslaten
	sorteerStationIO.overzetter.Qx_BekerLossen 			REF= gvl.Qx_BekerLossen;
	//Overzetter naar bekermagazijn
	sorteerStationIO.overzetter.Qx_OverzetterLinks		REF= gvl.Qx_OverzetterLinks;
	//Overzetter naar sorteerpositie
	sorteerStationIO.overzetter.Qx_OverzetterRechts 	REF= gvl.Qx_OverzetterRechts;

	
		//Product is naar een van de goten gegaan
	sorteerStationIO.sorteerGoot.Ix_BekerInGoot 		REF= gvl.Ix_BekerInGoot;
	//Pusher uitvoergoot 1 is in
	sorteerStationIO.sorteerGoot.Ix_UitvoerGoot1IsIn 	REF= gvl.Ix_UitvoerGoot1IsIn;
	//Pusher uitvoergoot 2 is in
	sorteerStationIO.sorteerGoot.Ix_UitvoerGoot2IsIn 	REF= gvl.Ix_UitvoerGoot2IsIn;
	sorteerStationIO.sorteerGoot.Ix_UitvoerGoot3IsIn 	REF= gvl.Ix_UitvoerGoot3IsIn;
	//Beker afvoeren is bezig
	sorteerStationIO.sorteerGoot.Ix_StationAfvoerVrij	REF= gvl.Ix_StationAfvoerVrij;
	//Pusher uitvoergoot 1 is uit
	sorteerStationIO.sorteerGoot.Ix_UitvoerGoot1IsUit	REF= gvl.Ix_UitvoerGoot1IsUit;
	//Pusher uitvoergoot 2 is uit
	sorteerStationIO.sorteerGoot.Ix_UitvoerGoot2IsUit	REF= gvl.Ix_UitvoerGoot2IsUit;
	sorteerStationIO.sorteerGoot.Ix_UitvoerGoot3IsUit	REF= gvl.Ix_UitvoerGoot3IsUit;

	//Transportband aan
	sorteerStationIO.sorteerGoot.Qx_MotorAfvoerAan 		REF= gvl.Qx_MotorAfvoerAan;
	//Pusher goot 1 uit
	sorteerStationIO.sorteerGoot.Qx_UitvoerGoot1Uit 	REF= gvl.Qx_UitvoerGoot1Uit;
	//Pusher goot 2 uit
	sorteerStationIO.sorteerGoot.Qx_UitvoerGoot2Uit 	REF= gvl.Qx_UitvoerGoot2Uit;
	sorteerStationIO.sorteerGoot.Qx_UitvoerGoot3Uit 	REF= gvl.Qx_UitvoerGoot3Uit;
	//Beker stoppen op band voor detectie
	sorteerStationIO.sorteerGoot.Qx_StopperUit 			REF= gvl.Qx_StopperUit;
	//Uitsorteren is bezet
	sorteerStationIO.sorteerGoot.Qx_StationBezet 		REF= gvl.Qx_StationBezet;

	//Beker aanwezig op detectiepositie
	sorteerStationIO.sorteerGoot.meetstation.Ix_BekerAanwezig 			REF= gvl.Ix_BekerAanwezig;
	//Beker is van aluminium
	sorteerStationIO.sorteerGoot.meetstation.Ix_BekerMetaal 			REF= gvl.Ix_BekerMetaal;
	//Beker reflecteert en is dus niet zwart
	sorteerStationIO.sorteerGoot.meetstation.Ix_BekerReflecteerd 		REF= gvl.Ix_BekerReflecteerd;

	sorteerStationIO.sorteerGoot.uitvoerGoot1.Ix_UitvoerGootIsIn 		REF= gvl.Ix_UitvoerGoot1IsIn;
	sorteerStationIO.sorteerGoot.uitvoerGoot1.Ix_UitvoerGootIsUit 		REF= gvl.Ix_UitvoerGoot1IsUit;
	sorteerStationIO.sorteerGoot.uitvoerGoot1.Qx_UitvoerGootUit 		REF= gvl.Qx_UitvoerGoot1Uit;
	
	sorteerStationIO.sorteerGoot.uitvoerGoot2.Ix_UitvoerGootIsIn 		REF= gvl.Ix_UitvoerGoot2IsIn;
	sorteerStationIO.sorteerGoot.uitvoerGoot3.Ix_UitvoerGootIsIn 		REF= gvl.Ix_UitvoerGoot3IsIn;
	sorteerStationIO.sorteerGoot.uitvoerGoot2.Ix_UitvoerGootIsUit 		REF= gvl.Ix_UitvoerGoot2IsUit;
	sorteerStationIO.sorteerGoot.uitvoerGoot3.Ix_UitvoerGootIsUit 		REF= gvl.Ix_UitvoerGoot3IsUit;
	sorteerStationIO.sorteerGoot.uitvoerGoot2.Qx_UitvoerGootUit 		REF= gvl.Qx_UitvoerGoot2Uit;
	sorteerStationIO.sorteerGoot.uitvoerGoot3.Qx_UitvoerGootUit 		REF= gvl.Qx_UitvoerGoot3Uit;
	
	sorteerStationIORef REF= sorteerStationIO;
	sorteerStation.initialize(sorteerStationIORef);

	initialized := TRUE;
END_IF

sorteerStation.cycle();
