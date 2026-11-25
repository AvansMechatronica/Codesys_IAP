(*#### DECLARATIE ####*)
PROGRAM MagazijnPrg

VAR_INPUT
	// Reset het magazijn na start of error
	Px_MagazijnReset: BOOL;
	// Start uitstoten
	Px_MagazijnStart: BOOL;

	// Reset de SFC bv Noodstop
	SFCInit: BOOL;
	// Enable runtime limit checks
	SFCEnableLimit: BOOL := TRUE;	
	// Reset runtime error
	SFCQuitError : BOOL;
END_VAR

VAR_OUTPUT
	// Er is een error opgetreden
	Px_MagazijnError: BOOL;
	// Commando is uitgevoerd
	Px_MagazijnGereed: BOOL;
	// Bezig met uitvoeren van commando
	Px_MagazijnBezig: BOOL;
	// Runtime limit is opgetreden
	SFCError: BOOL;	
END_VAR

VAR
	// Tijdsvertraging voor fouten
	Mx_Error: BOOL;
END_VAR

