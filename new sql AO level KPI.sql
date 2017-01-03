

Use Risk

--	Account M'Ment KPI's 
--	Code created by HT in a hurry on 09/02/2007
--	Version 1.01 First Draft 09/02/2007

--	Data dictionary bespoke to this script follows

--	,  CASE WHEN type = 'P' THEN 1 ELSE 0 END 				AS Setup_Plan
--	,  CASE WHEN type = 'P' THEN CONVERT(int,cancelled_plan) ELSE 0 END 	AS Setup_Canx
--	,  CASE WHEN type = 'P' THEN CONVERT(int,broken_promise) ELSE 0 END 	AS Setup_BP
--	,  CASE WHEN type = 'P' THEN CONVERT(int,failure) ELSE 0 END 		AS Setup_FP
--	,  CASE WHEN ( type = 'P' AND pay_mth = 'P003') THEN 1 ELSE 0 END	AS SetUp_DD
--	,  CASE WHEN ( type = 'P' AND inc >= 5) THEN 1 ELSE 0 END		AS Setup_Inc(@Level
--	,  CASE WHEN type = 'P' THEN liquidation ELSE 0 END 			AS SetUp_Liquidation
--	,  CASE WHEN type = 'P' THEN (1 - CONVERT(int,cancelled_plan)) ELSE 0 END 	AS Setup_BP_Denom

--	,  CASE WHEN type = 'T' THEN 1 ELSE 0 END 				AS Settle_Plan
--	,  CASE WHEN type = 'T' THEN CONVERT(int,cancelled_plan) ELSE 0 END 	AS Settle_Canx
--	,  CASE WHEN type = 'T' THEN CONVERT(int,broken_promise) ELSE 0 END 	AS Settle_BP
--	,  CASE WHEN type = 'T' THEN CONVERT(int,failure) ELSE 0 END 		AS Settle_FP
--	,  CASE WHEN type = 'T' THEN gross_amt ELSE 0	END			AS Settle_Gross_Amt
--	,  CASE WHEN type = 'T' THEN net_amt ELSE 0 END				AS Settle_Net_Amt
--	,  CASE WHEN type = 'T' THEN (1 - CONVERT(int,cancelled_plan)) ELSE 0 END 	AS Settle_BP_Denom

	
--	Bespoke Date table with date parts

Use Risk
go
/*Check to see if ref_Date exists and kill it if it does */
IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'ref_Date')
BEGIN
	PRINT 'DROPING TABLE ref_Date' 
	DROP TABLE ref_Date
END

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


use risk
go
IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'temp_KPI_Raw_Plan')
BEGIN
	PRINT 'DROPING TABLE temp_KPI_Raw_Plan' 
	DROP TABLE temp_KPI_Raw_Plan
END

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Select 	Calendar.W								AS Week_Num
	,  Calendar.dt								AS Plan_Date
	,  plans.[year]		
	,  plans.[month]
	,  plans.department
	,  plans.team
	,  plans.phase
	,  plans.[user]						
	,  SUM(CASE WHEN type = 'P' THEN 1 ELSE 0 END) 				AS Setup_Plan
	,  SUM(CASE WHEN type = 'P' THEN CONVERT(int,cancelled_plan) ELSE 0 END) 	AS Setup_Canx
	,  SUM(CASE WHEN type = 'P' THEN CONVERT(int,broken_promise) ELSE 0 END) 	AS Setup_BP
	,  SUM(CASE WHEN type = 'P' THEN CONVERT(int,failure) ELSE 0 END) 		AS Setup_FP
	,  SUM(CASE WHEN ( type = 'P' AND pay_mth = 'P0003') THEN 1 ELSE 0 END)		AS SetUp_DD
	,  SUM(CASE WHEN ( type = 'P' AND inc >= 5) THEN 1 ELSE 0 END)		AS Setup_Inc
	,  SUM(CASE WHEN type = 'P' THEN (1 - CONVERT(int,cancelled_plan)) ELSE 0 END) 	AS Setup_BP_Denom
	,  SUM(CASE WHEN type = 'P' THEN liquidation ELSE 0 END) 			AS Setup_Liq
	,  SUM(CASE WHEN ( type = 'P' AND Prev_pln_num IS NOT NULL) THEN 1 ELSE 0 END )	As Inc_Denom

	,  SUM(CASE WHEN type = 'T' THEN 1 ELSE 0 END) 					AS Settle_Plan
	,  SUM(CASE WHEN type = 'T' THEN CONVERT(int,cancelled_plan) ELSE 0 END) 	AS Settle_Canx
	,  SUM(CASE WHEN type = 'T' THEN CONVERT(int,broken_promise) ELSE 0 END) 	AS Settle_BP
	,  SUM(CASE WHEN type = 'T' THEN CONVERT(int,failure) ELSE 0 END) 		AS Settle_FP
	,  SUM(CASE WHEN type = 'T' THEN gross_amt ELSE 0	END)			AS Settle_Gross_Amt
	,  SUM(CASE WHEN type = 'T' THEN net_amt ELSE 0 END)				AS Settle_Net_Amt
	,  SUM(CASE WHEN type = 'T' THEN (1 - CONVERT(int,cancelled_plan)) ELSE 0 END) 	AS Settle_BP_Denom
	

