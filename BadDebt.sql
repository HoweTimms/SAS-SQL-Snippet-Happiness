use BASEL
go

select getdate()
go

/***************************************************************/
/* Retrieve Bad Debt Write-off                                 */
/***************************************************************/
SELECT	Accounting_Period,
	Account_Number,
	Account_Product_Code,
	SUM(e416.Transaction_Value)
	 Bad_Debt_Write_Off

INTO	xBadDebt

FROM	MIP..E416_Account_Transact_Hist e416,
	MIP..E420_Transaction_Data_Types e420

WHERE   e416.Accounting_Period BETWEEN 200208 AND 200307
  AND   e416.Transaction_Code = e420.Transaction_Code
  AND	substring(e420.Group_Transaction_Code,1,3) = '913'

GROUP BY Accounting_Period, 
	Account_Number,
	 Account_Product_Code
go

select getdate()
go
