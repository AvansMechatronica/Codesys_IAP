(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD isKlaar : BOOL
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
isKlaar := eState = sorteerStates.wacht_op_start;