INTO	RISK..temp_KPI_Raw_Plan

FROM 	MI.dbo.tbl_kpi_plans		plans
	,  risk.dbo.Calendar  		Calendar

	
WHERE	Calendar.dt *= plans.[date] 
AND	Calendar.dt <= GETDATE()
AND	plans.department = 'Account Management'

GROUP BY
	Calendar.W
	,  Calendar.dt			
	,  plans.[year]	
	,  plans.[month]
	,  plans.department
	,  plans.team
	,  plans.phase
	,  plans.[user]

ORDER BY
	Calendar.W
	,  Calendar.dt			
	,  plans.[year]	
	,  plans.[month]
	,  plans.department
	,  plans.team
	,  plans.phase
	,  plans.[user]



---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------		AO							-------------------
---------------		AO							-------------------
---------------		AO							-------------------
---------------		AO							-------------------
---------------		AO							-------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

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
	PRINT 'CREATE TABLE INTO'
	SELECT  raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  CONVERT(Varchar,raw_plan.Plan_Date,103)	As [Date]
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y
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
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time + cms_aux_1 + cms_aux_2 + cms_aux_3 + cms_aux_8)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team 
		AND cms.[date] = raw_plan.Plan_Date 
		AND raw_plan.[user] = cms.[user]
	) AS On_Task

	INTO #KPIs

	FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan
	,  	risk.dbo.Calendar  		Calendar

	WHERE	raw_plan.Plan_Date >= (SELECT Max(dt)
			FROM	(SELECT 	dt
			,  (SELECT COUNT(*)
			FROM risk..Calendar oCalendar 
			WHERE oCalendar.dt >= iCalendar.dt 
			AND oCalendar.dt <= GETDATE()
			AND isHoliday = 0)as WorkDays
			FROM	risk..Calendar iCalendar
			WHERE	iCalendar.dt <= GETDATE()) AS Derived
			WHERE	WorkDays >=11 )
	AND	department = @department
	AND	team = @team
	AND	[user] = @AO
	AND	raw_plan.Plan_Date = Calendar.dt

	GROUP BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  raw_plan.Plan_Date
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y

	ORDER BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  Calendar.dt

	END
ELSE
	BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	PRINT 'TABLE INSERT'
	INSERT INTO #KPIs
	SELECT  raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  CONVERT(Varchar,raw_plan.Plan_Date,103)	As [Date]
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y
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
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time + cms_aux_1 + cms_aux_2 + cms_aux_3 + cms_aux_8)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team 
		AND cms.[date] = raw_plan.Plan_Date 
		AND raw_plan.[user] = cms.[user]
	) AS On_Task

	FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan
	,  	risk.dbo.Calendar  		Calendar

	WHERE	raw_plan.Plan_Date >= (SELECT Max(dt)
			FROM	(SELECT 	dt
			,  (SELECT COUNT(*)
			FROM risk..Calendar oCalendar 
			WHERE oCalendar.dt >= iCalendar.dt 
			AND oCalendar.dt <= GETDATE()
			AND isHoliday = 0)as WorkDays
			FROM	risk..Calendar iCalendar
			WHERE	iCalendar.dt <= GETDATE()) AS Derived
			WHERE	WorkDays >=11 )
	AND	department = @department
	AND	team = @team
	AND	[user] = @AO
	AND	raw_plan.Plan_Date = Calendar.dt

	GROUP BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  raw_plan.Plan_Date
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y

	ORDER BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.[user]
	,  Calendar.dt

