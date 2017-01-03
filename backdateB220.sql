select getdate()
go

use BASEL
go

INSERT	B220_Segment_Results
SELECT	b410.Segment_Id,
	b410.Accounting_Period,
	COUNT(*) Total_Accounts,
	SUM(b400.Outstanding_Balance) Total_Exposure,
	0,
	0,
	0,
	0,
	0,
	0

FROM	B410_Account_Segments b410 (Index I410_NC_Accounting_Period),
	B400_Basel_AccountsX b400 (Index I400_NC_Primary)

WHERE	b410.Accounting_Period = 200208
AND	b410.Account_Number = b400.Account_Number
AND	b410.Accounting_Period = b400.Accounting_Period

GROUP BY b410.Segment_Id,
	b410.Accounting_Period
go

select getdate()
go
