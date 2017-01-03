Use risk
go


IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'tmpVendor')
BEGIN
	PRINT 'DROPING TABLE tmpVendor' 
	DROP TABLE tmpVendor
END
go

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET QUOTED_IDENTIFIER OFF 
PRINT 'Create tmpVendor'
SELECT tblvendor_data.[Debt-code] 
  ,  tblvendor_data.[Vendor Account Number] 
  ,  UPPER(REPLACE(tblvendor_data.Postcode,' ','')) as PostCode 
  ,  CASE 	WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][0-9][0-9][A-Z][A-Z]' 		THEN 1
  		WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][0-9][0-9][0-9][A-Z][A-Z]' 	THEN 2 
  		WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][A-Z][0-9][0-9][A-Z][A-Z]' 	THEN 3 
 		WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][A-Z][0-9][0-9][0-9][A-Z][A-Z]' 	THEN 4 
  		WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][0-9][A-Z][0-9][A-Z][A-Z]' 	THEN 5 
  		WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][A-Z][0-9][A-Z][0-9][A-Z][A-Z]' 	THEN 6 
  ELSE -99 
  END as vPostCode 
  ,  'XX999' C02_PAFS 
  ,  UPPER(REPLACE(tblvendor_data.[Title (1)],' ','')) as Title 
  ,  UPPER(REPLACE(tblvendor_data.[Forename (1)],' ','')) as Forename 
  ,  UPPER(REPLACE(tblvendor_data.[Inits (1)],' ','')) as Initials 
  ,  UPPER(REPLACE(tblvendor_data.[Surname (1)],' ','')) as Surname
  ,  tblvendor_data.[Phone Data] 
  ,CASE WHEN LEN(ISNULL([Home Tel (conv)],''))<11 THEN 1 ELSE 0 END 
  +  CASE WHEN LEN(ISNULL([Work Tel (conv)],''))<11 THEN 1 ELSE 0 END 
  +  CASE WHEN LEN(ISNULL([Other Tel (conv)],''))<11 THEN 1 ELSE 0 END AS Combined_Phone
  ,  tblvendor_data.[Address Data?] 
  ,  tblvendor_data.[Address Score] 
  ,  REPLACE([Account Type/Brand],"'",'') as [Account Type/Brand]
  ,  tblvendor_data.[Default Date] 
  ,  tblvendor_data.DOB 
  ,  tblvendor_data.[Judgement Date] 
  ,  tblvendor_data.[Last Payment Date] 
  ,  tblvendor_data.[Date Account Opened] 
  ,  tblvendor_data.[Interest Rate Applied by Vendor] 
  ,  Datediff(Year,tblvendor_data.DOB,tblvendor_data.[Default Date]) as dAge_At_Default 
  ,  Datediff(Month,tblvendor_data.[Date Account Opened],tblvendor_data.[Last Payment Date]) as dDAO_to_LPD 
  ,  Datediff(Month,tblvendor_data.[Default Date],tblvendor_data.[Last Payment Date]) as dDefault_to_LPD 
  ,  tblvendor_data.[Purchase Date] as Purchase_Date
  ,  tblvendor_data.[Package ID] as Package_ID
  ,  tblvendor_data.[Balance Purchased]

  INTO risk..tmpVendor

  FROM  data_warehouse.dbo.tblvendor_data as tblvendor_data
  WHERE tblvendor_data.[Debt-code] IS NOT NULL
  ORDER BY tblvendor_data.[Debt-code] 
SET QUOTED_IDENTIFIER ON
go

PRINT 'Update Postcode Sector'
UPDATE 	risk..tmpVendor
SET 	C02_PAFS = CASE WHEN vPostCode <> -99 THEN SUBSTRING(PostCode,1,LEN(PostCode)-2)ELSE C02_PAFS END
FROM	risk..tmpVendor

PRINT 'INDEX tmpVendor'
CREATE INDEX iDebtCode on risk..tmpVendor([Debt-code])
CREATE INDEX iPackage_ID on risk..tmpVendor(Package_ID)
go

