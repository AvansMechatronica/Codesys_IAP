(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
FUNCTION_BLOCK OverzetterClass
VAR
	IO							: reference to overzetterIO;

	xKlaar						: BOOL := FALSE;
	eState 						: overzetterStates := overzetterStates.idle;
	
	timer						: ton;
END_VAR
(*#### IMPLEMENTATIE ####*)

