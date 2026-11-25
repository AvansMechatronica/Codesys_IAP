(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD reset
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
IO.Qx_UitvoerGootUit := FALSE;
eState := uitvoerGootStates.ga_in;
