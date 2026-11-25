(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD initialize
VAR_INPUT
	IORef 							:REFERENCE TO 	sorteerGootIO;
END_VAR

(*#### IMPLEMENTATIE ####*)
IO 	REF= IORef;


meetstation.initialize(IO.meetstation);
					   
uitvoerGoot1.initialize(IO.uitvoerGoot1);

uitvoerGoot2.initialize(IO.uitvoerGoot2);

uitvoerGoot3.initialize(IO.uitvoerGoot3);
	
eState := sorteerStates.wacht_op_start;
