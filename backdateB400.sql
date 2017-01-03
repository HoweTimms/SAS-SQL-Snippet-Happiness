use BASEL
go

select getdate()
go

/***************************************************************/
/* Delete records for current period                           */
/***************************************************************/
DECLARE @CurrAccPer int
SELECT  @CurrAccPer = Accounting_Period
FROM    MIP..E440_Processing_Dates
WHERE   Processing_Date_Code = 'CAP'

DELETE  FROM B400_Basel_Accounts
WHERE   Accounting_Period = @CurrAccPer
go

/***************************************************************/
/* Retrieve all live accounts                                  */
/***************************************************************/
DECLARE @CurrAccPer int,
        @CurrEndDate smalldatetime
SELECT  @CurrAccPer = Accounting_Period,
        @CurrEndDate = End_Date
FROM	E440_Processing_Dates
WHERE	Processing_Date_Code = 'CAP'

SELECT	e410.Account_Number,
	e410.Account_Product_Code,
	e410.New_Business_Date,
	DATEDIFF(mm,e410.New_Business_Date,@CurrEndDate) Vintage,
	e410.Scheme_Number,
	e412.Number_of_Months_Arrears,
	e412.Worst_Months_Arrears,
	CASE WHEN e410.Scheme_Number = 41 THEN e410.Credit_Limit
	ELSE e412.Capital_Balance END as Capital_Balance,
	CASE WHEN e410.Scheme_Number = 41 THEN e410.Credit_Limit
	ELSE e412.Outstanding_Balance END as Outstanding_Balance,
	CASE WHEN e410.Scheme_Number = 41 THEN e410.Credit_Limit
	ELSE e412.Nett_Outstanding_Balance END as Nett_Outstanding_Balance,
	e412.Bad_Debt_Provision,
	e412.Outstanding_Arrears,
	e410.Credit_Limit,
	e410.Advance

INTO	#Accounts1

FROM	MIP..E410_Financial_Agreement e410,
	MIP..E412_Account_Monthly_History e412 (index I412_NC_Primary)

WHERE	e410.New_Business_Date <= @CurrEndDate
AND	(e410.Completion_Date >= @CurrEndDate 
OR	 e410.Completion_Date IS NULL)
AND	e410.Account_Number = e412.Account_Number
AND	e410.Account_Product_Code = e412.Account_Product_Code
AND	e412.Accounting_Period = @CurrAccPer
go

select getdate()
go

/***************************************************************/
/* Retrieve Business_Unit_Reference and Division_Reference     */
/***************************************************************/
DECLARE @CurrEndDate smalldatetime
SELECT  @CurrEndDate = End_Date
FROM	E440_Processing_Dates
WHERE	Processing_Date_Code = 'CAP'

SELECT	t1.Account_Number,
	t1.Account_Product_Code,
	t1.New_Business_Date,
	t1.Vintage,
	CASE WHEN t1.Scheme_Number IN (44,58)
	AND  t110.Division_Reference IN	('001','006,','009','013','017','025')
	THEN t1.Scheme_Number ELSE NULL END as Scheme_Number,
	t1.Number_of_Months_Arrears,
	t1.Worst_Months_Arrears,
	t1.Capital_Balance,
	t1.Outstanding_Balance,
	t1.Nett_Outstanding_Balance,
	t1.Bad_Debt_Provision,
	t1.Outstanding_Arrears,
	t1.Credit_Limit,
	t1.Advance,
	e115.Business_Unit_Reference,
	t110.Division_Reference

INTO	#Accounts2

FROM	#Accounts1 t1,
	MIP..E115_Account_Management e115 (index I115_CU_Account),
	MIP..T110_Business_Structure t110

WHERE	t1.Account_Number = e115.Account_Number
AND	@CurrEndDate BETWEEN isnull(e115.Start_Date,'01/01/1900')
		         AND isnull(e115.End_Date,'31/12/2050')
AND	e115.Management_Link_Type = 'P'
AND	e115.Business_Unit_Reference = t110.Profit_Centre_Reference
AND	e115.Business_Unit_Reference = t110.Profit_Centre_Reference
AND	t110.Division_Reference <> '029'
go

select getdate()
go

/***************************************************************/
/* Proposals                                                   */
/***************************************************************/
SELECT	t1.Account_Number,
	t1.Account_Product_Code,
	e411.Proposal_Date,
	e411.Final_Grade

INTO	#Props

FROM	#Accounts2 t1,
	MIP..E411_Proposal_Scoring_Data e411 (index I411_NC_Primary)

WHERE	t1.Account_Number = e411.Account_Number
AND	e411.Proposal_Date <= t1.New_Business_Date
go

/***************************************************************/
DELETE	#Props
FROM	#Props t1,
	#Accounts2 t2
WHERE	t1.Account_Number = t2.Account_Number
AND     t1.Proposal_Date > t2.New_Business_Date
go

