(*#### DECLARATIE ####*)
PROGRAM SorterenPrg
VAR_INPUT
	// Reset de sorteren na start of error
	Px_SorterenReset: BOOL;
	// Start het sorteren
	Px_SorterenStart: BOOL;
	
	// Reset de SFC bv Noodstop
	SFCInit: BOOL;
	// Enable runtime limit checks
	SFCEnableLimit: BOOL := TRUE;	
	// Reset runtime error
	SFCQuitError : BOOL;	
END_VAR
VAR_OUTPUT
	// Sorteren heeft een error
	Px_SorterenError: BOOL;
	// Sorteren heeft een opdracht uitgevoerd
	Px_SorterenGereed: BOOL;
	// Sorteren is bezig
	Px_SorterenBezig: BOOL;
	// Runtime limit is opgetreden
	SFCError: BOOL;		
END_VAR

