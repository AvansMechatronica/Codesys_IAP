(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD isIn : BOOL
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
isIn := (eState = uitvoerGootStates.is_in);
