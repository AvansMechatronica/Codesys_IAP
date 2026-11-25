(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD gaIn
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
IF NOT (eState = uitvoerGootStates.is_uit) THEN
	eState := uitvoerGootStates.error;
	return;
END_IF

IO.Qx_UitvoerGootUit := FALSE;
eState := uitvoerGootStates.ga_in;
