(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
TYPE meetstationIO :
STRUCT
	//Beker aanwezig op detectiepositie
	Ix_BekerAanwezig :REFERENCE TO BOOL;
	//Beker is van aluminium
	Ix_BekerMetaal :REFERENCE TO BOOL;
	//Beker reflecteert en is dus niet zwart
	Ix_BekerReflecteerd :REFERENCE TO BOOL;
END_STRUCT
END_TYPE

