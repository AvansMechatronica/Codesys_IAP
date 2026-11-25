(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD reset
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
uitvoerGoot1.reset();
uitvoerGoot2.reset();
uitvoerGoot3.reset();
//Transportband aan
IO.Qx_MotorAfvoerAan 		:= FALSE;
//Beker stoppen op band voor detectie
IO.Qx_StopperUit 			:= FALSE;
//Uitsorteren is bezet
IO.Qx_StationBezet 		:= FALSE;

aantal_in_goot1			:= 0;
aantal_in_goot2			:= 0;
aantal_in_goot3			:= 0;
aantal_in_goot4			:= 0;

eState := sorteerStates.reset_error;

