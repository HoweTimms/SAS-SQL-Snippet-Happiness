/***************************************************************/
/* Script       - BIP98720.sql                                 */
/*                                                             */
/* Description  - B220_Segment_Results                         */
/*                                                             */
/* Author       - Cath Foster                                  */
/*                                                             */
/* Date Written - 24/07/2003                                   */
/*                                                             */
/* Vsn  Code   Comments                     Inits  Date        */
/* ---  -----  ---------------------------  -----  ----------  */
/* 001  BASEL  Initial script               CMF    24/07/2003  */
/***************************************************************/
EXEC Write_Log 'BIP98720','Vsn:001 (CMF)','Starting...',0
go

/***************************************************************/
/* Delete records for current period                           */
/***************************************************************/
DECLARE @CurrAccPer int
SELECT  @CurrAccPer = Accounting_Period
FROM    MIP..E440_Processing_Dates
WHERE   Processing_Date_Code = 'CAP'

DELETE  FROM B220_Segment_Results
WHERE   Accounting_Period = @CurrAccPer
go

/***************************************************************/
/* Total Accounts, Total Exposure and LDG Value for period     */
/***************************************************************/
DECLARE @CurrAccPer int
SELECT  @CurrAccPer = Accounting_Period
FROM    MIP..E440_Processing_Dates
WHERE   Processing_Date_Code = 'CAP'

SELECT	b410.Segment_Id,
	b410.Accounting_Period,
	COUNT(*) Total_Accounts,
	SUM(b400.Outstanding_Balance) Total_Exposure,
	SUM(b400.Outstanding_Balance * b210.LDG) LDG_Value
INTO	#Curr_LDG
FROM	B410_Account_Segments b410,
	B400_Basel_Accounts b400,
	B210_LDG b210	
WHERE	b410.Accounting_Period = @CurrAccPer 
AND	b410.Account_Number = b400.Account_Number
AND	b400.Accounting_Period = @CurrAccPer
AND  	b410.Delinquency_Category = b210.Delinquency_Category
AND	b210.End_Accounting_period IS NULL
GROUP BY b410.Segment_Id,
	b410.Accounting_Period
go
	
/***************************************************************/
/* Insert into B220_Segment_Results                            */
/***************************************************************/
INSERT	B220_Segment_Results
SELECT	t1.Segment_Id,
	t1.Accounting_Period,
	t1.Total_Accounts,
	t1.Total_Exposure,
	b230.PD_Percentage,
	b230.PD_Value,
	b230.AD_Count,
	b230.AD_Percentage,
	b230.AD_Value,
	t1.LDG_Value
FROM	#Curr_ALL t1,
	B230_Segment_Default b230
WHERE	t1.Segment_Id = b230.Segment_Id
AND	t1.Accounting_Period = b230.Accounting_Period
go

EXEC Write_Log 'BIP98720','Vsn:001 (CMF)','Completed.',0
go