END


/*go to next row*/
SET @iRow = @iRow + 1
	
END
go

--CALL ALTER TABLE PROCEDURE
risk.dbo.sp_AddTarget_KPI 
go
--CALL INSERT WEEKLY TARGETS PROCEDURE
risk.dbo.sp_InsertWeeklyTarget
go
--CALL WEEKLY TO DAILY TARGET PROCEDURE
risk.dbo.sp_Weekly_To_Daily_Target 
go
--CALL GRANULARITY PROCEDURE
risk.dbo.sp_Granularity 2
go
--CALL SET TARGETs to NULL PROCEDURE
risk.dbo.sp_TargetChecksFTE 
go
-- Cumulative targets
risk.dbo.sp_Cumulative_Target 
go




PRINT 'RESULTS'
SELECT * 
	
FROM #KPIs
WHERE	department = 'Account Management'
ORDER BY
	team
	,  [user]
	,  dt
go


DROP TABLE #KPIs
go


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------		TEAM							-------------------
---------------		TEAM							-------------------
---------------		TEAM							-------------------
---------------		TEAM							-------------------
---------------		TEAM							-------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

/*Prepare TABLE variable to take resultset*/
DECLARE @tbl TABLE(	
        RowID INT IDENTITY(1, 1)
        ,  department VARCHAR(30)
        ,  team VARCHAR(30)

	 )
/*Local variables */
DECLARE @department VARCHAR(30)
	,  @team VARCHAR(30)

	,  @count int /*create local @@fetch_status*/
	,  @iRow int  /*row pointer (index)*/
/* create array simulator */
INSERT @tbl 
SELECT Distinct
	department		as department
	,  team			as team

FROM	RISK..temp_KPI_Raw_Plan
ORDER BY
	department
	,  team
	

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
	
FROM @tbl
WHERE RowID = @iRow
/*perform operations with single row*/
PRINT 'My cursor row  |  ' + CONVERT(varchar,@iRow) + '  |  ' + @department + '  |  ' + @team 


IF @iRow = 1
	BEGIN 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	PRINT 'CREATE TABLE INTO'
	SELECT  raw_plan.department
	,  raw_plan.team
	,  raw_plan.team as [user]
	,  CONVERT(Varchar,raw_plan.Plan_Date,103)	As [Date]
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y
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
	)  AS KPI_FTE

	,  NULL AS Incalls
	,  NULL AS Abncalls

	,  (
		SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] 
		From MI.dbo.tbl_kpi_contact contact 
		WHERE contact.department = raw_plan.department 
		AND raw_plan.team = Contact.team 
		AND raw_plan.Plan_Date = contact.[date]
	) AS RPC

	,  (
		SELECT SUM(cms_login_time) as cms_login_time 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team AND cms.[date] = raw_plan.Plan_Date 
	) AS cms_login_time
	,  (
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time + cms_aux_1 + cms_aux_2 + cms_aux_3 + cms_aux_8)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team 
		AND cms.[date] = raw_plan.Plan_Date 
	) AS On_Task

	INTO #KPIs

	FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan
	,  	risk.dbo.Calendar  		Calendar

	WHERE	raw_plan.Plan_Date >= (SELECT Max(dt)
			FROM	(SELECT 	dt
			,  (SELECT COUNT(*)
			FROM risk..Calendar oCalendar 
			WHERE oCalendar.dt >= iCalendar.dt 
			AND oCalendar.dt <= GETDATE()
			AND isHoliday = 0)as WorkDays
			FROM	risk..Calendar iCalendar
			WHERE	iCalendar.dt <= GETDATE()) AS Derived
			WHERE	WorkDays >=11 )
	AND	department = @department
	AND	team = @team
	AND	raw_plan.Plan_Date = Calendar.dt

	GROUP BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.Plan_Date
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y

	ORDER BY
	raw_plan.department
	,  raw_plan.team
	,  Calendar.dt

	END
