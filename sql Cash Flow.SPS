

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=BD_Data_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"SELECT "
"    [TableName] = so.name, "
"    [RowCount] = MAX(si.rows) "
"    ,  MAX(si.Indid) as Inde "
"FROM "
"    sysobjects so, "
"    sysindexes si "
" WHERE "
"    so.xtype = 'U' "
"    AND "
"    si.id = OBJECT_ID(so.name) "
"  AND so.name like 'temp%' "
"GROUP BY "
"    so.name "
" ORDER BY "
"    2 DESC "
.
                                                                                           
GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
 "IF OBJECT_ID('temp_Original_Value') IS NOT NULL DROP TABLE temp_Original_Value "
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
 "SELECT bigtable.wk_ref "
 "  ,  bigtable.original_debt_value "
 "  ,  bigtable.bookon_date "
 "  ,  Year(bigtable.bookon_date) * 100 + Month(bigtable.bookon_date)  as Accounting_Period "
 "  ,  bigtable.vendor_last_payment_date "
 "  ,  bigtable.[SC1 Score] "
 "  ,  bigtable.default_date "
 "  ,  bookon.portfolio "
 "  ,  bookon.package_id "
"  INTO  temp_Original_Value "
 "  FROM  dbo.tblbigtable bigtable "
 "  ,  dbo.vw_book_ons bookon "
 "  WHERE bigtable.package_id = bookon.package_id "
 "  AND bookon.portfolio like 'Argos%' "
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" CREATE INDEX iWk_Ref on temp_Original_Value (wk_ref) "
 .
CACHE.
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
 "IF OBJECT_ID('temp_Cash_Flow') IS NOT NULL DROP TABLE temp_Cash_Flow "
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"  SELECT bigtable.wk_ref "
"  , DateDiff("m",bigtable.bookon_date,debtrans.[tx-date]) AS Maturity "
"  , Sum(debtrans.[tx-amount]) AS Tx_Amount "
"  INTO temp_Cash_Flow "
"  FROM dbo.RV_debttrans debtrans "
"  , temp_Original_Value bigtable "
"  WHERE bigtable.wk_ref=debtrans.[debt-code] "
"  GROUP BY bigtable.wk_ref "
"  ,DateDiff("m",bigtable.Bookon_Date,debtrans.[tx-date]) "
"  ORDER BY bigtable.wk_ref "
"  ,  Maturity "
/ASSUMEDSTRWIDTH=255
.
CACHE.
EXECUTE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" CREATE INDEX iWk_Ref on temp_Cash_Flow (wk_ref) "
 .
