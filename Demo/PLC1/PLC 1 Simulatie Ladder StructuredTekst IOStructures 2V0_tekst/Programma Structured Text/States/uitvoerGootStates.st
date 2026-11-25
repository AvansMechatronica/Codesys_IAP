(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE uitvoerGootStates :
(
	idle := 0,
	is_in,
	ga_in,
	is_uit,
	ga_uit,
	error
);
END_TYPE

