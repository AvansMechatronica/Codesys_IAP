(*#### DECLARATIE ####*)
// Datum : 26 november 2026, Auteur: Gerard Harkema
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE stationStates :
(
	idle := 0,
	magazijn_uitstoten,
	wacht_magazijn_klaar,
	overzetten,
	wacht_overzetter_klaar,
	error
);
END_TYPE
