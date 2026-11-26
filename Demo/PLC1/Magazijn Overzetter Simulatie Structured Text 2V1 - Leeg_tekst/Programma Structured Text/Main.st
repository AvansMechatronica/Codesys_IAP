(*#### DECLARATIE ####*)
// Datum : 26 november 2026, Auteur: Gerard Harkema
// Main is het station: een magazijn en een overzetter, gecoordineerd door StationClass.
// Testen van een los object: vervang in de taakconfiguratie (MainTask) de aanroep van Main
// door MagazijnTest of OverzetterTest (map TestProgramms). De taak Simulatie blijft
// MagazijnSim en OverzetterSim aanroepen.
PROGRAM Main
VAR
	stationIO		: stationIO;
	station			: StationClass;
	initialized		: BOOL := FALSE;
END_VAR
(*#### IMPLEMENTATIE ####*)
IF NOT initialized THEN
	// Forceer perslucht aanwezig
	gvl.Ix_PersluchtAanwezig						:= TRUE;

	// ******** Magazijn ********/
	stationIO.magazijn.Ix_PersluchtAanwezig		REF= gvl.Ix_PersluchtAanwezig;
	stationIO.magazijn.Ix_MagazijnLeeg			REF= gvl.Ix_MagazijnLeeg;
	stationIO.magazijn.Ix_UitstoterBekerIn		REF= gvl.Ix_UitstoterBekerIn;
	stationIO.magazijn.Ix_UitstoterBekerUit		REF= gvl.Ix_UitstoterBekerUit;
	stationIO.magazijn.Qx_BekerUitstoten		REF= gvl.Qx_BekerUitstoten;

	// ******** Overzetter ********/
	//Werkstuk door overzetter opgepakt
	stationIO.overzetter.Ix_VacuumAanwezig		REF= gvl.Ix_VacuumAanwezig;
	//Overzetter haalt beker op (linker pos.)
	stationIO.overzetter.Ix_OverzetterIsLinks	REF= gvl.Ix_OverzetterIsLinks;
	//Overzetter plaatst beker op afgifteplaats (rechter pos.)
	stationIO.overzetter.Ix_OverzetterIsRechts	REF= gvl.Ix_OverzetterIsRechts;
	//Beker oppakken
	stationIO.overzetter.Qx_VacuumAan			REF= gvl.Qx_VacuumAan;
	//Beker loslaten
	stationIO.overzetter.Qx_BekerLossen			REF= gvl.Qx_BekerLossen;
	//Overzetter naar magazijn
	stationIO.overzetter.Qx_OverzetterLinks		REF= gvl.Qx_OverzetterLinks;
	//Overzetter naar afgifteplaats
	stationIO.overzetter.Qx_OverzetterRechts	REF= gvl.Qx_OverzetterRechts;

	station.initialize(stationIO);

	initialized := TRUE;
END_IF

// ******** Bediening ********/
IF gvl.Ix_Startknop THEN
	station.start();
	gvl.Ix_Startknop := FALSE;
END_IF

IF gvl.Ix_Noodstop THEN
	station.noodstop();
END_IF

IF gvl.Ix_Resetknop THEN
	station.reset();
END_IF

// ******** Signalering ********/
gvl.Qx_GroeneLamp	:= station.isKlaar();
gvl.Qx_RodeLamp		:= station.isError();
gvl.Qx_GeleLamp		:= station.isMagazijnLeeg();

station.cycle();
