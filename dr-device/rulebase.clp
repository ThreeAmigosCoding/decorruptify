(import-rdf "facts.rdf")
		(export-rdf export.rdf  art416_basic art416_qualified_gain art416_organized art420_basic art420_qualified art422_basic art422_organized art423_basic art423_qualified art424_basic art424_acquittal min_imprisonment max_imprisonment)
		(export-proof proof.ruleml)
		
(defeasiblerule rule1
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:abuse_of_authority "true")
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
		 lc:abuse_of_authority "true")
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
		(declare (superior rule1 )) 
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
		 lc:abuse_of_authority "true")
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
		(declare (superior rule1 )) 
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
		(declare (superior rule2 )) 
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
		 lc:embezzlement "true")
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
		 lc:embezzlement "true")
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
		(declare (superior rule4 )) 
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
	
(defeasiblerule rule4_neg_416b
		(declare (superior rule1 )) 
	(art420_basic 
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
	
(defeasiblerule rule4_neg_416qg
		(declare (superior rule2 )) 
	(art420_basic 
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
	
(defeasiblerule rule4_neg_416org
		(declare (superior rule3 )) 
	(art420_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art416_organized 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule6
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:trading_influence "true")
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
		 lc:trading_influence "true")
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
		(declare (superior rule6 )) 
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
	
(defeasiblerule rule6_neg_416b
		(declare (superior rule1 )) 
	(art422_basic 
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
	
(defeasiblerule rule6_neg_416qg
		(declare (superior rule2 )) 
	(art422_basic 
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
	
(defeasiblerule rule6_neg_416org
		(declare (superior rule3 )) 
	(art422_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art416_organized 
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
		 lc:bribe_receiver "true")
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
		 lc:bribery_involved "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:bribe_receiver "true")
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
		(declare (superior rule8 )) 
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
	
(defeasiblerule rule8_neg_416b
		(declare (superior rule1 )) 
	(art423_basic 
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
	
(defeasiblerule rule8_neg_416qg
		(declare (superior rule2 )) 
	(art423_basic 
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
	
(defeasiblerule rule8_neg_416org
		(declare (superior rule3 )) 
	(art423_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art416_organized 
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
		 lc:bribe_receiver "false")
	) 
  => 
	 
	(art424_basic 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule11
		 
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
		 lc:bribe_receiver "false")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:voluntary_disclosure "true")
	) 
  => 
	 
	(art424_acquittal 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule11_neg
		(declare (superior rule10 )) 
	(art424_acquittal 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art424_basic 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule10_neg_416b
		(declare (superior rule1 )) 
	(art424_basic 
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
	
(defeasiblerule rule10_neg_416qg
		(declare (superior rule2 )) 
	(art424_basic 
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
	
(defeasiblerule rule10_neg_416org
		(declare (superior rule3 )) 
	(art424_basic 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(art416_organized 
		(
		 defendant ?Defendant)
	) )
	
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
	
(defeasiblerule pen_424a_min
		 
	(art424_acquittal 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 0)
	) 
) 
	
(defeasiblerule pen_424a_max
		 
	(art424_acquittal 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 0)
	) 
) 
	