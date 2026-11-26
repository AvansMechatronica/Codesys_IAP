(*#### DECLARATIE ####*)
// Datum : 26 november 2026, Auteur: Gerard Harkema
METHOD cycle
VAR
END_VAR
(*#### IMPLEMENTATIE ####*)
// Eerst de objecten
magazijn.cycle();
overzetter.cycle();

// Dan de fouten: een fout in een object zet het hele station in error
IF magazijn.isError() OR overzetter.isError() THEN
	eState := stationStates.error;
END_IF

// Dan de coordinatie, volgens het statediagram van StationClass
CASE eState OF
	stationStates.idle:
		; // wacht op start()

	stationStates.magazijn_uitstoten:
		IF magazijn.start() THEN		// TRUE = mislukt
			eState := stationStates.error;
		ELSE
			eState := stationStates.wacht_magazijn_klaar;
		END_IF

	stationStates.wacht_magazijn_klaar:
		IF magazijn.isKlaar() THEN
			eState := stationStates.overzetten;
		END_IF

	stationStates.overzetten:
		IF overzetter.start() THEN		// TRUE = mislukt
			eState := stationStates.error;
		ELSE
			eState := stationStates.wacht_overzetter_klaar;
		END_IF

	stationStates.wacht_overzetter_klaar:
		IF overzetter.isKlaar() THEN
			eState := stationStates.idle;
		END_IF

	stationStates.error:
		; // wacht op reset()
END_CASE
