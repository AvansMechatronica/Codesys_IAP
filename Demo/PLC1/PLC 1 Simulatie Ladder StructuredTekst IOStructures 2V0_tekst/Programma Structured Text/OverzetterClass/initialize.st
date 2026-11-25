(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD initialize
VAR_INPUT
	IORef		: REFERENCE TO overzetterIO;
END_VAR

(*#### IMPLEMENTATIE ####*)

IO							REF= IORef;

IO.Qx_BekerLossen			:= FALSE;
IO.Qx_VacuumAan				:= FALSE;
IO.Qx_OverzetterLinks		:= FALSE;
IO.Qx_OverzetterRechts		:= TRUE;
eState 						:= overzetterStates.ga_naar_rechts;

