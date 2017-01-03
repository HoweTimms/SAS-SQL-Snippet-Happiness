DEFINE !TableNames ().

!DO !var=200208 !TO 200212.
EXECUTE.
!DOEND.

!ENDDEFINE.

* Call Macro
!TableNames.




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