PRINT 'Update Package ID to Gospel ID'
UPDATE	risk..tmpVendor
SET	[Account Type/Brand] = ref.Gospel_Product_Type

FROM 	risk..tmpVendor		vendor
	,  risk..ref_Package_ID ref
	
WHERE	vendor.Package_ID = ref.Package_ID
AND	ISNULL(UPPER(REPLACE(REPLACE(vendor.[Account Type/Brand],' ' , ''),'&','')),'NULL')  = ref.Current_Product_Type  
go


PRINT 'Update Address Data'
UPDATE  risk..tmpVendor
SET	[Address Data?] = ref.Gospel_Address_Data
FROM	risk..tmpVendor			vendor
	,  risk..ref_AddressData	ref
WHERE	ISNULL(vendor.[Address Data?],'NULL') = ref.Address_Data
go


IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'tmpPackage')
BEGIN
	PRINT 'DROPING TABLE tmpPackage' 
	DROP TABLE tmpPackage
END
go

declare @Start smalldatetime

SET @Start = DATEADD(mm,-1,CAST(FLOOR( CAST( GETDATE() AS FLOAT ) )AS DATETIME))
PRINT 'CREAET tmpPackage'
SELECT	risk.[Debt-code]
	,  risk.package_id
	,  bookon.[portfolio name]
	,  bookon.[purchase date]
	,  bookon.[Number of Agents]
	,  bookon.[Interest Method]
	,  DATEDIFF(MONTH,[purchase date], @Start) as Maturity
	
INTO	risk..tmpPackage

FROM	data_warehouse.dbo.vw_book_ons 	bookon
	,  risk..tmpVendor		risk
Where	risk.Package_ID = bookon.Package_ID
go

PRINT 'INDEX tmpPackage'
CREATE INDEX iDebtCode on risk..tmpPackage([Debt-code])
CREATE INDEX iPackage_ID on risk..tmpPackage(Package_ID)
go


/************************************************/
/************************************************/
/************************************************/
/************************************************/

IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'BERT_FinalChar')
BEGIN
	PRINT 'DROPING TABLE BERT_FinalChar' 
	DROP TABLE BERT_FinalChar
END
go

PRINT 'CREATE risk..BERT_FinalChar'

CREATE TABLE risk..BERT_FinalChar (
wk_ref VARCHAR(10) 		PRIMARY KEY
,  Debt_Code 		VARCHAR(12) 	NOT NULL
,  Client_Key 		VARCHAR(39)	NULL
,  PC_Sector_GRI	INT		NOT NULL
,  TOP_1000_PC_Sector	INT		NOT NULL
,  Title		VARCHAR(30)	NULL
,  Forename		INT		NULL
,  Phone_Data		VARCHAR(50)	NULL
,  Combined_Phone	INT		NULL
,  Address_Quality	VARCHAR(50)	NULL
,  Product_Defintion	VARCHAR(50)	NULL
,  Litigation		INT		NULL
,  Age_At_Default	INT		NULL
,  Num_RA_Purchase	INT		NULL
,  Balance_RA_Purchase	INT		NULL
,  DAO_to_LPD		INT		NULL
,  Default_to_LPD	INT		NULL
,  Number_Phases	INT		NULL
,  LPD_Ind		INT		NULL
,  Interest_Ind		INT		NULL

)

go

