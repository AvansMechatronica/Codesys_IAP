(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
FUNCTION_BLOCK SorteerGootClass
VAR

	IO 						:REFERENCE TO 	sorteerGootIO;
	
	eState					: sorteerStates := sorteerStates.idle;

	xInitialized			: BOOL := FALSE;
	xKlaar					: BOOL := FALSE;
	
	uitvoerGoot1			: UitvoerGootClass;
	uitvoerGoot2			: UitvoerGootClass;
	uitvoerGoot3			: UitvoerGootClass;
	
	meetstation				: MeetstationClass;
	product_type			: productType := productType.onbekend;
	
	aantal_in_goot1			: UINT := 0;
	aantal_in_goot2			: UINT := 0;
	aantal_in_goot3			: UINT := 0;
	aantal_in_goot4			: UINT := 0;
	
//	timer					: TON;

END_VAR

VAR CONSTANT
	product_type_goot1		: productType := productType.metaal_blank;
	product_type_goot2		: productType := productType.kunstof_zwart;
	product_type_goot3		: productType := productType.kunstof_rood;
	product_type_goot4		: productType := productType.metaal_zwart;
END_VAR



(*#### IMPLEMENTATIE ####*)
IF NOT xInitialized THEN

	xInitialized				:= TRUE;

END_IF
