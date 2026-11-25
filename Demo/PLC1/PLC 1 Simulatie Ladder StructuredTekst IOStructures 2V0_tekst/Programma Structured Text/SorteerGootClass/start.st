(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD start : BOOL
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
IF NOT (eState = sorteerStates.wacht_op_start) THEN
	IO.Qx_StopperUit			:= FALSE;
	IO.Qx_MotorAfvoerAan 		:= FALSE;
	eState := sorteerStates.error;
	RETURN;
END_IF
//Transportband aan
IO.Qx_StopperUit			:= TRUE;
IO.Qx_MotorAfvoerAan 		:= TRUE;
eState := sorteerStates.stopper_uit;

