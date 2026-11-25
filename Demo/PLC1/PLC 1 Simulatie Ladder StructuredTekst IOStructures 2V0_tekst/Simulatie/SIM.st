(*#### DECLARATIE ####*)
{attribute 'qualified_only'}
VAR_GLOBAL
	// Rotatie van de overzetter
	Vx_OvzRotate: INT := 0;
	// Visualisatie invisible blok
	Vx_OvzBlokLinks: BOOL := FALSE;
	// Visualisatie invisible blok
	Vx_OvzBlokOverzetter: BOOL := FALSE;
	// Visualisatie invisible blok
	Vx_OvzBlokRechts: BOOL := FALSE;
	// Visualisatie invisible blok
	Vx_OvzBlokGevallen: BOOL := FALSE;	
	// Magazijn opnieuw vullen (simulatie)
	Ix_MagazijnVullen 	: BOOL;
	// Goten legen (symulatie)
	Ix_GotenLegen	  	: BOOL;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// Simulatie visualisatie 
	Vw_Rotate45: INT := 45;
	// Visualisatie X positie van de uitstoter
	Vw_MagUitstoterBekerX: INT := 30;
	// Visualisatie invisible blok uitgestoten
	Vx_MagBlokUit: BOOL := TRUE;
	// Visualisatie invisible blok 1
	Vx_MagBlok1: BOOL := TRUE;
	// Visualisatie invisible blok 2
	Vx_MagBlok2: BOOL := TRUE;
	// Visualisatie invisible blok 3
	Vx_MagBlok3: BOOL := TRUE;
	// Visualisatie invisible blok 4
	Vx_MagBlok4: BOOL := TRUE;
	// Visualisatie invisible blokken
	Vx_MagBlok: ARRAY[1..8] OF BOOL;
	// Aantal blokken in het magazijn
	Vw_MagBlokAantal: INT := 4;
	// Simulatie onthoudt dat een blok maar 1x wordt uitgestoten
	Vw_MagBlok1X: INT := 0;
	// Ligt er een blok op band
	Vw_SorBlokBand: BOOL := FALSE;
	// Rotatie van de stopper
	Vw_SorStopperRotate: INT := 0;
	// Rotatie van de stopper goot 1
	Vw_SorGoot1Rotate: INT := 0;
	// Rotatie van de stopper goot 2
	Vw_SorGoot2Rotate: INT := 0;
	// Rotatie van de stopper goot 3
	Vw_SorGoot3Rotate: INT := 0;
	// Kleur van de blok op betreffende positie
	Vw_SorKleurBand: DWORD := 0;
	// Bewegen van de blok over de band
	Vi_SorBlokBandX: INT := 0;
	// Bewegen van de blok over de band
	Vi_SorBlokBandY: INT := 0;
	// Simulatie error. Inverse logica.
	Vx_MagLuchtDrukError: BOOL := TRUE;
	// Simulatie error. Inverse logica.
	Vx_MagIsInError: BOOL := TRUE;
	// Simulatie error. Inverse logica.
	Vx_MagIsUitError: BOOL := TRUE;
	// Simulatie error. Inverse logica.
	Vx_OvzLuchtDrukError: BOOL := TRUE;
	// Simulatie error. Inverse logica.
	Vx_OvzIsLinksError: BOOL := TRUE;
	// Simulatie error. Inverse logica.
	Vx_OvzIsRechtsError: BOOL := TRUE;
	// Simulatie error. Inverse logica.
	Vx_OvzVacuumError: BOOL := TRUE;
	// Simulatie error. Inverse logica.
	Vx_SorMotorAfvoerError: BOOL := TRUE;
	// Simulatie error. Inverse logica.
	Vx_SorGoot1InError: BOOL := TRUE;
	// Simulatie error. Inverse logica.
	Vx_SorGoot1UitError: BOOL := TRUE;
	// Simulatie error. Inverse logica.
	Vx_SorInGootError: BOOL := TRUE;
	// Ligt er een blok op de betreffende positie
	Vx_SorBlokGoot: ARRAY [1..4,1..6] OF BOOL;
	// Kleur van de blok op betreffende positie
	Vw_SorKleurGoot: ARRAY [1..4,1..6] OF DWORD;
	// Kleur van de blokken in het magazijn (lege plek = grijs)
	Vw_MagKleur: ARRAY[1..8] OF DWORD;
	// Kleur van het uitgestoten blok
	Vw_MagKleurUit: DWORD;
	// Kleur van het blok op de overzetter
	Vw_OvzKleur: DWORD := 16#FFC0C0C0;
	// Kleur van het blok dat klaarligt bij de uitgang van het magazijn
	Vw_MagKleurAfgifte: DWORD := 16#FFC0C0C0;
	// Kleur van het blok dat de overzetter op de band heeft gelegd (nog niet door de band opgepakt)
	Vw_SorKleurVolgende: DWORD := 16#FFC0C0C0;
	// Er ligt een nieuw blok klaar voor de band
	Vx_SorNieuwBlok: BOOL := FALSE;
END_VAR
