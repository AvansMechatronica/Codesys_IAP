(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD initialize
VAR_INPUT
	IORef			: REFERENCE TO uitvoerGootIO;

END_VAR

(*#### IMPLEMENTATIE ####*)
//Pusher uitvoergoot is in
IO 	REF=	IORef;
eState := uitvoerGootStates.ga_in;