CACHE.
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL = "SELECT COUNT(*) FROM  temp_Cash_Flow "
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =  "IF OBJECT_ID('temp_CashMaturity') IS NOT NULL DROP TABLE temp_CashMaturity "
.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
 "SELECT    orig.wk_ref "
 ",  SUM ( CASE WHEN cash.Maturity <=1 Then cash.Tx_Amount Else 0 End ) as Cash_01  "
 ",  SUM ( CASE WHEN cash.Maturity <=2 Then cash.Tx_Amount Else 0 End ) as Cash_02  "
 ",  SUM ( CASE WHEN cash.Maturity <=3 Then cash.Tx_Amount Else 0 End ) as Cash_03  "
 ",  SUM ( CASE WHEN cash.Maturity <=4 Then cash.Tx_Amount Else 0 End ) as Cash_04  "
 ",  SUM ( CASE WHEN cash.Maturity <=5 Then cash.Tx_Amount Else 0 End ) as Cash_05  "
 ",  SUM ( CASE WHEN cash.Maturity <=6 Then cash.Tx_Amount Else 0 End ) as Cash_06  "
 ",  SUM ( CASE WHEN cash.Maturity <=7 Then cash.Tx_Amount Else 0 End ) as Cash_07  "
 ",  SUM ( CASE WHEN cash.Maturity <=8 Then cash.Tx_Amount Else 0 End ) as Cash_08  "
 ",  SUM ( CASE WHEN cash.Maturity <=9 Then cash.Tx_Amount Else 0 End ) as Cash_09  "
 ",  SUM ( CASE WHEN cash.Maturity <=10 Then cash.Tx_Amount Else 0 End ) as Cash_10  "
 ",  SUM ( CASE WHEN cash.Maturity <=11 Then cash.Tx_Amount Else 0 End ) as Cash_11  "
 ",  SUM ( CASE WHEN cash.Maturity <=12 Then cash.Tx_Amount Else 0 End ) as Cash_12  "
 ",  SUM ( CASE WHEN cash.Maturity <=13 Then cash.Tx_Amount Else 0 End ) as Cash_13  "
 ",  SUM ( CASE WHEN cash.Maturity <=14 Then cash.Tx_Amount Else 0 End ) as Cash_14  "
 ",  SUM ( CASE WHEN cash.Maturity <=15 Then cash.Tx_Amount Else 0 End ) as Cash_15  "
 ",  SUM ( CASE WHEN cash.Maturity <=16 Then cash.Tx_Amount Else 0 End ) as Cash_16  "
 ",  SUM ( CASE WHEN cash.Maturity <=17 Then cash.Tx_Amount Else 0 End ) as Cash_17  "
 ",  SUM ( CASE WHEN cash.Maturity <=18 Then cash.Tx_Amount Else 0 End ) as Cash_18  "
 ",  SUM ( CASE WHEN cash.Maturity <=19 Then cash.Tx_Amount Else 0 End ) as Cash_19  "
 ",  SUM ( CASE WHEN cash.Maturity <=20 Then cash.Tx_Amount Else 0 End ) as Cash_20  "
 ",  SUM ( CASE WHEN cash.Maturity <=21 Then cash.Tx_Amount Else 0 End ) as Cash_21  "
 ",  SUM ( CASE WHEN cash.Maturity <=22 Then cash.Tx_Amount Else 0 End ) as Cash_22  "
 ",  SUM ( CASE WHEN cash.Maturity <=23 Then cash.Tx_Amount Else 0 End ) as Cash_23  "
 ",  SUM ( CASE WHEN cash.Maturity <=24 Then cash.Tx_Amount Else 0 End ) as Cash_24  "
 ",  SUM ( CASE WHEN cash.Maturity <=25 Then cash.Tx_Amount Else 0 End ) as Cash_25  "
 ",  SUM ( CASE WHEN cash.Maturity <=26 Then cash.Tx_Amount Else 0 End ) as Cash_26  "
 ",  SUM ( CASE WHEN cash.Maturity <=27 Then cash.Tx_Amount Else 0 End ) as Cash_27  "
 ",  SUM ( CASE WHEN cash.Maturity <=28 Then cash.Tx_Amount Else 0 End ) as Cash_28  "
 ",  SUM ( CASE WHEN cash.Maturity <=29 Then cash.Tx_Amount Else 0 End ) as Cash_29  "
 ",  SUM ( CASE WHEN cash.Maturity <=30 Then cash.Tx_Amount Else 0 End ) as Cash_30  "
 ",  SUM ( CASE WHEN cash.Maturity <=31 Then cash.Tx_Amount Else 0 End ) as Cash_31  "
 ",  SUM ( CASE WHEN cash.Maturity <=32 Then cash.Tx_Amount Else 0 End ) as Cash_32  "
 ",  SUM ( CASE WHEN cash.Maturity <=33 Then cash.Tx_Amount Else 0 End ) as Cash_33  "
 ",  SUM ( CASE WHEN cash.Maturity <=34 Then cash.Tx_Amount Else 0 End ) as Cash_34  "
 ",  SUM ( CASE WHEN cash.Maturity <=35 Then cash.Tx_Amount Else 0 End ) as Cash_35  "
 ",  SUM ( CASE WHEN cash.Maturity <=36 Then cash.Tx_Amount Else 0 End ) as Cash_36  "
 "  INTO temp_CashMaturity "
 "  FROM   temp_Original_Value orig"
 ",  temp_Cash_Flow cash"
 "  WHERE orig.wk_ref *= cash.wk_ref"
 "  GROUP BY   orig.wk_ref "
 " ORDER BY orig.wk_ref "  
 /ASSUMEDSTRWIDTH=255
.
EXE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" CREATE INDEX iWk_Ref on temp_CashMaturity (wk_ref) "
 .
CACHE.
EXECUTE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL = "SELECT COUNT(*) FROM  temp_CashMaturity "
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.



GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =  "IF OBJECT_ID('temp_results') IS NOT NULL DROP TABLE temp_results  "
 /ASSUMEDSTRWIDTH=255
.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
 "SELECT    orig.portfolio"
