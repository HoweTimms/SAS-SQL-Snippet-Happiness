use BASEL
go

select getdate()
go
/***************************************************************/
/* Script       - BIP98700.sql                                 */
/*                                                             */
/* Description  - B400_Basel_Accounts                          */
/*                                                             */
/* Author       - Cath Foster                                  */
/*                                                             */
/* Date Written - 16/07/2003                                   */
/*                                                             */
/* Vsn  Code   Comments                     Inits  Date        */
/* ---  -----  ---------------------------  -----  ----------  */
/* 001  BASEL  Initial script               CMF    16/07/2003  */
/***************************************************************/
EXEC Write_Log 'BIP98700','Vsn:001 (CMF)','Starting...',0
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
	@EndDate smalldatetime
SELECT  @CurrAccPer = Accounting_Period,
	@EndDate = End_Date
FROM    MIP..E440_Processing_Dates
WHERE   Processing_Date_Code = 'CAP'

INSERT  B400_Basel_Accounts
SELECT	e510.Account_Number,
	e510.Accounting_Period,
	e510.Profit_BU_Reference,
	t110.Division_Reference,
	e411.Final_Grade,
	DATEDIFF(mm,e510.New_Business_Date,@EndDate) Vintage,
	CASE WHEN e510.Scheme_Number IN (44,58)
	AND  t110.Division_Reference IN	('001','006','009','013','017','025')
	THEN e510.Scheme_Number ELSE NULL END as Scheme_Number,
	NULL Client_Type_Code,
	e412.Number_of_Months_Arrears,
	e412.Worst_Months_Arrears,
	e550.Delinquency_Category,
	CASE WHEN e510.Scheme_Number = 41 THEN e410.Credit_Limit
	ELSE e412.Capital_Balance END as Capital_Balance,
	CASE WHEN e510.Scheme_Number = 41 THEN e410.Credit_Limit
	ELSE e412.Outstanding_Balance END as Outstanding_Balance,
	CASE WHEN e510.Scheme_Number = 41 THEN e410.Credit_Limit
	ELSE e412.Nett_Outstanding_Balance END as Nett_Outstanding_Balance,
	e412.Bad_Debt_Provision,
	e412.Outstanding_Arrears,
	e510.Bad_Debt_Write_Off,
	e410.Credit_Limit,
	e410.Advance

FROM	MIP..E510_Account_Summary e510,
	MIP..T110_Business_Structure t110,
	MIP..E411_Proposal_Scoring_Data e411,
	Customer_Tracking..E550_Delinquent_Accounts e550,
	MIP..E412_Account_Monthly_History e412,
	MIP..E410_Financial_Agreement e410

WHERE	e510.Accounting_Period = @CurrAccPer
AND	e510.Profit_BU_Reference = t110.Profit_Centre_Reference
AND	t110.Division_Reference <> '029'
AND	e510.Account_Number *= e411.Account_Number
AND	e510.Account_Product_Code *= e411.Account_Product_Code
AND	e510.Account_Number *= e550.Account_Number
AND	e510.Account_Product_Code *= e550.Account_Product_Code
AND	e510.Accounting_Period *= e550.Accounting_Period
AND	e550.Number_of_Months_Arrears <> 0
AND	e510.Account_Number = e412.Account_Number
AND	e510.Account_Product_Code = e412.Account_Product_Code
AND	e510.Accounting_Period = e412.Accounting_Period
AND	e510.Account_Number = e410.Account_Number
AND	e510.Account_Product_Code = e410.Account_Product_Code
go

/***************************************************************/
/* Update Client_Type_Code                                     */
/***************************************************************/
DECLARE @CurrAccPer int
SELECT  @CurrAccPer = Accounting_Period
FROM    MIP..E440_Processing_Dates
WHERE   Processing_Date_Code = 'CAP'

UPDATE 	B400_Basel_Accounts
SET	Client_Type_Code = e210.Client_Type_Code
FROM	B400_Basel_Accounts b400,
	MIP..E217_Client_Fincl_Agreemnt e217,
	MIP..E210_Client e210
WHERE	b400.Accounting_Period = @CurrAccPer
AND	b400.Division_Reference IN ('002','003','011','024','026','027')
AND	b400.Account_Number = e217.Account_Number
AND	e217.CA_Relationship IN ('JBF','DTR')
AND	e217.Client_Key = e210.Client_Key
AND	e210.Client_Type_Code IN ('I','L','P','S')
go

EXEC Write_Log 'BIP98700','Vsn:001 (CMF)','Completed.',0
go

select getdate()
go