ELSE
	BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	PRINT 'TABLE INSERT'
	INSERT INTO #KPIs
	SELECT  raw_plan.department
	,  raw_plan.team
	,  raw_plan.team as [user]
	,  CONVERT(Varchar,raw_plan.Plan_Date,103)	As [Date]
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y
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
	)  AS KPI_FTE

	,  NULL AS Incalls
	,  NULL AS Abncalls

	,  (
		SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] 
		From MI.dbo.tbl_kpi_contact contact 
		WHERE contact.department = raw_plan.department 
		AND raw_plan.team = Contact.team 
		AND raw_plan.Plan_Date = contact.[date]
	) AS RPC

	,  (
		SELECT SUM(cms_login_time) as cms_login_time 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team AND cms.[date] = raw_plan.Plan_Date 
	) AS cms_login_time
	,  (
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time + cms_aux_1 + cms_aux_2 + cms_aux_3 + cms_aux_8)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team 
		AND cms.[date] = raw_plan.Plan_Date 
	) AS On_Task

	FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan
	,  	risk.dbo.Calendar  		Calendar

	WHERE	raw_plan.Plan_Date >= (SELECT Max(dt)
			FROM	(SELECT 	dt
			,  (SELECT COUNT(*)
			FROM risk..Calendar oCalendar 
			WHERE oCalendar.dt >= iCalendar.dt 
			AND oCalendar.dt <= GETDATE()
			AND isHoliday = 0)as WorkDays
			FROM	risk..Calendar iCalendar
			WHERE	iCalendar.dt <= GETDATE()) AS Derived
			WHERE	WorkDays >=11 )
	AND	department = @department
	AND	team = @team
	AND	raw_plan.Plan_Date = Calendar.dt

	GROUP BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.Plan_Date
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y

	ORDER BY
	raw_plan.department
	,  raw_plan.team
	,  Calendar.dt

END


/*go to next row*/
SET @iRow = @iRow + 1
	
END
go

--CALL ALTER TABLE PROCEDURE
risk.dbo.sp_AddTarget_KPI 
go
--CALL INSERT WEEKLY TARGETS PROCEDURE
risk.dbo.sp_InsertWeeklyTarget
go
--CALL WEEKLY TO DAILY TARGET PROCEDURE
risk.dbo.sp_Weekly_To_Daily_Target 
go
--CALL GRANULARITY PROCEDURE
risk.dbo.sp_Granularity 1
go
--CALL SET TARGETs to NULL PROCEDURE
risk.dbo.sp_TargetChecksFTE 
go
-- Cumulative targets
risk.dbo.sp_Cumulative_Target 
go
		 	

PRINT 'RESULTS'
SELECT * 
	
FROM #KPIs
WHERE	department = 'Account Management'
ORDER BY
	team
	,  dt
go

						
DROP TABLE #KPIs
go

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------		DAILY							-------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------		DEPARTMENT						-------------------
---------------		DEPARTMENT						-------------------
---------------		DEPARTMENT						-------------------
---------------		DEPARTMENT						-------------------
---------------		DEPARTMENT						-------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

/*Prepare TABLE variable to take resultset*/
DECLARE @tbl TABLE(	
        RowID INT IDENTITY(1, 1)
        ,  department VARCHAR(30)
	 )
/*Local variables */
DECLARE @department VARCHAR(30)
	,  @count int /*create local @@fetch_status*/
	,  @iRow int  /*row pointer (index)*/
/* create array simulator */
INSERT @tbl 
SELECT Distinct
	department		as department

FROM	RISK..temp_KPI_Raw_Plan
ORDER BY
	department
	
/*get array Upper Bound (highest ID number)*/
SET @count = @@ROWCOUNT
/*initialize index counter*/
SET @iRow = 1
/*establish loop structure*/

WHILE @iRow <= @count
BEGIN
/*get row values*/
SELECT 	@department = department

FROM @tbl
WHERE RowID = @iRow
/*perform operations with single row*/
PRINT 'My cursor row  |  ' + CONVERT(varchar,@iRow) + '  |  ' + @department 


