select getdate()
go

use BASEL
go

INSERT 	B230_Segment_Default

SELECT	b410.Segment_Id,
	b410.Accounting_Period,
	COUNT(*),
	SUM(b400.Outstanding_Balance),
	0,
	0,
	0,
	0,
	0

FROM	B410_Account_Segments b410,
	B400_Basel_AccountsX b400

WHERE	b410.Accounting_Period = 200209
AND	b410.Account_Number = b400.Account_Number
AND	b410.Accounting_Period = b400.Accounting_Period

GROUP BY b410.Segment_Id, b410.Accounting_Period
go

select getdate()
go
