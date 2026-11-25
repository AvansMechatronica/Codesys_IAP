(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD cycle
VAR
END_VAR
(*#### IMPLEMENTATIE ####*)
CASE eState OF

//	overzetterStates.idle :
	overzetterStates.ga_naar_links:
		IF IO.Ix_OverzetterIsLinks THEN
			IO.Qx_OverzetterLinks 		:= FALSE;
			IO.Qx_VacuumAan 			:= TRUE;
			eState 					:= overzetterStates.is_links;
		END_IF;
	overzetterStates.is_links:
		IF IO.Ix_VacuumAanwezig THEN
			IO.Qx_OverzetterRechts 	:= TRUE;
			eState					:= overzetterStates.ga_naar_rechts;
	END_IF
//	overzetterStates.vaccuum_aanzetten:
	overzetterStates.ga_naar_rechts:
		IF IO.Ix_OverzetterIsRechts THEN
			IO.Qx_OverzetterRechts := FALSE;
			IO.Qx_VacuumAan 		:= FALSE;
			IO.Qx_BekerLossen 		:= TRUE;
			eState := overzetterStates.is_rechts;
		END_IF
	overzetterStates.is_rechts:
		IF NOT IO.Ix_VacuumAanwezig THEN
			IO.Qx_BekerLossen 		:= FALSE;
			IO.Qx_OverzetterLinks 	:= TRUE;
			eState 				:= overzetterStates.ga_naar_midden;
		END_IF
//	overzetterStates.vaccuum_lossen:
	overzetterStates.ga_naar_midden:
		IF timer.Q THEN
			IO.Qx_OverzetterLinks	:= FALSE;
			eState 				:= overzetterStates.is_midden;
			xKlaar 					:= TRUE;
		END_IF
		
	//overzetterStates.is_midden:
//	overzetterStates.error:
END_CASE

timer(IN:=(estate =overzetterStates.ga_naar_midden), PT:=T#2S);

