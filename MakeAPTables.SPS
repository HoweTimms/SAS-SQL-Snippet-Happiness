
GET FILE 'C:\Cassini\Data\BASEL\Mod\DCM_200208.sav'.

SORT CASES BY
  Account_Number (A) .
EXECUTE.

MATCH FILES /TABLE=*
 /FILE='C:\Cassini\Data\BASEL\Mod\Perform200208.sav'
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3
  d4 d5)
 /BY Account_Number
 /DROP= d0 d1 d2 d3 d4 d5.
EXECUTE.
