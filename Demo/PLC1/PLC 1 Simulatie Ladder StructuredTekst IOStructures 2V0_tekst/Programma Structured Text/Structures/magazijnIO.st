(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
TYPE magazijnIO :
STRUCT
	// Bekers magazijn zijn op
	Ix_MagazijnLeeg				: REFERENCE TO BOOL;
	// Beker is uit dekselmagazijn gestoten
	Ix_UitstoterBekerIn			: REFERENCE TO BOOL;
	// Uitstoter Beker haalt nieuwe beker op
	Ix_UitstoterBekerUit		: REFERENCE TO BOOL;
	// Beker uit magazijn stoten
	Qx_BekerUitstoten			: REFERENCE TO BOOL;

	//Perslucht is aanwezig
	Ix_PersluchtAanwezig 		: REFERENCE TO BOOL;

END_STRUCT
END_TYPE

