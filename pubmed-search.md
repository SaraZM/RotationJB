# pubmed search $date Fri Feb  2 14:40:13 EST 2018
(Bayes[Title] OR Bayesian[Title]) AND 
(	("magnetic resonance imaging"[MeSH Terms] OR 
	("magnetic"[Title] AND "resonance"[Title] AND "imaging"[Title]) OR 
	"magnetic resonance imaging"[Title] OR 
	"fmri"[Title]) OR 
	(	functional[Title] AND 
		(	(	"magnetic resonance imaging"[MeSH Terms] OR 
				("magnetic"[Title] AND "resonance"[Title] AND "imaging"[Title]) OR 
				"magnetic resonance imaging"[Title] OR 
				"mri"[Title]) 
			OR 
			(	"magnetic resonance imaging"[MeSH Terms] OR 
				("magnetic"[Title] AND "resonance"[Title] AND "imaging"[Title]) OR 
				"magnetic resonance imaging"[Title]
			)
		)
	)
) 

(Bayes[Title] OR Bayesian[Title]) AND 
(	(("magnetic resonance imaging"[MeSH Terms] OR 
	("magnetic"[Title] AND "resonance"[Title] AND "imaging"[Title]) OR 
	"magnetic resonance imaging"[Title] OR 
	) AND ("functional[Title])  OR 
	"fmri"[Title])
) 

(Bayes[Title] OR Bayesian[Title]) AND ("fmri"[Title])) NOT (EEG OR  connectivity)

(Bayes[Title] OR Bayesian[Title]) AND ("fmri"[Title] OR (functional AND "magnetic resonance imaging"[MeSH Terms]) )  NOT (("electroencephalography"[MeSH Terms] OR "electroencephalography"[All Fields] OR "eeg"[All Fields]) OR connectivity[All Fields])



