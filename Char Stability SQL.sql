
Use risk
go

IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'Characteristic_Stability')
BEGIN
	PRINT 'DROPING TABLE Characteristic_Stability' 
	DROP TABLE Characteristic_Stability
END
go


SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sPC_Sector_GRI as Factor_Value	
	,  'sPC_Sector_GRI' as Factor	
	,  COUNT(*) as Obs	

INTO	risk..Characteristic_Stability

FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 			
				
GROUP BY				
	package_id			
	,  [portfolio name]			
	,  Maturity			
	,  sPC_Sector_GRI			
				

UNION				

SELECT	package_id			
	,  [portfolio name]			
	,  Maturity			
	,  sTOP_1000_PC_Sector as Factor_Value			
	,  'sTOP_1000_PC_Sector' as Factor			
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sTOP_1000_PC_Sector	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sTitle as Factor_Value	
	,  'sTitle' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sTitle	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sForename as Factor_Value	
	,  'sForename' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sForename	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sPhone_Data as Factor_Value	
	,  'sPhone_Data' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sPhone_Data	

UNION

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sCombined_Phone as Factor_Value	
	,  'sPhone_Data' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sCombined_Phone	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sAddress_Quality as Factor_Value	
	,  'sAddress_Quality' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
	
GROUP BY	
	package_id
	,  [portfolio name]
	,  Maturity
	,  sAddress_Quality


UNION	

SELECT	package_id
	,  [portfolio name]
	,  Maturity
	,  sProduct_Defintion as Factor_Value
	,  'sProduct_Defintion' as Factor
	,  COUNT(*) as Obs
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sProduct_Defintion	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sLitigation as Factor_Value	
	,  'sLitigation' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sLitigation	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sLitigation as Factor_Value	
	,  'sLitigation' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sLitigation	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sAge_At_Default as Factor_Value	
	,  'sAge_At_Default' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sAge_At_Default	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sNum_RA_Purchase as Factor_Value	
	,  'sNum_RA_Purchase' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sNum_RA_Purchase	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sBalance_RA_Purchase as Factor_Value	
	,  'sBalance_RA_Purchase' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sBalance_RA_Purchase	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sDAO_to_LPD as Factor_Value	
	,  'sDAO_to_LPD' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sDAO_to_LPD	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sDefault_to_LPD as Factor_Value	
	,  'sDefault_to_LPD' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sDefault_to_LPD	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sNumber_Phases as Factor_Value	
	,  'sNumber_Phases' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sNumber_Phases	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sLPD_Ind as Factor_Value	
	,  'sLPD_Ind' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 	
		
GROUP BY		
	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sLPD_Ind	


UNION		

SELECT	package_id	
	,  [portfolio name]	
	,  Maturity	
	,  sInterest_Ind as Factor_Value	
	,  'sInterest_Ind' as Factor	
	,  COUNT(*) as Obs	
FROM	risk..BERT_ScoreChar 	scorechar
	,  risk..tmpPackage	package
WHERE	scorechar.Debt_Code = package.[Debt-code] 
	
GROUP BY	
	package_id
	,  [portfolio name]
	,  Maturity
	,  sInterest_Ind

ORDER BY
	package_id
	,  [portfolio name]
	,  Maturity
	,  Factor