PRINT 'First fill'
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
INSERT INTO risk..BERT_FinalChar (wk_ref, Debt_Code , Client_Key , PC_Sector_GRI , TOP_1000_PC_Sector , Title , Forename , Phone_Data , Combined_Phone, Address_Quality , Product_Defintion , Litigation , Age_At_Default , Num_RA_Purchase , Balance_RA_Purchase , DAO_to_LPD , Default_to_LPD	, Number_Phases	, LPD_Ind , Interest_Ind)
SELECT 	base.[debt-code]
	,  customer.wk_ref
	,  customer.Client_Key
	,  refPostCode.PC_Sector_GRI
	,  refPostCode.TOP_1000_PC_Sector
	,  base.Title
	,  LEN(REPLACE(base.Forename,' ','')) as Forename
	,  UPPER(REPLACE(REPLACE(base.[Phone Data],' ',''),'&','')) as [Phone Data]
	,  Combined_Phone
	,  base.[Address Data?] 
	,  base.[Account Type/Brand] 
	,  0 as [Legal A/C Marker] 
	,  base.dAge_At_Default 
	,  RA.RA
	,  RA.RA_Exposure
	,  base.dDAO_to_LPD 
	,  base.dDefault_to_LPD
	,  NULL as Phases
	,  CASE WHEN [Last Payment Date] IS NULL THEN 0 ELSE 1 END AS LPD_Ind
	,  base.[Interest Rate Applied by Vendor] 
	
FROM 	risk..tmpVendor			base
	,  risk..CK 			customer
	,  risk..ref_Postcode_Sector 	refPostCode
	,  risk..RA_Purchase		RA

WHERE	base.[debt-code] = customer.wk_ref
AND	refPostCode.Postcode_Sector = base.C02_PAFS 	/* BE careful about lost cases */
AND	base.[debt-code] = RA.wk_ref			/* BE careful about lost cases */

go

/******************************/
/** LOST C0_PAFS **/
/******************************/
PRINT '2nd Fill'
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
INSERT INTO risk..BERT_FinalChar (wk_ref, Debt_Code , Client_Key , PC_Sector_GRI , TOP_1000_PC_Sector , Title , Forename , Phone_Data , Combined_Phone, Address_Quality , Product_Defintion , Litigation , Age_At_Default , Num_RA_Purchase , Balance_RA_Purchase , DAO_to_LPD , Default_to_LPD	, Number_Phases	, LPD_Ind , Interest_Ind)
SELECT 	base.[debt-code]
	,  customer.wk_ref
	,  customer.Client_Key
	,  0 as PC_Sector_GRI
	,  0 as TOP_1000_PC_Sector
	,  base.Title
	,  LEN(REPLACE(base.Forename,' ','')) as Forename
	,  UPPER(REPLACE(REPLACE(base.[Phone Data],' ',''),'&','')) as [Phone Data]
	,  Combined_Phone
	,  base.[Address Data?] 
	,  base.[Account Type/Brand] 
	,  0 as [Legal A/C Marker]
	,  base.dAge_At_Default 
	,  RA.RA
	,  RA.RA_Exposure
	,  base.dDAO_to_LPD 
	,  base.dDefault_to_LPD
	,  NULL as Phases
	,  CASE WHEN [Last Payment Date] IS NULL THEN 0 ELSE 1 END AS LPD_Ind
	,  base.[Interest Rate Applied by Vendor] 
	
FROM 	risk..tmpVendor			base
	,  risk..CK 			customer
	,  risk..RA_Purchase		RA

WHERE	base.[debt-code] = customer.wk_ref
AND	base.[debt-code] = RA.wk_ref			/* BE careful about lost cases */
AND	base.C02_PAFS NOT IN (SELECT  refPostCode.Postcode_Sector FROM risk..ref_Postcode_Sector refPostCode)
AND	base.[debt-code] NOT IN (SELECT Debt_Code FROM risk..BERT_FinalChar)

go

