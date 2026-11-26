(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
FUNCTION_BLOCK MagazijnClass
VAR
	IO							: REFERENCE TO magazijnIO;

	xKlaar						: BOOL := FALSE;
	eState 						: magazijnStates := magazijnStates.idle;
END_VAR
(*#### IMPLEMENTATIE ####*)

