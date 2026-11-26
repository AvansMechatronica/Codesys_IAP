(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD start : BOOL
VAR_INPUT
END_VAR
(*#### IMPLEMENTATIE ####*)
IF isMagazijnLeeg() THEN
	eState 				:= magazijnStates.error;
	IO.Qx_BekerUitstoten 	:= FALSE;
	start 		:= TRUE; // Failed
	RETURN;
END_IF

IF NOT IO.Ix_PersluchtAanwezig THEN
	eState 				:= magazijnStates.error;
	IO.Qx_BekerUitstoten 	:= FALSE;
	start 		:= TRUE; // Failed
	RETURN;
END_IF

IF NOT (eState = magazijnStates.in) THEN
	eState 				:= magazijnStates.error;
	IO.Qx_BekerUitstoten 	:= FALSE;
	start 		:= TRUE; // Failed
	RETURN;	
END_IF

xKlaar 					:= FALSE;
IO.Qx_BekerUitstoten 		:= TRUE;
eState 					:= magazijnStates.travel_out;

start 			:= FALSE; // oké
