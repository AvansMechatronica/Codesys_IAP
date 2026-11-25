(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD cycle
VAR

END_VAR
	

(*#### IMPLEMENTATIE ####*)
x_Klaar := magazijn.isKlaar() 
	   AND overzetter.isKlaar()
	   AND sorteerGoot.isKlaar();

x_Error := magazijn.isError()
	   OR overzetter.isError()
	   OR sorteerGoot.isError();
	   
	   
IF x_Error THEN
	eState := sorteerStationStates.error;
END_IF

IF IO.hmi.Ix_Startknop THEN
	x_Enable := TRUE;
//	IO.hmi.Ix_Startknop := FALSE;
END_IF
	  
IF NOT IO.hmi.Ix_Stopknop THEN
	x_Enable := FALSE;
END_IF

IF IO.hmi.Ix_ResetKnop THEN
	magazijn.reset();
	overzetter.reset();
	sorteerGoot.reset();
	x_Enable := FALSE;
	eState := sorteerStationStates.wacht_op_klaar;
END_IF

IF IO.hmi.Ix_Noodstop THEN
	magazijn.noodstop();
	overzetter.noodstop();
	sorteerGoot.noodstop();
	eState := sorteerStationStates.error;
END_IF

IO.hmi.Qx_GroeneLamp	:= NOT x_Klaar;
IO.hmi.Qx_RodeLamp 	:= x_Error;

 
CASE eState OF
	sorteerStationStates.idle:
		eState := sorteerStationStates.wacht_op_klaar;
	sorteerStationStates.wacht_op_klaar:
		IF x_Klaar THEN
			eState := sorteerStationStates.wacht_enable;
		END_IF
	sorteerStationStates.wacht_enable:
		IF magazijn.isMagazijnLeeg() OR sorteerGoot.isGootVol() THEN
			IO.hmi.Qx_GeleLamp		:= TRUE;
			eState := sorteerStationStates.service;
		ELSE
			IF x_Enable THEN
				magazijn.start();
				eState := sorteerStationStates.product_uitgifte;
			END_IF
		END_IF
	sorteerStationStates.product_uitgifte:
		IF magazijn.isKlaar() THEN
			overzetter.start();
			eState := sorteerStationStates.product_overzetten;
		END_IF
	sorteerStationStates.product_overzetten:
		IF overzetter.isKlaar() THEN
			sorteerGoot.start();
			eState := sorteerStationStates.product_sorteren;
		END_IF
	sorteerStationStates.product_sorteren:
		IF sorteerGoot.isKlaar() THEN
			eState := sorteerStationStates.wacht_enable;
		END_IF
	sorteerStationStates.service:
		IF IO.hmi.Ix_Startknop THEN
//			IO.hmi.Ix_Startknop := FALSE;
			sorteerGoot.productTellerReset();
			IO.hmi.Qx_GeleLamp		:= FALSE;
			eState := sorteerStationStates.wacht_enable;
		END_IF
END_CASE;


magazijn.cycle();
overzetter.cycle();
sorteerGoot.cycle();
