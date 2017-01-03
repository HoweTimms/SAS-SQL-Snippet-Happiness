
GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT tblvendor_data.[Title (1)]"
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY tblvendor_data.[Title (1)] "
"  ORDER BY tblvendor_data.[Title (1)] "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT Len(tblvendor_data.[Inits (1)]) as dInChar, Len(tblvendor_data.[Forename (1)]) as dForeChar "
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY Len(tblvendor_data.[Inits (1)]) , Len(tblvendor_data.[Forename (1)])  "
"  ORDER BY  Len(tblvendor_data.[Inits (1)]) , Len(tblvendor_data.[Forename (1)]) "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.



GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT Top 50 * "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  WHERE Len(tblvendor_data.[Inits (1)])  IS NULL "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.

/*  Both NULL and Lenght 0 Initial cases exist!!! */


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT tblvendor_data.[Phone Data]"
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY tblvendor_data.[Phone Data] "
"  ORDER BY tblvendor_data.[Phone Data] "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT tblvendor_data.[Phone Data]"
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY tblvendor_data.[Phone Data] "
"  ORDER BY tblvendor_data.[Phone Data] "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT (CASE WHEN (tblvendor_data.[Home Tel (conv)] IS NULL OR tblvendor_data.[Home Tel (conv)] = '') THEN 0 ELSE 1 END) + (CASE WHEN (tblvendor_data.[Work Tel (conv)] IS NULL OR tblvendor_data.[Work Tel (conv)] = '') THEN 0 ELSE 1 END) + (CASE WHEN (tblvendor_data.[Other Tel (conv)] IS NULL OR tblvendor_data.[Other Tel (conv)] = '') THEN 0 ELSE 1 END) as Ind_Total_Tel   "
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY (CASE WHEN (tblvendor_data.[Home Tel (conv)] IS NULL OR tblvendor_data.[Home Tel (conv)] = '') THEN 0 ELSE 1 END) + (CASE WHEN (tblvendor_data.[Work Tel (conv)] IS NULL OR tblvendor_data.[Work Tel (conv)] = '') THEN 0 ELSE 1 END) + (CASE WHEN (tblvendor_data.[Other Tel (conv)] IS NULL OR tblvendor_data.[Other Tel (conv)] = '') THEN 0 ELSE 1 END) "
"  ORDER BY (CASE WHEN (tblvendor_data.[Home Tel (conv)] IS NULL OR tblvendor_data.[Home Tel (conv)] = '') THEN 0 ELSE 1 END) + (CASE WHEN (tblvendor_data.[Work Tel (conv)] IS NULL OR tblvendor_data.[Work Tel (conv)] = '') THEN 0 ELSE 1 END) + (CASE WHEN (tblvendor_data.[Other Tel (conv)] IS NULL OR tblvendor_data.[Other Tel (conv)] = '') THEN 0 ELSE 1 END) "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT tblvendor_data.[Address Score] "
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY tblvendor_data.[Address Score] "
"  ORDER BY tblvendor_data.[Address Score] "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.


tblvendor_data.[Account Type/Brand]


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT tblvendor_data.[Account Type/Brand] "
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY tblvendor_data.[Account Type/Brand] "
"  ORDER BY tblvendor_data.[Account Type/Brand] "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT tblvendor_data.[Account Type/Brand]"
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY tblvendor_data.[Account Type/Brand] "
"  ORDER BY tblvendor_data.[Account Type/Brand] "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.



GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT tblvendor_data.[Legal A/C Marker]  "
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY tblvendor_data.[Legal A/C Marker]  "
"  ORDER BY tblvendor_data.[Legal A/C Marker]  "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT DateDiff("Years",tblvendor_data.[Judgement Date] "
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY tblvendor_data.[Judgement Date] "
"  ORDER BY tblvendor_data.[Judgement Date] "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.



GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT 	CASE WHEN tblvendor_data.DOB IS NULL THEN 99999 "
"		WHEN tblvendor_data.[Default Date] IS NULL THEN 99998 "
"		ELSE Datediff("Year",tblvendor_data.DOB,tblvendor_data.[Default Date]) END as dAge_At_Default  "
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY CASE WHEN tblvendor_data.DOB IS NULL THEN 99999 "
"		WHEN tblvendor_data.[Default Date] IS NULL THEN 99998 "
"		ELSE Datediff("Year",tblvendor_data.DOB,tblvendor_data.[Default Date]) END "
"  ORDER BY CASE WHEN tblvendor_data.DOB IS NULL THEN 99999 "
"		WHEN tblvendor_data.[Default Date] IS NULL THEN 99998  "
"		ELSE Datediff("Year",tblvendor_data.DOB,tblvendor_data.[Default Date]) END "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT 	CASE WHEN tblvendor_data.DOB IS NULL THEN 99999 "
"		WHEN tblvendor_data.[Default_Date] IS NULL THEN 99998 "
"		ELSE Datediff("Year",tblvendor_data.DOB,tblvendor_data.[Default_Date]) END as dAge_At_Default  "
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblbigtable as tblvendor_data"
"  GROUP BY CASE WHEN tblvendor_data.DOB IS NULL THEN 99999 "
"		WHEN tblvendor_data.[Default_Date] IS NULL THEN 99998 "
"		ELSE Datediff("Year",tblvendor_data.DOB,tblvendor_data.[Default_Date]) END "
"  ORDER BY CASE WHEN tblvendor_data.DOB IS NULL THEN 99999 "
"		WHEN tblvendor_data.[Default_Date] IS NULL THEN 99998  "
"		ELSE Datediff("Year",tblvendor_data.DOB,tblvendor_data.[Default_Date]) END "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.



GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT 	TOP 1000  *"
"  FROM  dbo.tblbigtable as tblvendor_data"
"  WHERE tblvendor_data.DOB IS NULL "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"IF OBJECT_ID('ht_big_CustomerKey ') IS NOT NULL "
"    DROP TABLE ht_big_CustomerKey "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
 "SELECT bigtable.wk_ref "
 "  ,  Left(LTRIM(RTRIM(bigtable.forename)),1) + LTRIM(RTRIM(bigtable.surname)) + CONVERT(varchar,bigtable.dob,103) as CustomerIdent "
 "  INTO ht_big_CustomerKey "
 "  FROM  dbo.tblbigtable bigtable "
 "  WHERE bigtable.dob is not null "
 "  AND ( LTRIM(RTRIM(bigtable.forename)) LIKE '[A-Z]%' OR LTRIM(RTRIM(bigtable.forename)) LIKE '[a-z]%' ) "
 "  AND bigtable.surname is not null "
 "  ORDER BY CustomerIdent , bigtable.wk_ref  "
 /ASSUMEDSTRWIDTH=255.
CACHE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
 "SELECT TOP 100 bigtable.wk_ref "
 "  ,  LEFT(REPLACE(bigtable.forename,' ',''),1) + REPLACE(bigtable.surname,' ','') + CONVERT(varchar,bigtable.dob,103) as CustomerIdent "
 "  FROM  dbo.tblbigtable bigtable "
 "  WHERE bigtable.dob is not null "
 "  AND ( LTRIM(RTRIM(bigtable.forename)) LIKE '[A-Z]%' OR LTRIM(RTRIM(bigtable.forename)) LIKE '[a-z]%' ) "
 "  AND bigtable.surname is not null "
 "  ORDER BY CustomerIdent , bigtable.wk_ref  "
 /ASSUMEDSTRWIDTH=255.
CACHE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL = "  CREATE INDEX iCust on ht_big_CustomerKey(CustomerIdent) ".

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
 "SELECT TOP 1000 * "
"  , (Select Count(*) from ht_big_CustomerKey child Where parent.CustomerIdent = child.CustomerIdent ) "
 "  FROM  ht_big_CustomerKey parent"
 "  WHERE (Select Count(*) from ht_big_CustomerKey child Where parent.CustomerIdent = child.CustomerIdent ) > 10 "
 /ASSUMEDSTRWIDTH=255.
CACHE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL = " SELECT CustomerIdent "
  "  , COUNT(*) as Obs "
  "  INTO ht_CustomerRA "
  "  FROM  ht_big_CustomerKey "
  "  GROUP BY CustomerIdent "
  "  ORDER BY CustomerIdent ".

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
 "SELECT Obs as RA "
  "  ,  COUNT(*) as Obs "
 "  FROM ht_CustomerRA "
"  GROUP BY Obs "
 /ASSUMEDSTRWIDTH=255.
CACHE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL ="  SELECT Count(*) as Obs "
  "  FROM  dbo.tblbigtable bigtable "
  "  WHERE  bigtable.surname IS NULL "
 /ASSUMEDSTRWIDTH=255.
CACHE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL ="  SELECT LTRIM(RTRIM(bigtable.forename)) as bigForename "
  "  ,  Count(*) as Obs "
  "  FROM  dbo.tblbigtable bigtable "
  "  WHERE ( LTRIM(RTRIM(bigtable.forename)) NOT LIKE '[A-Z]%' OR LTRIM(RTRIM(bigtable.forename)) NOT LIKE '[a-z]%' ) "
  "  GROUP BY LTRIM(RTRIM(bigtable.forename))  "
 /ASSUMEDSTRWIDTH=255.
CACHE.




"  ,  Datediff("Month",tblvendor_data.[Date Account Opened],tblvendor_data.[Last Payment Date]) as dDAO_to_LPD "

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT 	CASE WHEN tblvendor_data.[Date Account Opened] IS NULL THEN 99999 "
"		WHEN tblvendor_data.[Last Payment Date] IS NULL THEN 99998 "
"		ELSE Datediff("Year",tblvendor_data.[Date Account Opened],tblvendor_data.[Last Payment Date]) END as dDAO_to_LPD "
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  GROUP BY CASE WHEN tblvendor_data.[Date Account Opened] IS NULL THEN 99999 "
"		WHEN tblvendor_data.[Last Payment Date] IS NULL THEN 99998 "
"		ELSE Datediff("Year",tblvendor_data.[Date Account Opened],tblvendor_data.[Last Payment Date])  END "
"  ORDER BY CASE WHEN tblvendor_data.[Date Account Opened] IS NULL THEN 99999 "
"		WHEN tblvendor_data.[Last Payment Date] IS NULL THEN 99998  "
"		ELSE Datediff("Year",tblvendor_data.[Date Account Opened],tblvendor_data.[Last Payment Date]) END "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT tblvendor_data.[Phone Data]"
"  ,  COUNT(*) as Obs "
"  FROM  dbo.tblvendor_data as tblvendor_data"
"  WHERE (CASE WHEN (tblvendor_data.[Home Tel (conv)] IS NULL OR tblvendor_data.[Home Tel (conv)] = '') THEN 0 ELSE 1 END) + (CASE WHEN (tblvendor_data.[Work Tel (conv)] IS NULL OR tblvendor_data.[Work Tel (conv)] = '') THEN 0 ELSE 1 END) + (CASE WHEN (tblvendor_data.[Other Tel (conv)] IS NULL OR tblvendor_data.[Other Tel (conv)] = '') THEN 0 ELSE 1 END) >=2 "
"  GROUP BY tblvendor_data.[Phone Data] "
"  ORDER BY tblvendor_data.[Phone Data] "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.


 "  ,  dbo.vw_book_ons bookon "
 "  WHERE bigtable.package_id = bookon.package_id "
 "  AND bookon.portfolio like 'Argos%' "
"   AND [purchase date] = '29-July-2005' "



GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT TOP 100 * "
"  FROM  dbo.tblvendor_data as Vendor"
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.
DATASET DECLARE Aggregate.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT TOP 100 "
"  tblvendor_data.[Debt-code] "
"  ,  tblvendor_data.[Vendor Account Number] "
"  ,  UPPER(REPLACE(tblvendor_data.Postcode,' ','')) as PostCode "
"  ,  CASE 	WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][0-9][0-9][A-Z][A-Z]' 		THEN 1"
"  		WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][0-9][0-9][0-9][A-Z][A-Z]' 	THEN 2 "
"  		WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][A-Z][0-9][0-9][A-Z][A-Z]' 	THEN 3 "
" 		WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][A-Z][0-9][0-9][0-9][A-Z][A-Z]' 	THEN 4 "
"  		WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][0-9][A-Z][0-9][A-Z][A-Z]' 	THEN 5 "
"  		WHEN UPPER(REPLACE(tblvendor_data.Postcode,' ','')) LIKE '[A-Z][A-Z][0-9][A-Z][0-9][A-Z][A-Z]' 	THEN 6 "
"  ELSE -99 "
"  END as vPostCode "
"  ,  'XX999' C02_PAFS "
"  ,  REPLACE(tblvendor_data.[Title (1)],' ','') as Title "
"  ,  REPLACE(tblvendor_data.[Forename (1)],' ','') as Forename "
"  ,  REPLACE(tblvendor_data.[Inits (1)],' ','') as Initials " 
"  ,  tblvendor_data.[Phone Data] "
"  ,  tblvendor_data.[Address Data?] "
"  ,  tblvendor_data.[Address Score] "
"  ,  tblvendor_data.[Account Type/Brand] "
"  ,  tblvendor_data.[Default Date] "
"  ,  tblvendor_data.DOB "
"  ,  tblvendor_data.[Legal A/C Marker] "
"  ,  tblvendor_data.[Judgement Date] "
"  ,  tblvendor_data.[Last Payment Date] "
"  ,  tblvendor_data.[Date Account Opened] "
"  ,  tblvendor_data.[Interest Rate Applied by Vendor] "
"  ,  Datediff("Month",tblvendor_data.DOB,tblvendor_data.[Default Date]) as dAge_At_Default "
"  ,  Datediff("Month",tblvendor_data.[Date Account Opened],tblvendor_data.[Last Payment Date]) as dDAO_to_LPD "
"  ,  Datediff("Month",tblvendor_data.[Default Date],tblvendor_data.[Last Payment Date]) as dDefault_to_LPD "
"  FROM  dbo.tblvendor_data as tblvendor_data"
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =


**********************************
	"  "  ,  tblvendor_data.[Home Tel (conv)] as Home_Tel "
	"  , CASE WHEN (tblvendor_data.[Home Tel (conv)] IS NULL OR tblvendor_data.[Home Tel (conv)] = '') THEN 0 ELSE 1 END as Ind_Home_Tel "
	"  ,  tblvendor_data.[Work Tel (conv)] "
	"  ,  tblvendor_data.[Other Tel (conv)] " 
	"  , (CASE WHEN (tblvendor_data.[Home Tel (conv)] IS NULL OR tblvendor_data.[Home Tel (conv)] = '') THEN 0 ELSE 1 END) + (CASE WHEN (tblvendor_data.[Work Tel (conv)] IS NULL OR tblvendor_data.[Work Tel (conv)] = '') THEN 0 ELSE 1 END) + (CASE WHEN (tblvendor_data.[Other Tel (conv)] IS NULL OR tblvendor_data.[Other Tel (conv)] = '') THEN 0 ELSE 1 END) as Ind_Total_Tel  " 
**********************************.






GET DATA  /TYPE = TXT
 /FILE = 'N:\acquisitions\Scorecard work\Delivery Pack\Postcode_Sector_Database.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 Postcode_Sector A5
 Res_Pop F5.2
 Res_Pop_M F4.2
 Res_Pop_F F4.2
 Households F4.2
 Bird_Bloke_Ratio F4.2
 Bird_Bloke_Index F3.2
 LT_Unemp_Rate F4.2
 LT_Unemp_index F3.2
 Married_PC F5.2
 Married_Index F3.2
 Born_Overseas_PC F5.2
 Born_Overseas_Index F3.2
 Good_Health_PC F5.2
 Good_Health_Index F3.2
 No_Qual_PC F5.2
 No_Qual_Index F3.2
 Detached_House_PC F5.2
 Detached_House_Index F3.2
 No_Car_PC F5.2
 No_Car_Index F3.2
 Ave_Household_Pop F4.2
 Ave_Household_Pop_Index F3.2
 Ave_Num_Rooms_Household F4.2
 Ave_Num_Rooms_Household_Index F3.2
 Lone_Parent_House_PC F5.2
 Lone_Parent_Index F3.2
 Employed_Manager_PC F5.2
 Employed_Manager_Index F3.2
 PC_Sector_Strength F4.2
 Cabot_Recs F3.2
 Cabot_BR F3.2
 Cabot_Pen F4.2
 Cabot_House_Pen F4.2
 Cabot_Pen_Index F3.2
 Cabot_House_Pen_Index F3.2
 PC_Risk_Rank F4.2
 Top_1000_PC_Sector F1.0
 postcode_area A2
 Postcode_Region_Risk F1.0
 Geog_Area A4
 Geo_Risk_Score F3.2
 PC_Sector_GRI F1.0
 .
CACHE.
EXECUTE.
DATASET NAME DataSet2 WINDOW=FRONT.
SAVE OUTFILE='C:\My Documents\Risk\Project\Bert\Data\SPSS (SAV)\PostCode Sector Database.sav'
 /COMPRESSED.

GET FILE 'C:\My Documents\Risk\Project\Bert\Data\SPSS (SAV)\PostCode Sector Database.sav'.

