


GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL =
"SELECT  movedto.* "
",  bigtable.original_debt_value "
",  bigtable.bookon_date "
",  Year(bigtable.bookon_date) * 100 + Month(bigtable.bookon_date)  as Accounting_Period "
",  DateDiff("m",bigtable.bookon_date,movedto.dat) as Maturity "
"   FROM   dbo.tblbigtable bigtable "
",  dbo.tblCMSMovNarCaseMovedTo movedto "
"  WHERE bigtable.wk_ref = movedto.wk_ref "
"  AND movedto.wk_ref = 1000028 "
"  AND movedto.seq_num = ( "
"  SELECT Max(child.seq_num) "
"  FROM dbo.tblCMSMovNarCaseMovedTo child "
"  WHERE child.wk_ref = movedto.wk_ref "
"  AND DateDiff("m",child.seq_num , GETDATE() )= DateDiff("m",movedto.seq_num , GETDATE() )"
"  GROUP BY child.wk_ref ) "
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.




GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL ="SELECT  TOP 10 movedto.* "
"   FROM   dbo.tblCMSMovNarCaseMovedTo movedto "
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.