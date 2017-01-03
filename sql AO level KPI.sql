
/* Team */
/* DAILY */

/*Prepare TABLE variable to take resultset*/
DECLARE @tbl TABLE(	
        RowID INT IDENTITY(1, 1)
        ,  department VARCHAR(30)
        ,  team VARCHAR(30)
	,  AO VARCHAR(30)
	 )
/*Local variables */
DECLARE @department VARCHAR(30)
	,  @team VARCHAR(30)
	,  @AO VARCHAR(30)
	,  @count int /*create local @@fetch_status*/
	,  @iRow int  /*row pointer (index)*/
/* create array simulator */
INSERT @tbl 
SELECT Distinct
	department		as department
	,  team			as team
	,  [user]		as AO 
FROM	RISK..temp_KPI_Raw_Plan
ORDER BY
	department
	,  team
	,  [user]

/*get array Upper Bound (highest ID number)*/
SET @count = @@ROWCOUNT
/*initialize index counter*/
SET @iRow = 1
/*establish loop structure*/

WHILE @iRow <= @count
BEGIN
/*get row values*/
SELECT 	@department = department
	,  @team = team
	,  @AO = AO
FROM @tbl
WHERE RowID = @iRow
/*perform operations with single row*/
PRINT 'My cursor row  |  ' + CONVERT(varchar,@iRow) + '  |  ' + @department + '  |  ' + @team + '  |  ' + @AO



IF @iRow = 1
	BEGIN 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT  raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  CONVERT(Varchar,raw_plan.Plan_Date,103)	As [Date]
	,  Sum(Setup_Plan)	As Setup_Plan
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE Setup_Canx END)	As Setup_Canx
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 40 THEN NULL ELSE SetUp_BP END)		As SetUp_BP
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 90 THEN NULL ELSE SetUp_FP END )	As SetUp_FP
	,  Sum(SetUp_DD)	As SetUp_DD
	,  Sum(SetUp_Inc)	As SetUp_Inc
	,  Sum(SetUp_Liq)	As SetUp_Liq
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE SetUp_BP_Denom END)	As SetUp_BP_Denom
	,  SUM(Inc_Denom) 	AS SetUp_Inc_Denom
	
	,  Sum(Settle_Plan)	As Settle_Plan
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE Settle_Canx END)	As Settle_Canx
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 40 THEN NULL ELSE Settle_BP END)	As Settle_BP
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 90 THEN NULL ELSE Settle_FP END)	AS Settle_FP
	,  Sum(Settle_Gross_Amt)	As Settle_Gross
	,  Sum(Settle_Net_Amt)		As Settle_Net
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE Settle_BP_Denom END)	As Settle_BP_Denom

	,  (
		SELECT SUM(fte_worked) 
		FROM	MI.dbo.tbl_kpi_fte kpi_fte 
		WHERE raw_plan.Plan_Date = kpi_fte.[date] 
		AND raw_plan.department = kpi_fte.department 
		AND raw_plan.team = kpi_fte.team
		AND raw_plan.[user] = kpi_fte.[user]
	)  AS KPI_FTE

	,  NULL AS Incalls
	,  NULL AS Abncalls

	,  (
		SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] 
		From MI.dbo.tbl_kpi_contact contact 
		WHERE contact.department = raw_plan.department 
		AND raw_plan.team = Contact.team 
		AND raw_plan.Plan_Date = contact.[date]
		AND raw_plan.[user] = contact.[user]
	) AS RPC

	,  (
		SELECT SUM(cms_login_time) as cms_login_time 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team AND cms.[date] = raw_plan.Plan_Date 
		AND raw_plan.[user] = cms.[user]
	) AS cms_login_time
	,  (
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team 
		AND cms.[date] = raw_plan.Plan_Date 
		AND raw_plan.[user] = cms.[user]
	) AS On_Task

	INTO #KPIs
	FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan

	WHERE	DateDiff("dd",raw_plan.Plan_Date,GETDATE()) <= 10
	AND	department = @department
	AND	team = @team
	AND	[user] = @AO

	GROUP BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  raw_plan.Plan_Date

	ORDER BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  raw_plan.Plan_Date


	END

ELSE
	BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	INSERT INTO #KPIs
	SELECT  raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  CONVERT(Varchar,raw_plan.Plan_Date,103)	As [Date]
	,  Sum(Setup_Plan)	As Setup_Plan
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE Setup_Canx END)	As Setup_Canx
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 40 THEN NULL ELSE SetUp_BP END)		As SetUp_BP
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 90 THEN NULL ELSE SetUp_FP END )	As SetUp_FP
	,  Sum(SetUp_DD)	As SetUp_DD
	,  Sum(SetUp_Inc)	As SetUp_Inc
	,  Sum(SetUp_Liq)	As SetUp_Liq
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE SetUp_BP_Denom END)	As SetUp_BP_Denom
	,  SUM(Inc_Denom) 	AS SetUp_Inc_Denom
	
	,  Sum(Settle_Plan)	As Settle_Plan
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE Settle_Canx END)	As Settle_Canx
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 40 THEN NULL ELSE Settle_BP END)	As Settle_BP
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 90 THEN NULL ELSE Settle_FP END)	AS Settle_FP
	,  Sum(Settle_Gross_Amt)	As Settle_Gross
	,  Sum(Settle_Net_Amt)		As Settle_Net
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE Settle_BP_Denom END)	As Settle_BP_Denom

	,  (
		SELECT SUM(fte_worked) 
		FROM	MI.dbo.tbl_kpi_fte kpi_fte 
		WHERE raw_plan.Plan_Date = kpi_fte.[date] 
		AND raw_plan.department = kpi_fte.department 
		AND raw_plan.team = kpi_fte.team
		AND raw_plan.[user] = kpi_fte.[user]
	)  AS KPI_FTE

	,  NULL AS Incalls
	,  NULL AS Abncalls

	,  (
		SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] 
		From MI.dbo.tbl_kpi_contact contact 
		WHERE contact.department = raw_plan.department 
		AND raw_plan.team = Contact.team 
		AND raw_plan.Plan_Date = contact.[date]
		AND raw_plan.[user] = contact.[user]
	) AS RPC

	,  (
		SELECT SUM(cms_login_time) as cms_login_time 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team AND cms.[date] = raw_plan.Plan_Date 
		AND raw_plan.[user] = cms.[user]
	) AS cms_login_time
	,  (
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team 
		AND cms.[date] = raw_plan.Plan_Date 
		AND raw_plan.[user] = cms.[user]
	) AS On_Task

	FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan

	WHERE	DateDiff("dd",raw_plan.Plan_Date,GETDATE()) <= 10
	AND	department = @department
	AND	team = @team
	AND	[user] = @AO

	GROUP BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  raw_plan.Plan_Date

	ORDER BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  raw_plan.Plan_Date


END


/*go to next row*/
SET @iRow = @iRow + 1
	
END

SELECT * FROM #KPIs
WHERE	department = 'Account Management'
ORDER BY
	team
	,  [user]
	,  [Date]
go

Select Distinct [user]
FROM #KPIs
ORDER BY
	[User]
go
DROP TABLE #KPIs





