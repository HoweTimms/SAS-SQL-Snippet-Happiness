GET DATA 
  /TYPE=ODBC 
  /CONNECT=
'DSN=BD_Data_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
'DSN=SQLData_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
 /SQL = 
'SELECT  bigtable.wk_ref'
'  ,  (Case When bigtable.original_debt_value > 5000 then 10 else 20 end + Case When pricing.Combined_Balance > 5000 Then 1 Else 2 End )as ExpSeg'
'  ,  bigtable.original_debt_value'
'  ,  bigtable.bookon_date'
'  ,  Year(bigtable.bookon_date) * 100 + Month(bigtable.bookon_date)  as Accounting_Period'
'  ,  bigtable.vendor_last_payment_date'
'  ,  DateDiff('m',bigtable.bookon_date,bigtable.vendor_last_payment_date) as Customer_Intent'
'  FROM  dbo.tblbigtable bigtable'
'  ,  dbo.tbl_pricing_analysis pricing'
'  WHERE bigtable.wk_ref = pricing.wk_ref'
'  AND Datediff('m', bigtable.bookon_date,GETDATE()) <= 48'
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.




GET DATA 
  /TYPE=ODBC 
  /CONNECT='DSN=BD_Data_Warehouse;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=data_warehouse;Trusted_Connection=Yes'
  /SQL = 
'SELECT  bigtable.wk_ref'
'  FROM  dbo.tbl_pricing_analysis bigtable'
'  WHERE bigtable.wk_ref = '1000010''
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
EXECUTE.