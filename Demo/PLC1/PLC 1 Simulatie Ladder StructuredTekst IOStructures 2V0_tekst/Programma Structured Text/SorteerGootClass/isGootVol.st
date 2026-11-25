(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD isGootVol : BOOL
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
isGootVol := eState = sorteerStates.goot_vol;
