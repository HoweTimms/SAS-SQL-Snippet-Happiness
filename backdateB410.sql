use BASEL
go

select getdate()
go

/***************************************************************/
/* Set Segment_Id and insert into B410_Account_Segments        */
/***************************************************************/
INSERT  B410_Account_Segments
SELECT	b400.Account_Number,
	b400.Accounting_Period,
	CASE WHEN b130a.Segment_Id IS NULL
	THEN
	isnull(b100.Segment_Id,' ') +
	isnull(b110.Segment_Id,' ') +
	isnull(b120.Segment_Id,' ') +
	isnull(b130b.Segment_Id,' ')
	ELSE
	isnull(b100.Segment_Id,' ') +
	isnull(b110.Segment_Id,' ') +
	isnull(b120.Segment_Id,' ') +
	isnull(b130a.Segment_Id,' ')
	END as Segment_Id

FROM	B400_Basel_Accounts b400,
	B100_Business_Stream_Segments b100,
	B110_Grade_Segments b110,
	B120_Vintage_Segments b120,
	B130_Delinquency_Segments b130a,
	B130_Delinquency_Segments b130b

WHERE	b400.Accounting_Period = 200208
AND	b400.Division_Reference *= b100.Division_Reference
AND	isnull(b400.Client_Type_Code,' ') *= isnull(b100.Client_Type_Code,' ')
AND	isnull(b400.Scheme_Number,0) *= isnull(b100.Scheme_Number,0)
AND  	isnull(b400.Final_Grade,' ') = b110.Final_Grade
AND	b400.Vintage BETWEEN b120.Start_Age AND b120.End_Age
AND	b400.Delinquency_Category *= b130a.Delinquency_Category
AND	b400.No_of_Months_Arrears *= b130b.No_of_Months_Arrears
go

select getdate()
go
