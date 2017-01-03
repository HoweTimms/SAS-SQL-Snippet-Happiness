*  http://pages.infinit.net/rlevesqu/Syntax/WorkingWithManyFiles/RunMacroOnSeveralFiles.txt
* How can run the same macro on several different files?
* Answer by Ray.
* This macro gets the data files; 


DEFINE !GETIT ().

!DO !var=200208 !TO 200208.
GET FILE !QUOTE(!CONCAT("C:\Cassini\Data\BASEL\Perform",!var,".sav")).

* Call macro to do analysis.
!DOWORK.
!GBFINE.

SAVE OUTFILE=!QUOTE(!CONCAT("C:\Cassini\Data\BASEL\Mod\Perform",!var,".sav")) 
/COMPRESSED.

!GBRes.

* This line saves output file for previous commands

SCRIPT file="c:\program files\spss\scripts\SaveClose.sbs" 
	/(!QUOTE(!CONCAT("C:\Cassini\Data\BASEL\Mod\Perform",!var,".spo"))).
EXECUTE.

!DOEND.


!ENDDEFINE.


* This macro does the analysis of each file.

DEFINE !DOWORK().

* Sort Cases for Later Merge.
SORT CASES BY
  Account_Number (A) .
EXECUTE.

!ENDDEFINE.


DEFINE !GBFINE ().

*---------------------------------------------------------------------------------------------------------------------
*Fine Class 1 : Current Legal or Enforcement
*---------------------------------------------------------------------------------------------------------------------
*-----------  Note this status is updated by other fine class (i.e. Legal / Bad )

DO IF ( Number_of_Months_Arrears < 3) .
	COMPUTE Fine = 1.
END IF.
EXECUTE.

*---------------------------------------------------------------------------------------------------------------------
*Fine Class 0 : Current Good
*---------------------------------------------------------------------------------------------------------------------
*-----------  Note this status is updated by other fine class (i.e. Legal / Bad )

DO IF ( Number_of_Months_Arrears =0 ). 
	COMPUTE Fine = 0.
END IF.
EXECUTE.

*---------------------------------------------------------------------------------------------------------------------
*Fine Class 2 : Current Legal or Enforcement
*---------------------------------------------------------------------------------------------------------------------

DO IF ( ANY(Enforcement_Category,"J","P","R") OR Bad_Debt_Write_Off_Tag = 1) .
	COMPUTE Fine = 2.
END IF.
EXECUTE.

*---------------------------------------------------------------------------------------------------------------------
*Fine Class 3 : Current Number Months Arrears 3 +
*---------------------------------------------------------------------------------------------------------------------

DO IF ( Number_of_Months_Arrears >2) .
	COMPUTE Fine = 3.
END IF.
EXECUTE.

!ENDDEFINE.



DEFINE !GBRes ().

FREQUENCIES
  VARIABLES=Fine
  /ORDER=  ANALYSIS .

!ENDDEFINE.


!GETIT.


