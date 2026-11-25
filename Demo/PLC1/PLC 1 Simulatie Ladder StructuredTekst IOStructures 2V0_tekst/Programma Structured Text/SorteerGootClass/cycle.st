(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD cycle
VAR_INPUT
END_VAR
VAR CONSTANT
	MAX_AANTAL_IN_GOOT		: UINT := 3;
END_VAR

(*#### IMPLEMENTATIE ####*)
// Goot 1, 2 en 3 hebben een uitschuiver; goot 4 ligt aan het eind van de band.
CASE eState OF
	sorteerStates.wacht_op_start:
		IF 	((aantal_in_goot1 >= MAX_AANTAL_IN_GOOT) OR (aantal_in_goot2 >= MAX_AANTAL_IN_GOOT) OR
			 (aantal_in_goot3 >= MAX_AANTAL_IN_GOOT) OR (aantal_in_goot4 >= MAX_AANTAL_IN_GOOT)) THEN
			eState := sorteerStates.goot_vol;
		END_IF
	sorteerStates.stopper_uit:
		IF (IO.Ix_BekerInGoot AND IO.meetstation.Ix_BekerAanwezig) THEN
			eState := sorteerStates.meten;
		END_IF
	sorteerStates.meten:
		product_type := meetstation.getProductType();
		CASE product_type OF
			product_type_goot1:
				uitvoerGoot1.gaUit();
				eState := sorteerStates.uitvoer_goot_uit;
			product_type_goot2:
				uitvoerGoot2.gaUit();
				eState := sorteerStates.uitvoer_goot_uit;
			product_type_goot3:
				uitvoerGoot3.gaUit();
				eState := sorteerStates.uitvoer_goot_uit;
			product_type_goot4:
				eState := sorteerStates.transporteren_naar_goot;
			ELSE
				eState := sorteerStates.error;
		END_CASE
		IO.Qx_StopperUit			:= FALSE;
	sorteerStates.uitvoer_goot_uit:
		CASE product_type OF
			product_type_goot1:
				IF uitvoerGoot1.isUit() THEN
					eState := sorteerStates.transporteren_naar_goot;
				END_IF
			product_type_goot2:
				IF uitvoerGoot2.isUit() THEN
					eState := sorteerStates.transporteren_naar_goot;
				END_IF
			product_type_goot3:
				IF uitvoerGoot3.isUit() THEN
					eState := sorteerStates.transporteren_naar_goot;
				END_IF
			ELSE
				eState := sorteerStates.error;
		END_CASE
	sorteerStates.transporteren_naar_goot:
		IF NOT IO.Ix_BekerInGoot THEN
			CASE product_type OF
				product_type_goot1:
					uitvoerGoot1.gaIn();
					aantal_in_goot1 := aantal_in_goot1 + 1;
					IO.Qx_MotorAfvoerAan := FALSE;
					eState := sorteerStates.uitvoer_goot_in;
				product_type_goot2:
					uitvoerGoot2.gaIn();
					aantal_in_goot2 := aantal_in_goot2 + 1;
					IO.Qx_MotorAfvoerAan := FALSE;
					eState := sorteerStates.uitvoer_goot_in;
				product_type_goot3:
					uitvoerGoot3.gaIn();
					aantal_in_goot3 := aantal_in_goot3 + 1;
					IO.Qx_MotorAfvoerAan := FALSE;
					eState := sorteerStates.uitvoer_goot_in;
				product_type_goot4:
					aantal_in_goot4 := aantal_in_goot4 + 1;
					IO.Qx_MotorAfvoerAan := FALSE;
					eState := sorteerStates.wacht_op_start;
				ELSE
					eState := sorteerStates.error;
			END_CASE
			
		END_IF
	sorteerStates.uitvoer_goot_in:
		CASE product_type OF
			product_type_goot1:
				IF uitvoerGoot1.isIn() THEN
					eState := sorteerStates.wacht_op_start;
				END_IF
			product_type_goot2:
				IF uitvoerGoot2.isIn() THEN
					eState := sorteerStates.wacht_op_start;
				END_IF
			product_type_goot3:
				IF uitvoerGoot3.isIn() THEN
					eState := sorteerStates.wacht_op_start;
				END_IF
			ELSE
				eState := sorteerStates.error;
		END_CASE
	sorteerStates.reset_error:
		IF (uitvoerGoot1.isIn() AND uitvoerGoot2.isIn() AND uitvoerGoot3.isIn()) THEN
			eState := sorteerStates.wacht_op_start;
		END_IF
	sorteerStates.goot_vol:
		IF 	((aantal_in_goot1 < MAX_AANTAL_IN_GOOT) AND (aantal_in_goot2 < MAX_AANTAL_IN_GOOT) AND
			 (aantal_in_goot3 < MAX_AANTAL_IN_GOOT) AND (aantal_in_goot4 < MAX_AANTAL_IN_GOOT)) THEN
			eState := sorteerStates.wacht_op_start;
		END_IF
//	sorteerStates.error:
END_CASE

IF eState = sorteerStates.error THEN
	//Transportband aan
	IO.Qx_MotorAfvoerAan 		:= FALSE;
	IO.Qx_StopperUit 			:= FALSE;
	//Uitsorteren is bezet
	IO.Qx_StationBezet 		:= FALSE;
END_IF


uitvoerGoot1.cycle();
uitvoerGoot2.cycle();
uitvoerGoot3.cycle();
