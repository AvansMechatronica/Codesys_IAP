(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD noodstop
VAR_INPUT
END_VAR
(*#### IMPLEMENTATIE ####*)
//Beker oppakken
IO.Qx_VacuumAan 			:=FALSE;
//Beker loslaten
IO.Qx_BekerLossen 			:=FALSE;
//Overzetter naar bekermagazijn
IO.Qx_OverzetterLinks 		:=FALSE;
//Overzetter naar sorteerpositie
IO.Qx_OverzetterRechts 	:=FALSE;

eState 				:= overzetterStates.error;