IF @iRow = 1
	BEGIN 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	PRINT 'CREATE TABLE INTO'
	SELECT  raw_plan.department
	,  raw_plan.department as team
	,  raw_plan.department as [user]
	,  CONVERT(Varchar,raw_plan.Plan_Date,103)	As [Date]
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y
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
	)  AS KPI_FTE

	,  (
		SELECT SUM(incalls) 
		FROM MI.dbo.tbl_kpi_vdn kpi_vdn 
		WHERE 	Calendar.dt = kpi_vdn.[date]
		AND	kpi_vdn.department = raw_plan.department 
		
	) AS Incalls
	,  (
		SELECT SUM(Abncalls) 
		FROM MI.dbo.tbl_kpi_vdn kpi_vdn 
		WHERE 	Calendar.dt = kpi_vdn.[date]
		AND	kpi_vdn.department = raw_plan.department 
	) AS Abncalls

	,  (
		SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] 
		From MI.dbo.tbl_kpi_contact contact 
		WHERE contact.department = raw_plan.department 
		AND raw_plan.Plan_Date = contact.[date]
	) AS RPC

	,  (
		SELECT SUM(cms_login_time) as cms_login_time 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.[date] = raw_plan.Plan_Date 
	) AS cms_login_time
	,  (
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time + cms_aux_1 + cms_aux_2 + cms_aux_3 + cms_aux_8)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.[date] = raw_plan.Plan_Date 
	) AS On_Task

	INTO #KPIs

	FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan
	,  	risk.dbo.Calendar  		Calendar

	WHERE	raw_plan.Plan_Date >= (SELECT Max(dt)
			FROM	(SELECT 	dt
			,  (SELECT COUNT(*)
			FROM risk..Calendar oCalendar 
			WHERE oCalendar.dt >= iCalendar.dt 
			AND oCalendar.dt <= GETDATE()
			AND isHoliday = 0)as WorkDays
			FROM	risk..Calendar iCalendar
			WHERE	iCalendar.dt <= GETDATE()) AS Derived
			WHERE	WorkDays >=11 )
	AND	department = @department
	AND	raw_plan.Plan_Date = Calendar.dt

	GROUP BY
	raw_plan.department
	,  raw_plan.Plan_Date
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y

	ORDER BY
	raw_plan.department
	,  Calendar.dt

	END
ELSE
	BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	PRINT 'TABLE INSERT'
	INSERT INTO #KPIs
	SELECT  raw_plan.department
	,  raw_plan.department as team
	,  raw_plan.department as [user]
	,  CONVERT(Varchar,raw_plan.Plan_Date,103)	As [Date]
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y
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
	)  AS KPI_FTE

	,  (
		SELECT SUM(incalls) 
		FROM MI.dbo.tbl_kpi_vdn kpi_vdn 
		WHERE 	Calendar.dt = kpi_vdn.[date]
		AND	kpi_vdn.department = raw_plan.department 
		
	) AS Incalls
	,  (
		SELECT SUM(Abncalls) 
		FROM MI.dbo.tbl_kpi_vdn kpi_vdn 
		WHERE 	Calendar.dt = kpi_vdn.[date]
		AND	kpi_vdn.department = raw_plan.department 
	) AS Abncalls

	,  (
		SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] 
		From MI.dbo.tbl_kpi_contact contact 
		WHERE contact.department = raw_plan.department 
		AND raw_plan.Plan_Date = contact.[date]
	) AS RPC

	,  (
		SELECT SUM(cms_login_time) as cms_login_time 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.[date] = raw_plan.Plan_Date 
	) AS cms_login_time
	,  (
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time + cms_aux_1 + cms_aux_2 + cms_aux_3 + cms_aux_8)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.[date] = raw_plan.Plan_Date 
	) AS On_Task

	FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan
	,  	risk.dbo.Calendar  		Calendar

	WHERE	raw_plan.Plan_Date >= (SELECT Max(dt)
			FROM	(SELECT 	dt
			,  (SELECT COUNT(*)
			FROM risk..Calendar oCalendar 
			WHERE oCalendar.dt >= iCalendar.dt 
			AND oCalendar.dt <= GETDATE()
			AND isHoliday = 0)as WorkDays
			FROM	risk..Calendar iCalendar
			WHERE	iCalendar.dt <= GETDATE()) AS Derived
			WHERE	WorkDays >=11 )
	AND	department = @department
	AND	raw_plan.Plan_Date = Calendar.dt

	GROUP BY
	raw_plan.department
	,  raw_plan.Plan_Date
	,  Calendar.dt
	,  Calendar.W
	,  Calendar.Y

	ORDER BY
	raw_plan.department
	,  Calendar.dt
END


/*go to next row*/
SET @iRow = @iRow + 1
	
