

GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL ="SELECT  movedto.wk_ref "
"  , Year(movedto.dat) * 100 + Month(movedto.dat) as Accounting_Period"
"  , Max(seq_num) as seq_num "
"   FROM   dbo.tblCMSMovNarCaseMovedTo movedto "
"   WHERE ( movedto.dat >= '01/09/2002' ) "
"  GROUP BY movedto.wk_ref "
"  , Year(movedto.dat) * 100 + Month(movedto.dat) "
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.