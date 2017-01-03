
* Create Date Indicatros for Pay Ou Date .

COMPUTE pYear = XDATE.YEAR(Pay_Out_Date).
COMPUTE pMonth = XDATE.MONTH.(Pay_Out_Date).
EXECUTE.

* Recode Status of Application .

STRING Proposal_Status (A12) .
RECODE
  Status_of_Loan
  ('A'='Active')  ('D'='Decline/NTU')  ('E'='Enquiry')  ('P'='TRF')  ('S'='Section58')  (MISSING='Missing')  (ELSE='Other')
  INTO  Proposal_Status .
EXECUTE .


FREQUENCIES
  VARIABLES=Proposal_Status
  /ORDER=  ANALYSIS .

SAVE OUTFILE 'D:\My Documents\Risk\Projects\TPD\Bmouth\Bmouth_Base.sav'
 /COMPRESSED.

* Determine if TRF cases have duplicates

GET FILE 'D:\My Documents\Risk\Projects\TPD\Bmouth\Bmouth_Base.sav'.

SELECT IF Proposal_Status = 'TRF'.
EXECUTE.

SORT CASES BY
  Accounts_Master_Number (A) .

* Ensure no duplicates

MATCH FILES /FILE = *
 /LAST = temp /BY Accounts_Master_Number.
EXECUTE.

FREQUENCIES
  VARIABLES=temp
  /ORDER=  ANALYSIS .

SELECT IF temp.
EXECUTE.

DELETE VARIABLES temp.

SAVE OUTFILE 'D:\My Documents\Risk\Projects\TPD\Bmouth\Bmouth_TRF.sav'
 /COMPRESSED.


* Create File for Addreser

GET FILE 'D:\My Documents\Risk\Projects\TPD\Bmouth\Bmouth_Base.sav'.

SORT CASES BY
  Application_Number (A) .

* Ensure no duplicates

MATCH FILES /FILE = *
 /LAST = temp /BY Application_Number.
EXECUTE.

FREQUENCIES
  VARIABLES=temp
  /ORDER=  ANALYSIS .

SELECT IF temp.
EXECUTE.

DELETE VARIABLES temp.

* Assumption is that Address Line One Holds all House Numbers / Names

STRING AddressLine (A48).

COMPUTE AddressLine = RTRIM(Address_Line_01).
EXECUTE.

* Trims file 
	
SAVE OUTFILE='D:\My Documents\Risk\Projects\TPD\Bmouth\tpd_ht_b Ap Client and Address Only File.sav'
 /DROP=Owner Address_Line_01 Address_Line_02 Address_Line_03 Address_Line_04 Address_Line_05 Phone_Day Phone_Eve
 Scottish_Ind Amount_Exc_Ins Term Purpose_Loan Insurance_Ind Broker_Reference Newspaper_Code Advertisment_Code Mailshot_Code
 Telesale Freehold_Ind Years_Lease Owner_Occ Purchase_Date Area_Code Purchase_Price Customer_Valuation Roll_Up_Valuation
 Survey_Valuation Council_Purchase Council_Discount Council_Valulation Mort_Name_01 Mort_Name_02 Mort_Name_03 Mort_Date_01
 Mort_Date_02 Mort_Date_03 Mort_Original_Amount_01 Mort_Original_Amount_02 Mort_Original_Amount_03 Mort_FA_01 Mort_FA_02
 Mort_FA_03 Mort_Total_01 Mort_Total_02 Mort_Total_03 Mort_Amount_Outs_01 Mort_Amount_Outs_02 Mort_Amount_Outs_03
 Mort_Mnth_Repay_01 Mort_Mnth_Repay_02 Mort_Mnth_Repay_03 Mort_Arrears_01 Mort_Arrears_02 Mort_Arrears_03 Mort_Consol_01
 Mort_Consol_02 Mort_Consol_03 Annual_Income_01 Annual_Income_02 Occupation_01 Occupation_02 Time_in_Job_01 Time_in_Job_02
 Self_Emp_01 Self_Emp_02 Status_of_Loan Reason_Code APR Application_Date Pay_Out_Date Property_Type Mortgage_Type
 No_Dependents Other_Income Marital_Status_01 Marital_Status_02 Exact_Name_CCJ_Date Wescore Voters_Roll_Years Worst_Insight
 No_CCJs Final_Score Final_Grade Repayment_BH_Loan Initial_Application_Score Voters_Roll_Ind Accounts_Master_Number
 Further_Advance_Amount Other_Mnth_Repayment xYEAR xMONTH pYear pMonth Proposal_Status /COMPRESSED.

GET FILE 'D:\My Documents\Risk\Projects\TPD\Bmouth\tpd_ht_b Ap Client and Address Only File.sav'.

COMPUTE pos1 = 0.
EXECUTE.

LOOP # = 1 to Len(AddressLine).
DO IF SUBST(AddressLine,#,1) = ' '.
COMPUTE pos1 = pos1 + 1.
END IF.
END LOOP.
EXECUTE.

* Remove blank cases

SELECT IF pos1 < Len(AddressLine).
EXECUTE.


* Identify First Space

COMPUTE pos1 =INDEX(AddressLine,' ').
EXECUTE.

STRING Alpha (A26) NUM (A10) ADDR (A48).
COMPUTE ALPHA = " -/ABCDEFGHIJKLMNOPQRSTUVWXYZ".
COMPUTE NUM = "0123456789".
COMPUTE ADDR =  UPCASE(AddressLine).
EXECUTE.


COMPUTE BAD = 0.

LOOP # = 1 to Len(AddressLine).
IF (IND(SUB(ADDR,#,1),ALPHA,1) > 0 & BAD = 0 ) BAD = #.
END LOOP.
EXE.

* As I'm lasy I'll take all house numbers

SELECT IF BAD > 1.
EXE.

* Substring Lose 1 char to trim alpha or char suffex .

String House_Number (A5).
COMPUTE House_Number = RTRIM(SUB(ADDR,1,BAD-1)).
EXE.

