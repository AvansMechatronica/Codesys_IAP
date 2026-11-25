(*#### DECLARATIE ####*)
PROGRAM OverzetterPrg
VAR_INPUT
	// Reset de overzetter na start of error
	Px_OverzetterReset: BOOL;
	// Start de overzetter
	Px_OverzetterStart: BOOL;
	
	// Reset de SFC bv Noodstop
	SFCInit: BOOL;
	// Enable runtime limit checks
	SFCEnableLimit: BOOL := TRUE;	
	// Reset runtime error
	SFCQuitError : BOOL;	
END_VAR
VAR_OUTPUT
	// Overzetter heeft een error
	Px_OverzetterError: BOOL;
	// Overzetter heeft opdracht uitgevoerd
	Px_OverzetterGereed: BOOL;
	// Overzetter is bezig
	Px_OverzetterBezig: BOOL;
	// Runtime limit is opgetreden
	SFCError: BOOL;		
END_VAR
VAR
	// Tijdsvertraging voor sommige stappen
	Mx_Delay: BOOL;
END_VAR

