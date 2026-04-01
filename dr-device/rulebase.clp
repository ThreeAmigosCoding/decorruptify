(import-rdf "facts.rdf")
		(export-rdf export.rdf  art416_basic art416_qualified_gain art416_organized art420_basic art420_qualified art422_basic art422_organized art423_basic art423_qualified art424_basic min_imprisonment max_imprisonment)
		(export-proof proof.ruleml)
		
(defeasiblerule rule1
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:abuse_of_authority "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:crime_type "art416")
	) 
  => 
	 
	(art416_basic 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule2
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:crime_type "art416")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:high_gain "true")
	) 
  => 
	 
	(art416_qualified_gain 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule2_neg
		 
	(art416_qualified_gain 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art416_basic 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule3
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:crime_type "art416")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:organized_group "true")
	) 
  => 
	 
	(art416_organized 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule3_neg1
		 
	(art416_organized 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art416_basic 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule3_neg2
		 
	(art416_organized 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art416_qualified_gain 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule4
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:abuse_of_authority "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:crime_type "art420")
	) 
  => 
	 
	(art420_basic 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule5
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:crime_type "art420")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:high_gain "true")
	) 
  => 
	 
	(art420_qualified 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule5_neg
		 
	(art420_qualified 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art420_basic 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule6
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:crime_type "art422")
	) 
  => 
	 
	(art422_basic 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule7
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:crime_type "art422")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:organized_group "true")
	) 
  => 
	 
	(art422_organized 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule7_neg
		 
	(art422_organized 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art422_basic 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule8
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:bribery_involved "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:crime_type "art423")
	) 
  => 
	 
	(art423_basic 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule9
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:crime_type "art423")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:high_bribery "true")
	) 
  => 
	 
	(art423_qualified 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule9_neg
		 
	(art423_qualified 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art423_basic 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule10
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:bribery_involved "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:crime_type "art424")
	) 
  => 
	 
	(art424_basic 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule pen_416b_min
		 
	(art416_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 1)
	) 
) 
	
(defeasiblerule pen_416b_max
		 
	(art416_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 5)
	) 
) 
	
(defeasiblerule pen_416qg_min
		 
	(art416_qualified_gain 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 1)
	) 
) 
	
(defeasiblerule pen_416qg_max
		 
	(art416_qualified_gain 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 10)
	) 
) 
	
(defeasiblerule pen_416org_min
		 
	(art416_organized 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 2)
	) 
) 
	
(defeasiblerule pen_416org_max
		 
	(art416_organized 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 12)
	) 
) 
	
(defeasiblerule pen_420b_min
		 
	(art420_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 1)
	) 
) 
	
(defeasiblerule pen_420b_max
		 
	(art420_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 8)
	) 
) 
	
(defeasiblerule pen_420q_min
		 
	(art420_qualified 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 2)
	) 
) 
	
(defeasiblerule pen_420q_max
		 
	(art420_qualified 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 10)
	) 
) 
	
(defeasiblerule pen_422b_min
		 
	(art422_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 1)
	) 
) 
	
(defeasiblerule pen_422b_max
		 
	(art422_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 5)
	) 
) 
	
(defeasiblerule pen_422org_min
		 
	(art422_organized 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 1)
	) 
) 
	
(defeasiblerule pen_422org_max
		 
	(art422_organized 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 8)
	) 
) 
	
(defeasiblerule pen_423b_min
		 
	(art423_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 1)
	) 
) 
	
(defeasiblerule pen_423b_max
		 
	(art423_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 8)
	) 
) 
	
(defeasiblerule pen_423q_min
		 
	(art423_qualified 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 2)
	) 
) 
	
(defeasiblerule pen_423q_max
		 
	(art423_qualified 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 12)
	) 
) 
	
(defeasiblerule pen_424b_min
		 
	(art424_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 1)
	) 
) 
	
(defeasiblerule pen_424b_max
		 
	(art424_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 5)
	) 
) 
	