(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
METHOD getProductType : productType
VAR_INPUT
END_VAR

(*#### IMPLEMENTATIE ####*)
IF IO.Ix_BekerAanwezig THEN
	IF IO.Ix_BekerMetaal THEN
		IF IO.Ix_BekerReflecteerd THEN
			getProductType := productType.metaal_blank;
		ELSE	
			getProductType := productType.metaal_zwart;
		END_IF
	ELSE
		IF IO.Ix_BekerReflecteerd THEN
			getProductType := productType.kunstof_rood;
		ELSE	
			getProductType := productType.kunstof_zwart;
		END_IF
	END_IF
ELSE
	getProductType := productType.onbekend;	
END_IF

