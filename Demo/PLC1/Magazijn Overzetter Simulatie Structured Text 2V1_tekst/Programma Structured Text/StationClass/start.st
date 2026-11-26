(*#### DECLARATIE ####*)
// Datum : 26 november 2026, Auteur: Gerard Harkema
METHOD start : BOOL
VAR_INPUT
END_VAR
(*#### IMPLEMENTATIE ####*)
// Start een cyclus: een beker uit het magazijn naar de afgifteplaats.
// Kan alleen vanuit idle en als beide objecten in hun ruststand staan.
IF NOT isKlaar() THEN
	start := TRUE; // Failed (station blijft gewoon doorgaan met wat het deed)
	RETURN;
END_IF

eState := stationStates.magazijn_uitstoten;
start := FALSE; // oké
