use BASEL
go

/***************************************************************/
/* Script       - BIP98710.sql                                 */
/*                                                             */
/* Description  - B230_Segment_Default                         */
/*                                                             */
/* Author       - Cath Foster                                  */
/*                                                             */
/* Date Written - 23/07/2003                                   */
/*                                                             */
/* Vsn  Code   Comments                     Inits  Date        */
/* ---  -----  ---------------------------  -----  ----------  */
/* 001  BASEL  Initial script               CMF    23/07/2003  */
/***************************************************************/
EXEC Write_Log 'BIP98710','Vsn:001 (CMF)','Starting...',0
go

/***************************************************************/
/* Delete records for current period                           */
/***************************************************************/
DECLARE @CurrAccPer int
SELECT  @CurrAccPer = Accounting_Period
FROM    E440_Processing_Dates
WHERE   Processing_Date_Code = 'CAP'

DELETE  FROM B230_Segment_Default
WHERE   Accounting_Period = @CurrAccPer
go

/***************************************************************/
/* Total Accounts and Total Exposure for this period last year */
/***************************************************************/
DECLARE @AccPer int
SELECT  @AccPer = Accounting_Period-100
FROM    E440_Processing_Dates
WHERE   Processing_Date_Code = 'CAP'

SELECT	Segment_Id,
	Total_Accounts,
	Total_Exposure

INTO	xPrev_ALL

FROM	B220_Segment_Results

WHERE	Accounting_Period = @AccPer 
go

/***************************************************************/
/* Total_Default_Accounts for this period last year            */
/***************************************************************/
DECLARE @AccPer int
SELECT  @AccPer = Accounting_Period-100
FROM    E440_Processing_Dates
WHERE   Processing_Date_Code = 'CAP'

SELECT	b410a.Segment_Id,
	b410a.Account_Number,
	SUM(convert(smallint,
	CASE WHEN substring(b410b.Segment_Id,7,2) = '04'
	THEN 1 ELSE 0 END)) In_Default

INTO	xDefault_Accounts

FROM	B410_Account_Segments b410a (Index I410_NC_Accounting_Period),
	B410_Account_Segments b410b (Index I410_NC_Primary)

WHERE	b410a.Accounting_Period = @AccPer 
AND 	b410a.Account_Number = b410b.Account_Number
AND   	b410b.Accounting_Period > @AccPer 

GROUP BY b410a.Segment_Id,
	b410a.Account_Number
go

/***************************************************************/
SELECT	Segment_Id,
	COUNT(*) Total_Default_Accounts

INTO	xPrev_Default

FROM	xDefault_Accounts

WHERE	In_Default >= 1

GROUP BY Segment_Id 
go

/***************************************************************/
/* Total_Accounts and Total_Exposure for current period        */
/***************************************************************/
DECLARE @CurrAccPer int
SELECT  @CurrAccPer = Accounting_Period
FROM    E440_Processing_Dates
WHERE   Processing_Date_Code = 'CAP'

SELECT	b410.Segment_Id,
	b410.Accounting_Period,
	COUNT(*) Total_Accounts,
	SUM(b400.Outstanding_Balance) Total_Exposure

INTO	xCurr_ALL

FROM	B410_Account_Segments b410 (Index I410_NC_Accounting_Period),
	B400_Basel_Accounts b400 (Index I400_NC_Primary)

WHERE	b410.Accounting_Period = @CurrAccPer 
AND	b410.Account_Number = b400.Account_Number
AND	b400.Accounting_Period = b410.Accounting_Period

GROUP BY b410.Segment_Id,
	b410.Accounting_Period
go
	
/***************************************************************/
/* Insert into B230_Segment_Default                            */
/***************************************************************/
INSERT 	B230_Segment_Default
SELECT	t1.Segment_Id,
	t1.Accounting_Period,
	t1.Total_Accounts,
	t1.Total_Exposure,
	isnull(b200.PD,0),
	t1.Total_Exposure * isnull(b200.PD,0),
	isnull(t3.Total_Default_Accounts,0),
	CASE
	WHEN t2.Total_Accounts > 0
	THEN (convert(real,(isnull(t3.Total_Default_Accounts,0)) /
	      convert(real,t2.Total_Accounts)) *100)
	ELSE 0 END,
	CASE
	WHEN t2.Total_Accounts > 0
	THEN (convert(real,(isnull(t3.Total_Default_Accounts,0)) /
	      convert(real,t2.Total_Accounts)) ) *
	      isnull(t1.Total_Exposure,0)
	ELSE 0 END

FROM	xCurr_ALL t1,
	xPrev_ALL t2,
	xPrev_Default t3,
	B200_PD b200

WHERE   t1.Segment_Id *= t2.Segment_Id
AND	t1.Segment_Id *= t3.Segment_Id
AND  	t1.Segment_Id *= b200.Segment_Id
AND	b200.End_Accounting_Period IS NULL
go

EXEC Write_Log 'BIP98710','Vsn:001 (CMF)','Completed.',0
go
