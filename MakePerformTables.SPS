*  Adds the performance data to file

* Get File to append to

GET
  FILE='C:\Cassini\Data\BASEL\Mod\DCM_200208.sav'.

* Ensure no duplicates

MATCH FILES /FILE = *
 /FIRST = temp /BY Account_Number.
SELECT IF temp.
EXECUTE.

* Clean up

DELETE VARIABLES temp.

* Sort Cases so appends wont fail

SORT CASES BY
  Account_Number (A) .
EXECUTE.

* Append all data

MATCH FILES /FILE= *
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200208.sav'
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3
  d4 d5)
 /BY Account_Number
 /DROP= d0 d1 d2 d3 d4 d5.
EXECUTE.

RENAME VARIABLES (Fine=Fine200208).

FREQUENCIES
  VARIABLES=Fine200208
  /ORDER=  ANALYSIS .

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200209.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200209).	

FREQUENCIES
  VARIABLES=Fine200209
  /ORDER=  ANALYSIS .


MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200210.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	

RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200210).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200211.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	

RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.
	
RENAME VARIABLES (Fine=Fine200211).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200212.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	

RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200212).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200301.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200301).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200302.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	

RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.
	
RENAME VARIABLES (Fine=Fine200302).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200303.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200303).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200304.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200304).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200305.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200305).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200306.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200306).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200307.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RENAME VARIABLES (Fine=Fine200307).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200308.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200308).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200309.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200309).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200310.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.

RENAME VARIABLES (Fine=Fine200310).	

MATCH FILES /FILE= *	
 /FILE= 'C:\Cassini\Data\BASEL\Mod\Perform200311.sav'	
 /RENAME (Bad_Debt_Write_Off_Tag Enforcement_Category Fraud Number_of_Months_Arrears Trace Worst_Months_Arrears = d0 d1 d2 d3	
  d4 d5)	
 /BY Account_Number	
 /DROP= d0 d1 d2 d3 d4 d5.	
EXECUTE.	
	
RENAME VARIABLES (Fine=Fine200311).	

RECODE
  Fine200208
  (MISSING=1)  (ELSE=0)  INTO  temp1 .
EXECUTE .


FILTER OFF.
USE ALL.
SELECT IF(temp1=0).
EXECUTE .

DELETE VARIABLES temp1.








