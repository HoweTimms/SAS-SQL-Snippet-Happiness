
/********************************************************/
/********************************************************/
/********************************************************/
/**********  GET SQL SERVER VERSION ********/
/********************************************************/
/********************************************************/
/********************************************************/


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL ="SELECT @@VERSION "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  IF OBJECT_ID('temp_MovedTo') IS NOT NULL DROP TABLE temp_MovedTo  "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL ="SELECT  movedto.wk_ref as wk_ref "
 "  , Max(seq_num) as seq_num "
 "  , (Year(movedto.dat) * 100 + Month(movedto.dat)) as Accounting_Period"
 "  INTO temp_MovedTo "
 "   FROM   dbo.tblCMSMovNarCaseMovedTo movedto "
 "   WHERE ( movedto.dat >= '01-JAN-2006' ) "
 "  GROUP BY movedto.wk_ref "
 "  , (Year(movedto.dat) * 100 + Month(movedto.dat)) "
"  ORDER BY movedto.wk_ref  "
 "  , Max(seq_num) "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  CREATE INDEX iwk_ref ON temp_MovedTo (wk_ref , seq_num) "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT * FROM  temp_DeDup "
"  WHERE wk_ref = '1025041'  "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.
CACHE.


/* 245,241*/

/* temp_MovedTo  */
/* temp_CaseMovedTo  */
GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT TOP 1000 moved.* FROM   temp_CaseMovedTo base , dbo.tblCMSMovNarCaseMovedTo moved "
" ,  temp_Account_Number ref where base.Account_Number = ref.Account_Number AND base.wk_ref = moved.wk_ref And base.seq_num = moved.seq_num "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.
CACHE.



GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  IF OBJECT_ID('temp_CaseMovedTo') IS NOT NULL DROP TABLE temp_CaseMovedTo "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  SELECT movedto.* "
"  ,   (Year(movedto.dat) * 100 + Month(movedto.dat)) as Accounting_Period "
"  ,  RTRIM(movedto.wk_ref) +  RTRIM(CAST(movedto.seq_num as char)) as Account_Number "
"  INTO temp_CaseMovedTo"
"  FROM  dbo.tblCMSMovNarCaseMovedTo movedto "
",   temp_MovedTo   ht "
"  WHERE movedto.wk_ref = ht.wk_ref "
"  AND movedto.dat >= '01-JAN-2006' "
"  AND movedto.seq_num = ht.seq_num "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

/ *     3748532 */

/* De duplication required */

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL ="DROP TABLE temp_Account_Number ".
EXE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  SELECT Account_Number "
"  , Count(*) as Obs "
"  INTO temp_Account_Number "
"  FROM temp_CaseMovedTo"
"  GROUP BY Account_Number, Accounting_Period  "
"  HAVING Count(*) > 1 "
"  ORDER BY Account_Number "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  SELECT COUNT(*) "
"  FROM temp_Account_Number base "
 /ASSUMEDSTRWIDTH=255.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  IF OBJECT_ID('temp_DeDup') IS NOT NULL DROP TABLE temp_DeDup "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  SELECT DISTINCT * "
"  INTO temp_DeDup "
"  FROM temp_CaseMovedTo base "
"  WHERE base.Account_Number In (SELECT ref.Account_Number FROM temp_Account_Number ref) "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  SELECT COUNT(*) "
"  FROM temp_DeDup base "
 /ASSUMEDSTRWIDTH=255
 .

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  DELETE "
"  FROM temp_CaseMovedTo "
"  WHERE Account_Number In (SELECT ref.Account_Number FROM temp_DeDup ref) "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  SELECT COUNT(*) "
"  FROM temp_CaseMovedTo base "
 /ASSUMEDSTRWIDTH=255
 .

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  INSERT INTO temp_CaseMovedTo "
"  SELECT * FROM temp_DeDup ref "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  CREATE INDEX iwk_ref ON temp_CaseMovedTo (wk_ref , seq_num) "
"  CREATE INDEX iwk_ref ON temp_CaseMovedTo (Account_Number) "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL = "SELECT Accounting_Period, Count(*) FROM temp_CaseMovedTo GROUP BY Accounting_Period"
"  ORDER BY Accounting_Period "
 /ASSUMEDSTRWIDTH=255
 .