/***************************************************************/
SELECT	Account_Number,
	Account_Product_Code,
	MAX(Proposal_Date) MAX_Proposal_Date

INTO	#MAX_Props

FROM	#Props

GROUP BY Account_Number,
	Account_Product_Code
go

/***************************************************************/
/* Retrieve Final_Grade                                        */
/***************************************************************/
SELECT	t1.Account_Number,
	t1.Account_Product_Code,
	t1.Business_Unit_Reference,
	t1.Division_Reference,
	t1.Vintage,
	t1.Scheme_Number,
	t1.Number_of_Months_Arrears,
	t1.Worst_Months_Arrears,
	t1.Capital_Balance,
	t1.Outstanding_Balance,
	t1.Nett_Outstanding_Balance,
	t1.Bad_Debt_Provision,
	t1.Outstanding_Arrears,
	t1.Credit_Limit,
	t1.Advance,
	t3.Final_Grade

INTO	#Accounts3

FROM	#Accounts2 t1,
	#MAX_Props t2,
	#Props t3

WHERE	t1.Account_Number = t2.Account_Number
AND	t2.Account_Number = t3.Account_Number
AND	t2.MAX_Proposal_Date = t3.Proposal_Date
go

select getdate()
go

/***************************************************************/
/* Retrieve Delinquency_Category                               */
/***************************************************************/
DECLARE @CurrAccPer int
SELECT  @CurrAccPer = Accounting_Period
FROM	E440_Processing_Dates
WHERE	Processing_Date_Code = 'CAP'

SELECT	t1.Account_Number,
	t1.Account_Product_Code,
	t1.Business_Unit_Reference,
	t1.Division_Reference,
	t1.Vintage,
	t1.Scheme_Number,
	t1.Number_of_Months_Arrears,
	t1.Worst_Months_Arrears,
	t1.Capital_Balance,
	t1.Outstanding_Balance,
	t1.Nett_Outstanding_Balance,
	t1.Bad_Debt_Provision,
	t1.Outstanding_Arrears,
	t1.Credit_Limit,
	t1.Advance,
	t1.Final_Grade,
	e550.Delinquency_Category

INTO	#Accounts4

FROM	#Accounts3 t1,
	Customer_Tracking..E550_Delinquent_Accounts e550 (index I550_NC_Account_Key)

WHERE   t1.Account_Number *= e550.Account_Number
AND     t1.Account_Product_Code *= e550.Account_Product_Code
AND     e550.Accounting_Period = @CurrAccPer
AND     e550.Number_of_Months_Arrears <> 0
go

select getdate()
go

/***************************************************************/
/* Insert into B400_Basel_Accounts                             */
/***************************************************************/
SET FORCEPLAN ON
go

DECLARE @CurrAccPer int
SELECT  @CurrAccPer = Accounting_Period
FROM	E440_Processing_Dates
WHERE	Processing_Date_Code = 'CAP'

INSERT  B400_Basel_Accounts
SELECT	t1.Account_Number,
	@CurrAccPer,
	t1.Business_Unit_Reference,
	t1.Division_Reference,
	t1.Final_Grade,
	t1.Vintage,
	t1.Scheme_Number,
	NULL Client_Type_Code,
	t1.Number_of_Months_Arrears,
	t1.Worst_Months_Arrears,
	t1.Delinquency_Category,
	t1.Capital_Balance,
	t1.Outstanding_Balance,
	t1.Nett_Outstanding_Balance,
	t1.Bad_Debt_Provision,
	t1.Outstanding_Arrears,
	t2.Bad_Debt_Write_Off,
	t1.Credit_Limit,
	t1.Advance

FROM	#Accounts4 t1,
	xBadDebt t2

WHERE   t1.Account_Number *= t2.Account_Number
AND     t2.Accounting_Period = @CurrAccPer
go

SET FORCEPLAN OFF
go
/***************************************************************/
/* Update Client_Type_Code                                     */
/***************************************************************/
DECLARE @CurrAccPer int
SELECT  @CurrAccPer = Accounting_Period
FROM	E440_Processing_Dates
WHERE	Processing_Date_Code = 'CAP'

UPDATE  B400_Basel_Accounts

SET     Client_Type_Code = e210.Client_Type_Code

FROM    B400_Basel_Accounts b400,
        MIP..E217_Client_Fincl_Agreemnt e217,
        MIP..E210_Client e210

WHERE   b400.Accounting_Period = @CurrAccPer
AND     b400.Division_Reference IN ('002','003','011','024','026','027')
AND     b400.Account_Number = e217.Account_Number
AND     e217.CA_Relationship IN ('JBF','DTR')
AND     e217.Client_Key = e210.Client_Key
AND     e210.Client_Type_Code IN ('I','L','P','S')
go

select getdate()
go
