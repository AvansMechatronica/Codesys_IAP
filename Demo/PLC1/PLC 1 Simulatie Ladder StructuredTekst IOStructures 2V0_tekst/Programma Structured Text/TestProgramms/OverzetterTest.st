(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
PROGRAM OverzetterTest
VAR
	xInitialaized				: BOOL := FALSE;

	overzetterIO				: overzetterIO;

	overzetter: OverzetterClass;
	
END_VAR

(*#### IMPLEMENTATIE ####*)
IF NOT xInitialaized THEN

	// Forse Persluct aanwezig
	gvl.Ix_PersluchtAanwezig := TRUE;
	
	//Werkstuk door overzetter opgepakt
	overzetterIO.Ix_VacuumAanwezig 		REF= gvl.Ix_VacuumAanwezig;
	//Overzetter haalt beker op(linker pos.)
	overzetterIO.Ix_OverzetterIsLinks 	REF= gvl.Ix_OverzetterIsLinks;
	//Overzetter plaatst beker op sorteerpositie
	overzetterIO.Ix_OverzetterIsRechts 	REF= gvl.Ix_OverzetterIsRechts;
	//Beker aanwezig op detectiepositie
	
		//Beker oppakken
	overzetterIO.Qx_VacuumAan 			REF= gvl.Qx_VacuumAan;
	//Beker loslaten
	overzetterIO.Qx_BekerLossen 			REF= gvl.Qx_BekerLossen;
	//Overzetter naar bekermagazijn
	overzetterIO.Qx_OverzetterLinks		REF= gvl.Qx_OverzetterLinks;
	//Overzetter naar sorteerpositie
	overzetterIO.Qx_OverzetterRechts 	REF= gvl.Qx_OverzetterRechts;

	overzetter.initialize(overzetterIO);

	xInitialaized	:= TRUE;
END_IF

IF Ix_Startknop THEN
	overzetter.start();
	Ix_Startknop := FALSE;
END_IF

IF Ix_Noodstop THEN
	overzetter.noodstop();
END_IF

IF Ix_Resetknop THEN
	overzetter.reset();
END_IF

Qx_GroeneLamp := overzetter.isKlaar();
Qx_RodeLamp := overzetter.isError();
 
overzetter.cycle();