END
go
--CALL ALTER TABLE PROCEDURE
risk.dbo.sp_AddTarget_KPI 
go
--CALL INSERT WEEKLY TARGETS PROCEDURE
risk.dbo.sp_InsertWeeklyTarget
go
--CALL WEEKLY TO DAILY DEPARTMENT TARGET PROCEDURE
risk.dbo.sp_Weekly_To_Daily_DEPT_Target 
go
--CALL GRANULARITY PROCEDURE
--risk.dbo.sp_Granularity 1
--go
--CALL SET TARGETs to NULL PROCEDURE
risk.dbo.sp_TargetChecksFTE 
go
-- Cumulative targets
risk.dbo.sp_Cumulative_Target 
go
		 	

 
PRINT 'RESULTS'
SELECT * 
	
FROM #KPIs
WHERE	department = 'Account Management'
ORDER BY
	dt
go

DROP TABLE #KPIs
go






---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------		WEEKLY							-------------------
---------------		WEEKLY							-------------------
---------------		WEEKLY							-------------------
---------------		WEEKLY							-------------------
---------------		WEEKLY							-------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------		DEPARTMENT						-------------------
---------------		DEPARTMENT						-------------------
---------------		DEPARTMENT						-------------------
---------------		DEPARTMENT						-------------------
---------------		DEPARTMENT						-------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

/*Prepare TABLE variable to take resultset*/
DECLARE @tbl TABLE(	
        RowID INT IDENTITY(1, 1)
        ,  department VARCHAR(30)
	 )
/*Local variables */
DECLARE @department VARCHAR(30)
	,  @count int /*create local @@fetch_status*/
	,  @iRow int  /*row pointer (index)*/
/* create array simulator */
INSERT @tbl 
SELECT Distinct
	department		as department

FROM	RISK..temp_KPI_Raw_Plan
ORDER BY
	department
	
/*get array Upper Bound (highest ID number)*/
SET @count = @@ROWCOUNT
/*initialize index counter*/
SET @iRow = 1
/*establish loop structure*/

WHILE @iRow <= @count
BEGIN
/*get row values*/
SELECT 	@department = department

FROM @tbl
WHERE RowID = @iRow
/*perform operations with single row*/
PRINT 'My cursor row  |  ' + CONVERT(varchar,@iRow) + '  |  ' + @department 


IF @iRow = 1
	BEGIN 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	PRINT 'CREATE TABLE INTO'
	SELECT  raw_plan.department
	,  raw_plan.department AS team
	,  raw_plan.department AS [user]
	,  MIN(Calendar.dt)	AS dt
	,  Calendar.W
	,  Calendar.Y
	,  Sum(Setup_Plan)	As Setup_Plan
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE Setup_Canx END)	As Setup_Canx
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 50 THEN NULL ELSE SetUp_BP END)		As SetUp_BP
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 100 THEN NULL ELSE SetUp_FP END )	As SetUp_FP
	,  Sum(SetUp_DD)	As SetUp_DD
	,  Sum(SetUp_Inc)	As SetUp_Inc
	,  Sum(SetUp_Liq)	As SetUp_Liq
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE SetUp_BP_Denom END)	As SetUp_BP_Denom
	,  SUM(Inc_Denom) 	AS SetUp_Inc_Denom
	
	,  Sum(Settle_Plan)	As Settle_Plan
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE Settle_Canx END)	As Settle_Canx
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 50 THEN NULL ELSE Settle_BP END)	As Settle_BP
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 100 THEN NULL ELSE Settle_FP END)	AS Settle_FP
	,  Sum(Settle_Gross_Amt)	As Settle_Gross
	,  Sum(Settle_Net_Amt)		As Settle_Net
	,  Sum(CASE WHEN DATEDIFF("dd",raw_plan.Plan_Date,GETDATE()) <= 5 THEN NULL ELSE Settle_BP_Denom END)	As Settle_BP_Denom

	,  (
		SELECT SUM(fte_worked) 
		FROM	MI.dbo.tbl_kpi_fte 	kpi_fte
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = kpi_fte.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND raw_plan.department = kpi_fte.department 
	)  AS KPI_FTE

	,  (
		SELECT SUM(incalls) 
		FROM MI.dbo.tbl_kpi_vdn 	kpi_vdn 
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = kpi_vdn.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND kpi_vdn.department = raw_plan.department 
		
	) AS Incalls
	,  (
		SELECT SUM(Abncalls) 
		FROM MI.dbo.tbl_kpi_vdn kpi_vdn 
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = kpi_vdn.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND kpi_vdn.department = raw_plan.department 

	) AS Abncalls

	,  (
		SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] 
		From MI.dbo.tbl_kpi_contact contact 
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = contact.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND contact.department = raw_plan.department 
	) AS RPC

	,  (
		SELECT SUM(cms_login_time) as cms_login_time 
		From MI.dbo.tbl_kpi_cms_activity cms 
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = cms.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND cms.department = raw_plan.department 
	) AS cms_login_time
	
	,  (
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time + cms_aux_1 + cms_aux_2 + cms_aux_3 + cms_aux_8)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = cms.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND cms.department = raw_plan.department 
	) AS On_Task

	INTO #KPIs

	FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan
	,  	risk.dbo.Calendar  		Calendar

	WHERE	department = @department
	AND	raw_plan.Plan_Date = Calendar.dt

	GROUP BY
	raw_plan.department
	,  Calendar.W
	,  Calendar.Y

	ORDER BY
	raw_plan.department
	,  MIN(Calendar.dt)

	END
