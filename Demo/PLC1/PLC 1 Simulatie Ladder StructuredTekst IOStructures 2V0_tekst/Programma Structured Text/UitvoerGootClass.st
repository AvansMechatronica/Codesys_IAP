(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
FUNCTION_BLOCK UitvoerGootClass
VAR
	IO						: REFERENCE TO uitvoerGootIO;
	eState					: uitvoerGootStates := uitvoerGootStates.idle;
END_VAR

(*#### IMPLEMENTATIE ####*)

