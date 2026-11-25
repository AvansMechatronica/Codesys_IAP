(*#### DECLARATIE ####*)
// Datum : 17 december 2020, Auteur: Gerard Harkema
TYPE hmiIO :
STRUCT
	// Indrukken resetknop 
	Ix_Resetknop			: REFERENCE TO BOOL;
	// Keuzeknop staat op hand
	Ix_Hand					: REFERENCE TO BOOL;
	// Keuzeknop staat op auto
	Ix_Auto					: REFERENCE TO BOOL;
	// Indrukken noodstop
	Ix_Noodstop				: REFERENCE TO BOOL;
	// Bekers magazijn zijn op

	// Indrukken startknop
	Ix_Stopknop				: REFERENCE TO BOOL;
	// Indrukken stopknop
	Ix_Startknop			: REFERENCE TO BOOL;	
	//Perslucht is aanwezig

	// Visualisatie invisible Gele vlak
	Qx_GeleLamp				: REFERENCE TO BOOL;
	// Visualisatie invisible groene vlak
	Qx_GroeneLamp			: REFERENCE TO BOOL;
	// Visualisatie invisible rode vlak
	Qx_RodeLamp				: REFERENCE TO BOOL;

END_STRUCT
END_TYPE

