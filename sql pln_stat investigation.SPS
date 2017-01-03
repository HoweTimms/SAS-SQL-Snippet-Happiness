

GET DATA
 /TYPE=ODBC
 /CONNECT=
 "DSN=odbc_MAIN_Data_CI;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=main_data_ci;Trusted_Connection=Yes"
 /SQL =
"SELECT pln.src_wk_ref "
", pln.pln_num"
", pln.partition_code"
", pln.u_version"
", pln.src_sys"
", pln.src_sub_seq"
", pln.pln_typ"
", pln.pln_stat"
", pln.temp_cd"
", pln.cre_dat"
", pln.end_dat"
", pln.lst_chk_dat"
", pln.nxt_chk_dat"
", pln.nxt_review"
", pln.usr_cd"
", pln.canc_dat"
", pln.canc_reas"
", pln.act_rev"
", pln.pln_score "
"FROM dbo.cms_pln pln "
" /* Exclude cases where plan status is Provisional Cancelled or Pending Deletion */ "
"WHERE  (pln.pln_stat IN ('A','C','F')) "
" AND pln_num = ( "
"Select 	MAX(pln_num) "
"FROM 	dbo.cms_pln child "
"Where	pln.src_wk_ref = child.src_wk_ref "
"GROUP BY child.src_wk_ref )"
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.


GET DATA
 /TYPE=ODBC
 /CONNECT=
 "DSN=odbc_MAIN_Data_CI;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=main_data_ci;Trusted_Connection=Yes"
 /SQL =
"SELECT pln.* "
" ,  Year(pln.cre_dat) * 100 + Month(pln.cre_dat)  as Accounting_Period "
"FROM dbo.cms_pln pln "
"WHERE  (pln.src_wk_ref IN (1000025,1000047,1000058,1000071,1000142,1000178,1000198,1000203,1000212,1000257)) "
" ORDER BY pln.src_wk_ref Asc"
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.	


GET DATA
 /TYPE=ODBC
 /CONNECT=
 "DSN=odbc_MAIN_Data_CI;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=main_data_ci;Trusted_Connection=Yes"
 /SQL =
"SELECT TOP 10 pln.* "
" ,  Year(pln.cre_dat) * 100 + Month(pln.cre_dat)  as Accounting_Period "
"FROM dbo.cms_pln pln "
"WHERE  (pln.pln_stat = 'B')"
" ORDER BY pln.src_wk_ref Asc"
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE. 
