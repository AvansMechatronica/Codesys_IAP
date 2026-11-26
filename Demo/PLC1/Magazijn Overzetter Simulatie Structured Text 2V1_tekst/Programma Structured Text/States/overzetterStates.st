(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE overzetterStates :
(
	idle := 0,
	is_links,
	vaccuum_aanzetten,
	ga_naar_rechts,
	is_rechts,
	vaccuum_lossen,
	ga_naar_midden,
	is_midden,
	ga_naar_links,
	error
);
END_TYPE
