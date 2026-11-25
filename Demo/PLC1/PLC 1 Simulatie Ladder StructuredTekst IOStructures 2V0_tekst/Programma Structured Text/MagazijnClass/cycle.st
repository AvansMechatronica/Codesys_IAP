(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD cycle
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)

CASE eState OF
	//magazijnStates.idle:
	//magazijnStates.in:
	magazijnStates.travel_out:
		IF IO.Ix_UitstoterBekerUit THEN
			eState 			:= magazijnStates.out;	
			IO.Qx_BekerUitstoten 	:= FALSE;
		END_IF
	magazijnStates.out:
		eState 				:= magazijnStates.travel_in;	
	magazijnStates.travel_in:
		IF IO.Ix_UitstoterBekerIn THEN
			eState 			:= magazijnStates.in;
			xKlaar			:= True;	
		END_IF
	
	//magazijnStates.error:
END_CASE
