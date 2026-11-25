(*#### DECLARATIE ####*)
FUNCTION_BLOCK SorterenGootSim

VAR_INPUT
	// Huidige Y positie van de blok
	Px_YPos: INT;
	// Huidge goot
	Px_Goot: INT;
END_VAR
VAR
	// Index voor posities
	Mi_PositieIndx: INT := 1;	
	// Posities van de blokjes in de goot
	Mi_Posities: ARRAY[1..6] OF INT;	
END_VAR
VAR_OUTPUT
	// Er is een positie waar het blokje terecht komt.
	Px_Geplaatst: BOOL;
END_VAR
VAR
	// Eerste keer om visualisatie te updaten
	Mx_FirstTime: BOOL := TRUE;
END_VAR
VAR CONSTANT
	// Inverse logica
	INVISABLE: BOOL := TRUE;
	// Inverse logica
	VISABLE: BOOL := FALSE;

END_VAR


(*#### IMPLEMENTATIE ####*)

//
// Initialiseer de posities van de blokjes in de goot.
//

IF (Mx_FirstTime) THEN
	Mi_Posities[1] :=  40;
	Mi_Posities[2] :=  80;
	Mi_Posities[3] := 120;
	Mi_Posities[4] := 160;
	Mi_Posities[5] := 200;
	Mi_Posities[6] := 240;	
	
	Mx_FirstTime := FALSE;
END_IF

Px_Geplaatst := FALSE;

//
// Bepaal of de huidige positie van het blokje op de band dat in de goot valt
// past bij een vaste positie in de goot. Indien dit het geval is, neem dan 
// de kleur over en toon het blokje. De goot vult zich van onder naar boven.
//

FOR Mi_PositieIndx := 3 TO 1 BY -1 DO
	IF (SIM.Vx_SorBlokGoot[Px_Goot, Mi_PositieIndx] = INVISABLE) THEN
		IF (SIM.Vi_SorBlokBandY > Mi_Posities[Mi_PositieIndx] ) THEN
			SIM.Vx_SorBlokGoot[Px_Goot, Mi_PositieIndx]  := VISABLE;
			SIM.Vw_SorKleurGoot[Px_Goot, Mi_PositieIndx] := SIM.Vw_SorKleurBand;
			
			Px_Geplaatst := TRUE;
			RETURN;
		ELSE
			RETURN;
		END_IF
	END_IF
END_FOR
