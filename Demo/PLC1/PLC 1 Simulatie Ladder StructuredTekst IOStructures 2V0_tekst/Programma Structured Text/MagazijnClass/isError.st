(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD isError : BOOL
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
isError := (eState = magazijnStates.error);
