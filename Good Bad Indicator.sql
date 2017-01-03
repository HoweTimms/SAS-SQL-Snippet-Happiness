

--This defines "good":

--SELECT Sum(dbo_RV_debttrans.[tx-amount]) AS [SumOftx-amount] FROM dbo_tblbigtable INNER JOIN dbo_RV_debttrans ON dbo_tblbigtable.wk_ref = dbo_RV_debttrans.[debt-code] WHERE (((dbo_RV_debttrans.[tx-date]) Between [dbo_tblbigtable]![bookon_date] And [dbo_tblbigtable]![bookon_date]+375))
--HAVING (((Sum(dbo_RV_debttrans.[tx-amount]))>=0.05*[dbo_tblbigtable]![original_debt_value]));

--This is "indeterminate" where not included in "good":

--SELECT Sum(dbo_RV_debttrans.[tx-amount]) AS [SumOftx-amount] FROM dbo_tblbigtable INNER JOIN dbo_RV_debttrans ON dbo_tblbigtable.wk_ref = dbo_RV_debttrans.[debt-code] WHERE (((dbo_RV_debttrans.[tx-date]) Between [dbo_tblbigtable]![bookon_date] And [dbo_tblbigtable]![bookon_date]+740))
--HAVING (((Sum(dbo_RV_debttrans.[tx-amount]))>0));

--The rest are "bad"
--Hope this is alright


IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'tmp_CashCollect_YearOne')
BEGIN
	PRINT 'DROPING TABLE tmp_CashCollect_YearOne' 
	DROP TABLE tmp_CashCollect_YearOne
END
go

declare @Start smalldatetime

SET @Start = DATEADD(mm,-1,CAST(FLOOR( CAST( GETDATE() AS FLOAT ) )AS DATETIME))

PRINT 'Build tmp_CashCollect_Year'
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT bigtable.wk_ref
	,  SUM(debtrans.[tx-amount]) as CashCollected
INTO	risk..tmp_CashCollect_YearOne
FROM	data_warehouse.dbo.tblbigtable bigtable
	,  data_warehouse.dbo.RV_debttrans debtrans

WHERE	bigtable.wk_ref = debtrans.[debt-code]
AND	debtrans.[tx-date] >= bigtable.[bookon_date]
AND 	debtrans.[tx-date] <= DATEADD(YEAR,1,bigtable.[bookon_date])
AND	DATEDIFF(MONTH,bigtable.[bookon_date], @Start) >= 12

GROUP BY bigtable.wk_ref
ORDER BY bigtable.wk_ref
	
go

CREATE INDEX iwk_ref ON risk..tmp_CashCollect_YearOne(wk_ref)
go


IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'tmp_CashCollect_YearTwo')
BEGIN
	PRINT 'DROPING TABLE tmp_CashCollect_YearTwo' 
	DROP TABLE tmp_CashCollect_YearTwo
END
go

declare @Start smalldatetime

SET @Start = DATEADD(mm,-1,CAST(FLOOR( CAST( GETDATE() AS FLOAT ) )AS DATETIME))

PRINT 'Build tmp_CashCollect_Year'
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT bigtable.wk_ref
	,  SUM(debtrans.[tx-amount]) as CashCollected
INTO	risk..tmp_CashCollect_YearTwo
FROM	data_warehouse.dbo.tblbigtable bigtable
	,  data_warehouse.dbo.RV_debttrans debtrans

WHERE	bigtable.wk_ref = debtrans.[debt-code]
AND	debtrans.[tx-date] >= bigtable.[bookon_date]
AND 	debtrans.[tx-date] <= DATEADD(YEAR,2,bigtable.[bookon_date])
AND	DATEDIFF(MONTH,bigtable.[bookon_date], @Start) >= 24

GROUP BY bigtable.wk_ref
ORDER BY bigtable.wk_ref
	
go

CREATE INDEX iwk_ref ON risk..tmp_CashCollect_YearTwo(wk_ref)
go

IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'tmp_Cash')
BEGIN
	PRINT 'DROPING TABLE tmp_Cash' 
	DROP TABLE tmp_Cash
END
go

declare @Start smalldatetime

SET @Start = DATEADD(mm,-1,CAST(FLOOR( CAST( GETDATE() AS FLOAT ) )AS DATETIME))

PRINT ' Make Table risk..tmp_Cash'
SELECT  bigtable.wk_ref
	,  bigtable.original_debt_value
	,  atOne.CashCollected as CashAtOne
	,  atTwo.CashCollected as CashAtTwo
	,  DATEDIFF(MONTH,bigtable.[bookon_date], @Start) as Age
	,  'X' as Outcome
INTO	risk..tmp_Cash
FROM	data_warehouse.dbo.tblbigtable		bigtable
	,  risk..tmp_CashCollect_YearOne	atOne
	,  risk..tmp_CashCollect_YearTwo	atTwo
WHERE	bigtable.wk_ref *= atTwo.wk_ref
AND	bigtable.wk_ref *= atOne.wk_ref
go

PRINT 'DROP Staging Tables'
DROP TABLE risk..tmp_CashCollect_YearOne	
DROP TABLE risk..tmp_CashCollect_YearTwo	
go
PRINT 'Index tmp_cask'
CREATE INDEX iwk_ref on risk..tmp_Cash(wk_ref)

UPDATE risk..tmp_Cash
SET	Outcome = CASE
		WHEN ( Age >= 12 AND CashAtOne >= (original_debt_value * 0.05)) THEN 'G'
		WHEN ( (Age >= 12 AND CashAtOne > 0) OR (Age >= 12 AND CashAtTwo > 0)) THEN 'I'
		WHEN ( Age > = 12 ) THEN 'B'
		ELSE 'X'
	END 
FROM	risk..tmp_Cash


SELECT Outcome
	,  COUNT(*)
FROM	risk..tmp_Cash
GROUP By
	Outcome
go



SELECT	Score
	,  SUM(CASE WHEN Outcome = 'G' THEN 1 ELSE 0 END) AS Good
	,  SUM(CASE WHEN Outcome <> 'G' THEN 1 ELSE 0 END) AS Bad
	,  COUNT(*) AS Obs

FROM	risk..BERT_FinalScore as Score
	,  risk..tmp_Cash as outcome
WHERE	Score.wk_ref = outcome.wk_ref
AND	Age = 13
GROUP BY
	Score
ORDER BY
	Score