/******************************/
/** LOST RAs  **/
/******************************/
PRINT '3rd and Final Fill'
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
INSERT INTO risk..BERT_FinalChar (wk_ref, Debt_Code , Client_Key , PC_Sector_GRI , TOP_1000_PC_Sector , Title , Forename , Phone_Data , Combined_Phone, Address_Quality , Product_Defintion , Litigation , Age_At_Default , Num_RA_Purchase , Balance_RA_Purchase , DAO_to_LPD , Default_to_LPD	, Number_Phases	, LPD_Ind , Interest_Ind)
SELECT 	base.[debt-code]
	,  customer.wk_ref
	,  customer.Client_Key
	,  refPostCode.PC_Sector_GRI
	,  refPostCode.TOP_1000_PC_Sector
	,  base.Title
	,  LEN(REPLACE(base.Forename,' ','')) as Forename
	,  UPPER(REPLACE(REPLACE(base.[Phone Data],' ',''),'&','')) as [Phone Data]
	,  Combined_Phone
	,  base.[Address Data?] 
	,  base.[Account Type/Brand] 
	,  0 as [Legal A/C Marker]
	,  base.dAge_At_Default 
	,  1 as RA
	,  0 as RA_Exposure
	,  base.dDAO_to_LPD 
	,  base.dDefault_to_LPD
	,  NULL as Phases
	,  CASE WHEN [Last Payment Date] IS NULL THEN 0 ELSE 1 END AS LPD_Ind
	,  base.[Interest Rate Applied by Vendor] 
	
FROM 	risk..tmpVendor			base
	,  risk..CK 			customer
	,  risk..ref_Postcode_Sector 	refPostCode
	

WHERE	base.[debt-code] = customer.wk_ref
AND	refPostCode.Postcode_Sector = base.C02_PAFS 	/* BE careful about lost cases */
AND	base.[debt-code] NOT IN ( SELECT RA.wk_ref FROM risk..RA_Purchase RA)
AND	base.[debt-code] NOT IN (SELECT Debt_Code FROM risk..BERT_FinalChar)


go

/*****************************************************************************************/
PRINT 'Update Phases'
UPDATE risk..BERT_FinalChar
SET 	Number_Phases = [Number of Agents]
	,  Interest_Ind	 = package.[Interest Method]
FROM	risk..tmpPackage 	package
	,  risk..BERT_FinalChar	risk
WHERE	package.[debt-code] = risk.wk_ref

/*****************************************************************************************/
go


PRINT 'Update Litigation Flag to Gospel'
PRINT 'First Update field values to skip_values table'

UPDATE	risk..BERT_FinalChar
SET	litigation = vskip.litigation_flag  
FROM	data_warehouse.dbo.vw_skip_values vskip
	,  risk..BERT_FinalChar	risk
WHERE	vskip.Wk_ref = risk.Wk_Ref
go

PRINT 'Updating Litigation Field from Gospel Table'
UPDATE	risk..BERT_FinalChar
SET	litigation = lit.Gospel_Code
FROM	risk..BERT_FinalChar risk
	,  risk..ref_Litigation lit
	,  risk..tmpVendor	vend
WHERE	vend.Package_ID = lit.Package_ID 
AND	risk.litigation = lit.Litigation_Code
AND	risk.wk_ref = vend.[debt-code]
go

IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'BERT_ScoreChar')
BEGIN
	PRINT 'DROPING TABLE BERT_ScoreChar' 
	DROP TABLE BERT_ScoreChar
END
go

PRINT 'CREATE AND POPULATE TABLE risk..BERT_ScoreChar'

CREATE TABLE risk..BERT_ScoreChar (
wk_ref VARCHAR(10) 		PRIMARY KEY
,  Debt_Code 		VARCHAR(12) 	NOT NULL
,  Client_Key 		VARCHAR(39)	NULL
,  sPC_Sector_GRI	INT		NOT NULL
,  sTOP_1000_PC_Sector	INT		NOT NULL
,  sTitle		INT		NULL
,  sForename		INT		NULL
,  sPhone_Data		INT		NULL
,  sCombined_Phone	INT		NULL
,  sAddress_Quality	INT		NULL
,  sProduct_Defintion	INT		NULL
,  sLitigation		INT		NULL
,  sAge_At_Default	INT		NULL
,  sNum_RA_Purchase	INT		NULL
,  sBalance_RA_Purchase	INT		NULL
,  sDAO_to_LPD		INT		NULL
,  sDefault_to_LPD	INT		NULL
,  sNumber_Phases	INT		NULL
,  sLPD_Ind		INT		NULL
,  sInterest_Ind	INT		NULL

)



