(*#### DECLARATIE ####*)
// Datum : 26 november 2026, Auteur: Gerard Harkema
METHOD isError : BOOL
VAR_INPUT
END_VAR
(*#### IMPLEMENTATIE ####*)
isError := (eState = stationStates.error);
