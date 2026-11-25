(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD initialize
VAR_INPUT

	IORef		: REFERENCE TO magazijnIO;

END_VAR

(*#### IMPLEMENTATIE ####*)
IO 			REF= IORef;

eState 		:= magazijnStates.travel_in;

