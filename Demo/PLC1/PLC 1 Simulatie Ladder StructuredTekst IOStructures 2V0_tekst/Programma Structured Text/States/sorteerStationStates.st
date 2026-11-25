(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE sorteerStationStates :
(
	idle := 0,
	wacht_op_klaar,
	wacht_enable,
	product_uitgifte,
	product_overzetten,
	product_sorteren,
	service,
	error
);
END_TYPE