INSERT INTO risk..BERT_ScoreChar( wk_ref , Debt_Code , Client_Key , sPC_Sector_GRI ,  sTOP_1000_PC_Sector , sTitle , sForename , sPhone_Data , sCombined_Phone, sAddress_Quality , sProduct_Defintion , sLitigation , sAge_At_Default , sNum_RA_Purchase , sBalance_RA_Purchase , sDAO_to_LPD , sDefault_to_LPD , sNumber_Phases, sLPD_Ind, sInterest_Ind)
SELECT	wk_ref
	,  Debt_Code
	,  Client_Key
	,  CASE 
		WHEN PC_Sector_GRI = 1 THEN 20
		WHEN PC_Sector_GRI = 2 THEN 19
		WHEN PC_Sector_GRI = 3 THEN 14
		WHEN PC_Sector_GRI = 4 THEN 8
		WHEN PC_Sector_GRI = 5 THEN 3
		WHEN PC_Sector_GRI = 6 THEN 0
		ELSE 10
	END AS sPC_Sector_GRI
	,  CASE 
		WHEN TOP_1000_PC_Sector = 0 THEN 0
		WHEN TOP_1000_PC_Sector = 1 THEN 73
		ELSE 1
	END AS sTOP_1000_PC_Sector
	,  CASE
		WHEN Title IN ('MR','MISS','GEN','DR','REV','SIT','CAPT','CORP','PROF') 	THEN 0
		WHEN Title IN ('MRS','MS') 							THEN 15
		ELSE 3
	END AS sTitle
	,  CASE
		WHEN Forename IS NULL 	THEN 29
		WHEN Forename = 1 	THEN 0
		WHEN Forename > 1 	THEN 33
	END AS sForename
	,  CASE
		WHEN (Phone_Data Like '%HOME%' OR Phone_Data LIKE '%BOTH' )	THEN 7
		WHEN Phone_Data IS NULL 					THEN 3
		ELSE 0
	END AS sPhone_Date
	
	,  CASE
		WHEN Combined_Phone = 0 	THEN 0
		WHEN Combined_Phone = 1 	THEN 9
		WHEN Combined_Phone = 2 	THEN 17
		WHEN Combined_Phone = 3 	THEN 6
		WHEN Combined_Phone IS NULL	THEN 6
	END AS sCombined_Phone
	,  CASE 
		WHEN Address_Quality = 'OK' 										THEN 20
		WHEN Address_Quality = 'Unknown' 									THEN 43
		WHEN Address_Quality IN ('None','PUT','Overseas','Prison','PO Box','Postcode','Unlikely','Forces') 	THEN 0
		WHEN Address_Quality IN ('C/O','Bankrupt','Business') 							THEN 60
		ELSE 29
	END AS sAddress_Quality 
	,  CASE
		WHEN Product_Defintion = 'Credit Card' 							THEN 29
		WHEN Product_Defintion = 'Current Account' 						THEN 3
		WHEN Product_Defintion IN('Loan','Preference Account','Retail Credit','Store Card') 	THEN 0
		WHEN Product_Defintion = 'Unknown' 							THEN 17
	END AS sProduct_Defintion 
	,  CASE
		WHEN Litigation IS NULL 		THEN 40
		WHEN Litigation = 0			THEN 48
		WHEN Litigation  IN (1,2)		THEN 6
		WHEN Litigation = 3			THEN 0
	END AS sLitigation   
	,  CASE
		WHEN Age_At_Default Between 15 AND 32 	THEN 38
		WHEN Age_At_Default Between 33 AND 38 	THEN 50
		WHEN Age_At_Default Between 39 AND 53 	THEN 60
		WHEN Age_At_Default Between 54 AND 110 	THEN 74
		WHEN Age_At_Default IS NULL 		THEN 0
	END AS sAge_At_Default
	,  CASE 
		WHEN (Num_RA_Purchase IS NULL OR (Num_RA_Purchase - 1)= 0) 	THEN 15
		WHEN (Num_RA_Purchase - 1) = 1 					THEN 41
		WHEN (Num_RA_Purchase - 1) = 2 					THEN 12
		WHEN (Num_RA_Purchase - 1) BETWEEN 3 AND 25 			THEN 0
	END AS sNum_RA_Purchase 
	,  CASE
		WHEN Balance_RA_Purchase BETWEEN 0 AND 3500 			THEN 8
		WHEN Balance_RA_Purchase > 3500 				THEN 0
		WHEN Balance_RA_Purchase IS NULL 				THEN 6
	END AS sBalance_RA_Purchase 
	,  CASE
		WHEN DAO_to_LPD BETWEEN 0 AND 3 	THEN 0
		WHEN DAO_to_LPD BETWEEN 4 AND 8 	THEN 16
		WHEN DAO_to_LPD BETWEEN 9 AND 13 	THEN 31
		WHEN DAO_to_LPD BETWEEN 14 AND 51 	THEN 63
		WHEN DAO_to_LPD BETWEEN 52 AND 300 	THEN 80
		WHEN DAO_to_LPD <0 			THEN 41
		WHEN DAO_to_LPD >300 			THEN 41
		WHEN DAO_to_LPD IS NULL 		THEN 28
	END AS sDAO_to_LPD
	,  CASE
		WHEN Default_to_LPD BETWEEN -60 AND -9 	THEN 8
		WHEN Default_to_LPD BETWEEN -8 AND -5 	THEN 17
		WHEN Default_to_LPD BETWEEN -4 AND -3 	THEN 36
		WHEN Default_to_LPD BETWEEN -2 AND 2	THEN 88
		WHEN Default_to_LPD BETWEEN 3 AND 120 	THEN 51
		WHEN Default_to_LPD  <-60 		THEN 25
		WHEN Default_to_LPD  >120 		THEN 25
		WHEN Default_to_LPD IS NULL 		THEN 0
	END AS sDefault_to_LPD 
	,  CASE
		WHEN Number_Phases IS NULL 		THEN 14
		WHEN Number_Phases = 0 			THEN 27
		WHEN Number_Phases = 1			THEN 48
		WHEN Number_Phases BETWEEN 2 AND 10 	THEN 0
	END AS sNumber_Phases
	,  CASE
		WHEN LPD_Ind = 0 THEN 0
		WHEN LPD_Ind = 1 THEN 6
		ELSE 5
	END AS sLPD_Ind	
	,  CASE 
		WHEN Interest_Ind = 0	THEN 39
		WHEN Interest_Ind = 1 	THEN 0
		ELSE 22
	END AS sInterest_Ind
		
FROM risk..BERT_FinalChar 
go

PRINT 'INDEX BERT_FinalChar'
CREATE INDEX iwk_ref on BERT_FinalChar(wk_ref)
go

IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'BERT_FinalScore')
BEGIN
	PRINT 'DROPING TABLE BERT_FinalScore' 
	DROP TABLE BERT_FinalScore
END
go

PRINT 'Make Table risk..BERT_FinalScore'
SELECT	wk_ref
	,  Debt_Code
	,  Client_Key
	,  280 + sPC_Sector_GRI +  sTOP_1000_PC_Sector + sTitle + sForename + sPhone_Data + sCombined_Phone+  sAddress_Quality + sProduct_Defintion + sLitigation + sAge_At_Default + sNum_RA_Purchase + sBalance_RA_Purchase + sDAO_to_LPD + sDefault_to_LPD + sNumber_Phases+ sLPD_Ind+ sInterest_Ind + 20 + 26 + 10 + 20 + 18 as Score

INTO	risk..BERT_FinalScore	
FROM	risk..BERT_ScoreChar

PRINT 'INDEX risk..BERT_FinalScore'
CREATE INDEX iAcc on risk..BERT_FinalScore(wk_ref)
go


	
