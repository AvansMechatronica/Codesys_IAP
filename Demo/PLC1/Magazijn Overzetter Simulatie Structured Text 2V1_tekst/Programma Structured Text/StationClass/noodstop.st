(*#### DECLARATIE ####*)
// Datum : 26 november 2026, Auteur: Gerard Harkema
METHOD noodstop
VAR_INPUT
END_VAR
(*#### IMPLEMENTATIE ####*)
// Noodstop geeft het station door aan beide objecten
magazijn.noodstop();
overzetter.noodstop();
eState := stationStates.error;
