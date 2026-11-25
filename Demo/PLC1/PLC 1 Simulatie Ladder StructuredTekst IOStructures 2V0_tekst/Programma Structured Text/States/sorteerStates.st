(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE sorteerStates :
(
	idle := 0,
	wacht_op_start,
	stopper_uit,
	meten,
	uitvoer_goot_uit,
	transporteren_naar_goot,
	uitvoer_goot_in,
	goot_vol,
	error,
	reset_error
);
END_TYPE

