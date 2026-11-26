(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD noodstop
VAR_INPUT
END_VAR
(*#### IMPLEMENTATIE ####*)
eState 				:= magazijnStates.error;
IO.Qx_BekerUitstoten 	:= FALSE;
