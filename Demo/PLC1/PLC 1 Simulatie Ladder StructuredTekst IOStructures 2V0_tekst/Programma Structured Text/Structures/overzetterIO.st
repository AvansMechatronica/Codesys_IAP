(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
TYPE overzetterIO :
STRUCT
	//Werkstuk door overzetter opgepakt
	Ix_VacuumAanwezig 		:REFERENCE TO BOOL;
	//Overzetter haalt beker op(linker pos.)
	Ix_OverzetterIsLinks 	:REFERENCE TO BOOL;
	//Overzetter plaatst beker op sorteerpositie
	Ix_OverzetterIsRechts 	:REFERENCE TO BOOL;
	//Beker aanwezig op detectiepositie
	
		//Beker oppakken
	Qx_VacuumAan 			:REFERENCE TO BOOL;
	//Beker loslaten
	Qx_BekerLossen 			:REFERENCE TO BOOL;
	//Overzetter naar bekermagazijn
	Qx_OverzetterLinks 		:REFERENCE TO BOOL;
	//Overzetter naar sorteerpositie
	Qx_OverzetterRechts 	:REFERENCE TO BOOL;

END_STRUCT
END_TYPE

