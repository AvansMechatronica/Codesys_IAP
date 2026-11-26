(*#### DECLARATIE ####*)
// Datum : 26 november 2026, Auteur: Gerard Harkema
METHOD initialize
VAR_INPUT
	IORef			: REFERENCE TO stationIO;
END_VAR
(*#### IMPLEMENTATIE ####*)
IO REF= IORef;

// Elk object krijgt zijn eigen IO-structuur
magazijn.initialize(IO.magazijn);
overzetter.initialize(IO.overzetter);

eState := stationStates.idle;
