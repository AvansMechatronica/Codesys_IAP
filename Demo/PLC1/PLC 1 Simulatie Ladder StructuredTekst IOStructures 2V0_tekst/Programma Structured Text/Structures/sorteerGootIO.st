(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
TYPE sorteerGootIO :
STRUCT
		//Product is naar een van de goten gegaan
	Ix_BekerInGoot 			:REFERENCE TO BOOL;
	//Pusher uitvoergoot 1 is in
	Ix_UitvoerGoot1IsIn 	:REFERENCE TO BOOL;
	//Pusher uitvoergoot 2 is in
	Ix_UitvoerGoot2IsIn 	:REFERENCE TO BOOL;
	//Pusher uitvoergoot 3 is in
	Ix_UitvoerGoot3IsIn 	:REFERENCE TO BOOL;
	//Beker afvoeren is bezig
	Ix_StationAfvoerVrij 	:REFERENCE TO BOOL;
	//Pusher uitvoergoot 1 is uit
	Ix_UitvoerGoot1IsUit 	:REFERENCE TO BOOL;
	//Pusher uitvoergoot 2 is uit
	Ix_UitvoerGoot2IsUit 	:REFERENCE TO BOOL;
	//Pusher uitvoergoot 3 is uit
	Ix_UitvoerGoot3IsUit 	:REFERENCE TO BOOL;

	//Transportband aan
	Qx_MotorAfvoerAan 		:REFERENCE TO BOOL;
	//Pusher goot 1 uit
	Qx_UitvoerGoot1Uit 		:REFERENCE TO BOOL;
	//Pusher goot 2 uit
	Qx_UitvoerGoot2Uit 		:REFERENCE TO BOOL;
	//Pusher goot 3 uit
	Qx_UitvoerGoot3Uit 		:REFERENCE TO BOOL;
	//Beker stoppen op band voor detectie
	Qx_StopperUit 			:REFERENCE TO BOOL;
	//Uitsorteren is bezet
	Qx_StationBezet 		:REFERENCE TO BOOL;
	
	uitvoerGoot1			:uitvoerGootIO;
	uitvoerGoot2			:uitvoerGootIO;
	uitvoerGoot3			:uitvoerGootIO;
	meetstation				:meetstationIO;

 
END_STRUCT
END_TYPE

