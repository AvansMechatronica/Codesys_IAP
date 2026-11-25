(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD reset
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
IO.Qx_BekerLossen			:= FALSE;
IO.Qx_VacuumAan				:= FALSE;
IO.Qx_OverzetterLinks		:= FALSE;
IO.Qx_OverzetterRechts		:= TRUE;
eState 						:= overzetterStates.ga_naar_rechts;
