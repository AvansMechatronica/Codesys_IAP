(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
PROGRAM MagazijnTest
VAR
	xInitialaized				: BOOL := FALSE;
	
	magazijnIO					: magazijnIO;
	
	// Bekers magazijn zijn op
	Ix_MagazijnLeegRef			: REFERENCE TO BOOL;
	// Beker is uit dekselmagazijn gestoten
	Ix_UitstoterBekerInRef		: REFERENCE TO BOOL;
	// Uitstoter Beker haalt nieuwe beker op
	Ix_UitstoterBekerUitRef		: REFERENCE TO BOOL;
	// Beker uit magazijn stoten
	Qx_BekerUitstotenRef		: REFERENCE TO BOOL;
	
	magazijn: MagazijnClass;
	
END_VAR
(*#### IMPLEMENTATIE ####*)
IF NOT xInitialaized THEN

	// Forse Persluct aanwezig
	gvl.Ix_PersluchtAanwezig := TRUE;
	magazijnIO.Ix_PersluchtAanwezig		REF= gvl.Ix_PersluchtAanwezig;
	magazijnIO.Ix_MagazijnLeeg			REF= gvl.Ix_MagazijnLeeg;
	magazijnIO.Ix_UitstoterBekerIn 		REF= gvl.Ix_UitstoterBekerIn;
	magazijnIO.Ix_UitstoterBekerUit 	REF= gvl.Ix_UitstoterBekerUit;
	magazijnIO.Qx_BekerUitstoten 		REF= gvl.Qx_BekerUitstoten;

	magazijn.initialize(magazijnIO);

	xInitialaized	:= TRUE;
END_IF

IF Ix_Startknop THEN
	magazijn.start();
	Ix_Startknop := FALSE;
END_IF

IF Ix_Resetknop THEN
	magazijn.reset();
END_IF

IF Ix_Noodstop THEN
	magazijn.noodstop();
END_IF

Qx_GroeneLamp := magazijn.isKlaar();
Qx_RodeLamp := magazijn.isError();
Qx_GeleLamp := magazijn.isMagazijnLeeg();
 
magazijn.cycle();
