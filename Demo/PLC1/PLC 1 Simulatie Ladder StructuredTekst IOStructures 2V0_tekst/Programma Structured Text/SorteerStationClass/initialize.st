(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD initialize
VAR_input
	IORef						: REFERENCE TO sorteerStationIO;
END_VAR


(*#### IMPLEMENTATIE ####*)
IO REF= IORef;

// ******** Magazijn ********/
magazijn.initialize(IO.magazijn);
						
// ******** Overzetter ********/
overzetter.initialize(IO.overzetter);

// ******** Sorteergoot ********/
sorteerGoot.initialize(IO.sorteerGoot);


