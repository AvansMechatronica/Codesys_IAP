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
	//Overzetter plaatst beker op afgifteplaats
	Ix_OverzetterIsRechts :BOOL;
	// Beker uit magazijn stoten
	Qx_BekerUitstoten: BOOL;	
	//Beker oppakken
	Qx_VacuumAan :BOOL;
	//Beker loslaten
	Qx_BekerLossen :BOOL;
	//Overzetter naar bekermagazijn
	Qx_OverzetterLinks :BOOL;
	//Overzetter naar afgifteplaats
	Qx_OverzetterRechts :BOOL;
	// Visualisatie invisible Gele vlak
	Qx_GeleLamp: BOOL;
	// Visualisatie invisible groene vlak
	Qx_GroeneLamp: BOOL;
	// Visualisatie invisible rode vlak
	Qx_RodeLamp: BOOL;
	
END_VAR
