(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE magazijnStates :
(
	idle := 0,
	in,
	travel_out,
	out,
	travel_in,
	error
);
END_TYPE
