(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD reset : BOOL
VAR_INPUT
END_VAR
(*#### IMPLEMENTATIE ####*)
eState 		:= magazijnStates.travel_in;
// Pas weer klaar als de ruststand bereikt is
xKlaar						:= FALSE;
