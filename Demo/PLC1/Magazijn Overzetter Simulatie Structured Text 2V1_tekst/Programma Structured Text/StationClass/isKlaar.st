(*#### DECLARATIE ####*)
// Datum : 26 november 2026, Auteur: Gerard Harkema
METHOD isKlaar : BOOL
VAR_INPUT
END_VAR
(*#### IMPLEMENTATIE ####*)
isKlaar := (eState = stationStates.idle)
		AND magazijn.isKlaar()
		AND overzetter.isKlaar();