",  SUM ( original_debt_value ) as original_debt_value "
",  SUM ( Cash_01 ) as Cash_01  "
",  SUM ( Cash_02 ) as Cash_02  "
",  SUM ( Cash_03 ) as Cash_03  "
",  SUM ( Cash_04 ) as Cash_04  "
",  SUM ( Cash_05 ) as Cash_05  "
",  SUM ( Cash_06 ) as Cash_06  "
",  SUM ( Cash_07 ) as Cash_07  "
",  SUM ( Cash_08 ) as Cash_08  "
",  SUM ( Cash_09 ) as Cash_09  "
",  SUM ( Cash_10 ) as Cash_10  "
",  SUM ( Cash_11 ) as Cash_11  "
",  SUM ( Cash_12 ) as Cash_12  "
",  SUM ( Cash_13 ) as Cash_13  "
",  SUM ( Cash_14 ) as Cash_14  "
",  SUM ( Cash_15 ) as Cash_15  "
",  SUM ( Cash_16 ) as Cash_16  "
",  SUM ( Cash_17 ) as Cash_17  "
",  SUM ( Cash_18 ) as Cash_18  "
",  SUM ( Cash_19 ) as Cash_19  "
",  SUM ( Cash_20 ) as Cash_20  "
",  SUM ( Cash_21 ) as Cash_21  "
",  SUM ( Cash_22 ) as Cash_22  "
",  SUM ( Cash_23 ) as Cash_23  "
",  SUM ( Cash_24 ) as Cash_24  "
",  SUM ( Cash_25 ) as Cash_25  "
",  SUM ( Cash_26 ) as Cash_26  "
",  SUM ( Cash_27 ) as Cash_27  "
",  SUM ( Cash_28 ) as Cash_28  "
",  SUM ( Cash_29 ) as Cash_29  "
",  SUM ( Cash_30 ) as Cash_30  "
",  SUM ( Cash_31 ) as Cash_31  "
",  SUM ( Cash_32 ) as Cash_32  "
",  SUM ( Cash_33 ) as Cash_33  "
",  SUM ( Cash_34 ) as Cash_34  "
",  SUM ( Cash_35 ) as Cash_35  "
",  SUM ( Cash_36 ) as Cash_36  "
 "  FROM   temp_Original_Value orig"
 ",   temp_CashMaturity cash"
 "  WHERE orig.wk_ref = cash.wk_ref"
"  GROUP BY   orig.portfolio"
"  ORDER BY   orig.portfolio"
 /ASSUMEDSTRWIDTH=255
.
EXE.



/****************************************************************/
/************* Check for my tables **************************/

 /* 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes' */
/*  'DSN=BD_Data_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes' */

GET DATA
 /TYPE=ODBC
 /CONNECT=
'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes' 
 /SQL =
"SELECT "
"    [TableName] = so.name, "
"    [RowCount] = MAX(si.rows) "
"FROM "
"    sysobjects so, "
"    sysindexes si "
" WHERE "
"    so.xtype = 'U' "
"    AND "
"    si.id = OBJECT_ID(so.name) "
" AND so.name like 'temp%' "
"GROUP BY "
"    so.name "
" ORDER BY "
"    2 DESC "
.



GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=BD_Data_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" IF OBJECT_ID('temp_rv_debttrans') IS NOT NULL DROP TABLE temp_rv_debttrans "
" IF OBJECT_ID('temp_Cash_Flow') IS NOT NULL DROP TABLE temp_Cash_Flow "
" IF OBJECT_ID('temp_CashMaturity') IS NOT NULL DROP TABLE temp_CashMaturity "
" IF OBJECT_ID('temp_CashWeight') IS NOT NULL DROP TABLE temp_CashWeight "
" IF OBJECT_ID('temp_Original_Value') IS NOT NULL DROP TABLE temp_Original_Value "
" IF OBJECT_ID('temp_results') IS NOT NULL DROP TABLE temp_results "
" IF OBJECT_ID('temp_weightresult') IS NOT NULL DROP TABLE temp_weightresult "
" IF OBJECT_ID('temp_main') IS NOT NULL DROP TABLE temp_main "
" IF OBJECT_ID('temp_Definition') IS NOT NULL DROP TABLE temp_Definition "
/ASSUMEDSTRWIDTH=255
.
EXE.

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
" SELECT * FROM temp_Original_Value "
/ASSUMEDSTRWIDTH=255
.
EXE.
*Visual Bander.
EXECUTE.