ELSE
	BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	PRINT 'TABLE INSERT'
	INSERT INTO #KPIs
	SELECT  raw_plan.department
	,  raw_plan.department AS team
	,  raw_plan.department AS [user]
	,  MIN(Calendar.dt)
	,  Calendar.W
	,  Calendar.Y
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
		FROM	MI.dbo.tbl_kpi_fte 	kpi_fte
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = kpi_fte.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND raw_plan.department = kpi_fte.department 
	)  AS KPI_FTE

	,  (
		SELECT SUM(incalls) 
		FROM MI.dbo.tbl_kpi_vdn 	kpi_vdn 
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = kpi_vdn.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND kpi_vdn.department = raw_plan.department 
		
	) AS Incalls
	,  (
		SELECT SUM(Abncalls) 
		FROM MI.dbo.tbl_kpi_vdn kpi_vdn 
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = kpi_vdn.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND kpi_vdn.department = raw_plan.department 

	) AS Abncalls

	,  (
		SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] 
		From MI.dbo.tbl_kpi_contact contact 
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = contact.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND contact.department = raw_plan.department 
	) AS RPC

	,  (
		SELECT SUM(cms_login_time) as cms_login_time 
		From MI.dbo.tbl_kpi_cms_activity cms 
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = cms.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND cms.department = raw_plan.department 
	) AS cms_login_time
	
	,  (
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time + cms_aux_1 + cms_aux_2 + cms_aux_3 + cms_aux_8)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		,  risk.dbo.Calendar  		oCalendar
		WHERE oCalendar.dt = cms.[date]
		AND oCalendar.W = Calendar.W
		AND oCalendar.Y = Calendar.Y
		AND cms.department = raw_plan.department 
	) AS On_Task

	FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan
	,  	risk.dbo.Calendar  		Calendar

	WHERE	department = @department
	AND	raw_plan.Plan_Date = Calendar.dt

	GROUP BY
	raw_plan.department
	,  Calendar.W
	,  Calendar.Y
	ORDER BY
	raw_plan.department
	,  MIN(Calendar.dt)

END


/*go to next row*/
SET @iRow = @iRow + 1
	
END


go
--CALL ALTER TABLE PROCEDURE
risk.dbo.sp_AddTarget_KPI 
go
--CALL INSERT WEEKLY TARGETS PROCEDURE
risk.dbo.sp_InsertWeeklyTarget
go
--CALL WEEKLY TO DAILY TARGET PROCEDURE
--risk.dbo.sp_Weekly_To_Daily_Target 
--go
--CALL GRANULARITY PROCEDURE
--risk.dbo.sp_Granularity 1
--go
--CALL SET TARGETs to NULL PROCEDURE
risk.dbo.sp_TargetChecksFTE 
go
-- Cumulative targets
risk.dbo.sp_Cumulative_Target 
go

PRINT 'RESULTS'
SELECT * 
	
FROM #KPIs
WHERE	department = 'Account Management'
AND	DateDiff("ww",dt,GETDATE()) > 0


ORDER BY
	Y
	,  W
go


DROP TABLE #KPIs
go
