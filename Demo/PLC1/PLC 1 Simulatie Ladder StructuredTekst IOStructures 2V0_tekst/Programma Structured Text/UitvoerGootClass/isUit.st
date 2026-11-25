(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD isUit : BOOL
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
isUit := (eState = uitvoerGootStates.is_uit);
