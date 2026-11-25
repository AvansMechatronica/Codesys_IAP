(*#### DECLARATIE ####*)
VAR_GLOBAL
	// Indrukken resetknop 
	Ix_Resetknop: BOOL;
	// Keuzeknop staat op hand
	Ix_Hand: BOOL;
	// Keuzeknop staat op auto
	Ix_Auto: BOOL;
	// Indrukken noodstop
	Ix_Noodstop: BOOL;
	// Bekers magazijn zijn op
	Ix_MagazijnLeeg: BOOL;
	// Beker is uit dekselmagazijn gestoten
	Ix_UitstoterBekerIn: BOOL;
	// Uitstoter Beker haalt nieuwe beker op
	Ix_UitstoterBekerUit: BOOL;
	// Indrukken startknop
	Ix_Stopknop: BOOL := TRUE;
	// Indrukken stopknop
	Ix_Startknop: BOOL;	
	//Perslucht is aanwezig
	Ix_PersluchtAanwezig :BOOL;
	//Werkstuk door overzetter opgepakt
	Ix_VacuumAanwezig :BOOL;
	//Overzetter haalt beker op(linker pos.)
	Ix_OverzetterIsLinks :BOOL;
	//Overzetter plaatst beker op sorteerpositie
	Ix_OverzetterIsRechts :BOOL;
	//Beker aanwezig op detectiepositie
	Ix_BekerAanwezig :BOOL;
	//Beker is van aluminium
	Ix_BekerMetaal :BOOL;
	//Beker reflecteert en is dus niet zwart
	Ix_BekerReflecteerd :BOOL;
	//Product is naar een van de goten gegaan
	Ix_BekerInGoot :BOOL;
	//Pusher uitvoergoot 1 is in
	Ix_UitvoerGoot1IsIn :BOOL;
	//Pusher uitvoergoot 2 is in
	Ix_UitvoerGoot2IsIn :BOOL;
	//Pusher uitvoergoot 3 is in
	Ix_UitvoerGoot3IsIn :BOOL;
	//Beker afvoeren is bezig
	Ix_StationAfvoerVrij :BOOL;
	//Pusher uitvoergoot 1 is uit
	Ix_UitvoerGoot1IsUit :BOOL;
	//Pusher uitvoergoot 2 is uit
	Ix_UitvoerGoot2IsUit :BOOL;
	//Pusher uitvoergoot 3 is uit
	Ix_UitvoerGoot3IsUit :BOOL;
	// Beker uit magazijn stoten
	Qx_BekerUitstoten: BOOL;	
	//Beker oppakken
	Qx_VacuumAan :BOOL;
	//Beker loslaten
	Qx_BekerLossen :BOOL;
	//Overzetter naar bekermagazijn
	Qx_OverzetterLinks :BOOL;
	//Overzetter naar sorteerpositie
	Qx_OverzetterRechts :BOOL;
	//Transportband aan
	Qx_MotorAfvoerAan :BOOL;
	//Pusher goot 1 uit
	Qx_UitvoerGoot1Uit :BOOL;
	//Pusher goot 2 uit
	Qx_UitvoerGoot2Uit :BOOL;
	//Pusher goot 3 uit
	Qx_UitvoerGoot3Uit :BOOL;
	//Beker stoppen op band voor detectie
	Qx_StopperUit :BOOL;
	//Uitsorteren is bezet
	Qx_StationBezet :BOOL;
	// Visualisatie invisible Gele vlak
	Qx_GeleLamp: BOOL;
	// Visualisatie invisible groene vlak
	Qx_GroeneLamp: BOOL;
	// Visualisatie invisible rode vlak
	Qx_RodeLamp: BOOL;
	
END_VAR
