(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD start : BOOL
VAR_INPUT
END_VAR
(*#### IMPLEMENTATIE ####*)
IF NOT (eState = overzetterStates.is_midden) THEN
	eState 				:= overzetterStates.error;
//	IO.Qx_BekerUitstoten 	:= FALSE;
	start 	:= TRUE; // Failed
	RETURN;	
END_IF

xKlaar 					:= FALSE;
IO.Qx_OverzetterLinks 		:= TRUE;
eState 					:= overzetterStates.ga_naar_links;

start			:= FALSE; // oké
