(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
TYPE uitvoerGootIO :
STRUCT
	//Pusher uitvoergoo is in
	Ix_UitvoerGootIsIn 		: REFERENCE TO BOOL;
	//Pusher uitvoergoot is uit
	Ix_UitvoerGootIsUit 	: REFERENCE TO BOOL;
	//Pusher goot uit
	Qx_UitvoerGootUit 		: REFERENCE TO BOOL;
END_STRUCT
END_TYPE

