(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD noodstop
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
//Transportband aan
IO.Qx_MotorAfvoerAan 		:= FALSE;
IO.Qx_StopperUit 			:= FALSE;
//Uitsorteren is bezet
IO.Qx_StationBezet 		:= FALSE;

eState := sorteerStates.error;
uitvoerGoot1.noodstop();
uitvoerGoot2.noodstop();
uitvoerGoot3.noodstop();
