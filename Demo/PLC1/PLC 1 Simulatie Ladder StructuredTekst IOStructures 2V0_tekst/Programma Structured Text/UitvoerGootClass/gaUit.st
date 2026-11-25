(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD gaUit
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
IF NOT (eState = uitvoerGootStates.is_in) THEN
	eState := uitvoerGootStates.error;
	return;
END_IF

IO.Qx_UitvoerGootUit := TRUE;
eState := uitvoerGootStates.ga_uit;


