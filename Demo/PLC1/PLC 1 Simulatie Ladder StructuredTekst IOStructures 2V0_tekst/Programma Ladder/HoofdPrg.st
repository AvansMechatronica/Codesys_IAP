(*#### DECLARATIE ####*)
PROGRAM HoofdPrg
VAR_INPUT
	// Reset het programma
	Px_HoofdReset: BOOL;
	// Start het programma
	Px_HoofdStart: BOOL;
	// Reset de SFC bv Noodstop
	SFCInit: BOOL;
END_VAR
VAR_OUTPUT
	// Er is een error op getreden
	Px_HoofdError: BOOL;
	// Commando is uitgevoerd
	Px_HoofdGereed: BOOL;
	// Programma is bezig
	Px_HoofdBezig: BOOL;
	// Programma is aan het opstarten
	Px_HoofdOpstart: BOOL;
END_VAR


