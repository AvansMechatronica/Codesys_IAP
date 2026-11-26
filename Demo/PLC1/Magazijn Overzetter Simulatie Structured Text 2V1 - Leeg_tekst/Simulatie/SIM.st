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
	// Kleur van de blokken in het magazijn (lege plek = grijs)
	Vw_MagKleur: ARRAY[1..8] OF DWORD;
	// Kleur van het uitgestoten blok
	Vw_MagKleurUit: DWORD;
	// Kleur van het blok op de overzetter
	Vw_OvzKleur: DWORD := 16#FFC0C0C0;
	// Kleur van het blok dat klaarligt bij de uitgang van het magazijn
	Vw_MagKleurAfgifte: DWORD := 16#FFC0C0C0;
	// Er ligt een uitgestoten beker klaar bij de uitgang van het magazijn (voor de overzetter)
	Vx_MagBlokKlaar: BOOL := FALSE;
	// Afgifteplaats: kleur van de laatst afgegeven beker
	Vw_AfgifteKleur: DWORD := 16#FFA9A9A9;
	// Afgifteplaats: visualisatie invisible beker (inverse logica)
	Vx_AfgifteBeker: BOOL := TRUE;
	// Afgifteplaats: aantal afgegeven bekers
	Vi_AfgifteTeller: INT := 0;
	// Afgifteplaats leegmaken en teller op 0 (simulatie)
	Ix_AfgifteLegen: BOOL;
END_VAR
