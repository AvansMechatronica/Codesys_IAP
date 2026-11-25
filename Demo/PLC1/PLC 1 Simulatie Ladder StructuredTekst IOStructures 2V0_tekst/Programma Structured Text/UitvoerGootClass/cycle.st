(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD cycle
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
CASE eState OF
//	uitvoerGootStates.idle:
//	uitvoerGootStates.is_in:
	uitvoerGootStates.ga_in:
	IF IO.Ix_UitvoerGootIsIn THEN
		eState := uitvoerGootStates.is_in;
	END_IF

//	uitvoerGootStates.is_uit:
	uitvoerGootStates.ga_uit:
	IF IO.Ix_UitvoerGootIsUit THEN
		eState := uitvoerGootStates.is_uit;
	END_IF
//	uitvoerGootStates.error:
END_CASE