EXE.

/********************************** HERE */

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL = 
"Select entry.Accounting_Period as Accounting_Period "
",  entry.Category as entry "
",  entry.strategy as estrat "
",  ex.Category as ex"
",  ex.strategy as extrat "
",  Count(*) as Obs "
"From temp_CaseMovedTo entry " 
",  temp_CaseMovedTo ex  "
"Where entry.Accounting_Period = '200601' "
"And ex.Accounting_Period = '200602' "
"And entry.wk_ref *= ex.wk_ref "
"GROUP BY entry.Accounting_Period , entry.Category , entry.strategy "
",  ex.Category , ex.strategy "
"  Union "
"Select entry.Accounting_Period as Accounting_Period "
",  entry.Category as entry "
",  entry.strategy as estrat "
",  ex.Category as ex"
",  ex.strategy as extrat "
",  Count(*) as Obs "
"From temp_CaseMovedTo entry " 
",  temp_CaseMovedTo ex  "
"Where entry.Accounting_Period = '200602' "
"And ex.Accounting_Period = '200603' "
"And entry.wk_ref *= ex.wk_ref "
"GROUP BY entry.Accounting_Period , entry.Category , entry.strategy "
",  ex.Category , ex.strategy "
"  ORDER BY entry.Accounting_Period , entry.Category, entry.strategy, ex.Category, ex.strategy  "
 /ASSUMEDSTRWIDTH=255
 .
EXE.
CACHE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL = " SELECT Category, strategy, COUNT(*) "
"From temp_CaseMovedTo entry " 
"GROUP By Category , strategy"
" ORDER BY Category , strategy"
 /ASSUMEDSTRWIDTH=255
 .
EXE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  IF OBJECT_ID('temp_CaseMovedSum') IS NOT NULL DROP TABLE temp_CaseMovedSum "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  SELECT   (Year(movedto.dat) * 100 + Month(movedto.dat)) as Accounting_Period "
"  ,  category "
"  , strategy "
"  ,  queue "
"  ,  Count(*) as Obs "
"  INTO temp_CaseMovedSum"
"  FROM  dbo.tblCMSMovNarCaseMovedTo movedto "
",   temp_MovedTo   ht "
"  WHERE movedto.wk_ref = ht.wk_ref "
"  AND movedto.dat >= '01-JAN-2006' "
"  AND movedto.seq_num = ht.seq_num "
"  GROUP BY  (Year(movedto.dat) * 100 + Month(movedto.dat)) "
"  ,  category "	
"  , strategy "
"  ,  queue "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.

/ *     3748532 */


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  IF OBJECT_ID('temp_MovedTo') IS NOT NULL DROP TABLE temp_MovedTo  "
 /ASSUMEDSTRWIDTH=255
 .
EXECUTE.



GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL ="SELECT TOP 10 *"
 "   FROM   temp_CaseMovedSum movedto "
 /ASSUMEDSTRWIDTH=255
.
EXE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL ="SELECT Accounting_Period, Category, COUNT(*) as Obs "
 "   FROM  temp_CaseMovedTo movedto "
"  GROUP BY Accounting_Period, Category "
"  ORDER BY Accounting_Period, Category "
 /ASSUMEDSTRWIDTH=255
.
EXE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL ="Select entry.* , ex.category as exit_cat , ex.dat as exit_date "
"From temp_CaseMovedTo entry " 
"  ,  temp_CaseMovedTo ex  "
"Where entry.Accounting_Period = '200601' "
"And ex.Accounting_Period = '200602' "
"And entry.wk_ref = ex.wk_ref "
"And entry.category = 'ACTMG' "
"And ex.category = 'CREL' "
 /ASSUMEDSTRWIDTH=255
.
EXE.