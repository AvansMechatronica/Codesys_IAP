(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
FUNCTION_BLOCK SorteerStationClass
VAR
	IO				: reference to sorteerStationIO;

	// ******** Magazijn ********/
	magazijn		: MagazijnClass;
	
	// ******** Overzetter ********/
	overzetter		: OverzetterClass;
	
	// ******** Sorteergoot ********/
	sorteergoot		: SorteerGootClass;

	eState 			: sorteerStationStates := sorteerStationStates.idle;
	x_Klaar 		: BOOL := FALSE;
	x_Error 		: BOOL := FALSE;
	x_Enable 		: BOOL := FALSE;

END_VAR

(*#### IMPLEMENTATIE ####*)
// ******** Magazijn ********/
	
// ******** Overzetter ********/

// ******** Sorteergoot ********/

