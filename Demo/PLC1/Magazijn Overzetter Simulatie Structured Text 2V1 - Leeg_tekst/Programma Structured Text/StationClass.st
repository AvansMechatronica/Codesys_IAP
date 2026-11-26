(*#### DECLARATIE ####*)
// Datum : 26 november 2026, Auteur: Gerard Harkema
// Station: coordineert een magazijn en een overzetter (compositie).
// De objecten praten alleen via methodes: start(), isKlaar(), isError().
FUNCTION_BLOCK StationClass
VAR
	IO				: REFERENCE TO stationIO;

	// ******** Magazijn ********/
	magazijn		: MagazijnClass;

	// ******** Overzetter ********/
	overzetter		: OverzetterClass;

	eState			: stationStates := stationStates.idle;
END_VAR
(*#### IMPLEMENTATIE ####*)

