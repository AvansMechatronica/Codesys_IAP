(*#### DECLARATIE ####*)
// Datum : 26 november 2026, Auteur: Gerard Harkema
METHOD reset
VAR_INPUT
END_VAR
(*#### IMPLEMENTATIE ####*)
// Reset geeft het station door aan beide objecten; die gaan eerst naar hun veilige stand
magazijn.reset();
overzetter.reset();
eState := stationStates.idle;
