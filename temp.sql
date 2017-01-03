
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
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time)) As On_Task 
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
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time)) As On_Task 
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


PRINT 'ALTER TABLE ***********************' 
ALTER TABLE #KPIs ADD 
	SetUp_Plans_Target		INT
	,  SetUp_Cum			INT
	,  Settle_Plans_Target  	INT
	,  Settle_Cum			INT
	,  SetUp_Plans_Target_Cum 	INT
	,  Settle_Plans_Target_Cum	INT
	,  SetUp_BP_Rate		DECIMAL(4,2)
	,  SetUp_FP_Rate		DECIMAL(4,2)
	,  SetUp_BP_Rate_Target		DECIMAL(4,2)
	,  SetUp_FP_Rate_Target		DECIMAL(4,2)
	,  SetUp_FTE_Target		INT
	,  Settle_FTE_Target		INT
	,  Settle_BP_Rate		DECIMAL(4,2)
	,  Settle_FP_Rate		DECIMAL(4,2)
	,  Settle_BP_Rate_Target	DECIMAL(4,2)
	,  Settle_FP_Rate_Target	DECIMAL(4,2)
	,  SetUp_Liquidation		DECIMAL(8,2)
	,  SetUp_Liquidation_Target	DECIMAL(4,2)
	,  SetUp_DD_Pen			DECIMAL(4,2)
	,  SetUp_DD_Pen_Target		DECIMAL(4,2)
	,  SetUp_PI_Rate		DECIMAL(4,2)
	,  SetUp_PI_Rate_Target		DECIMAL(4,2)
	,  Settle_Discount		DECIMAL(4,2)
	,  Settle_Discount_Target	DECIMAL(4,2)
	,  AbnCall_Rate			DECIMAL(4,2)
	,  AbnCall_Rate_Target		DECIMAL(4,2)
	,  RPC_Rate			DECIMAL(4,2)
	,  RPC_Rate_Target		DECIMAL(4,2)
	,  On_Task_Rate			DECIMAL(4,2)
	,  On_Task_Rate_Target		DECIMAL(4,2)
	,  SetUp_Inc_Rate		DECIMAL(4,2)
	,  SetUp_Inc_Rate_Target	DECIMAL(4,2)
	,  SetUp_Plans_Per_FTE		DECIMAL(4,2)
	,  Settle_Plans_Per_FTE		DECIMAL(4,2)
	,  SetUp_FTE_Actual		DECIMAL(38,2)
	,  Settle_FTE_Actual		DECIMAL(38,2)
go


PRINT 'UPDATE TABLE *********************** PART ONE' 
UPDATE #KPIs
SET	SetUp_Plans_Target		= (SELECT SUM(tar_SetUp) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 

	,  Settle_Plans_Target  	= (SELECT SUM(tar_Settle) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 
	
	,  SetUp_BP_Rate_Target		= (SELECT MIN(tar_SetUp_BP_Rate) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 
	
	,  SetUp_FP_Rate_Target		= (SELECT MIN(tar_SetUp_FP_Rate) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 

	,  SetUp_FTE_Target		= 15
	,  Settle_FTE_Target		= 2


	,  Settle_BP_Rate_Target		= (SELECT MIN(tar_Settle_BP_Rate) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 
	
	,  Settle_FP_Rate_Target		= (SELECT MIN(tar_Settle_FP_Rate) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 
	
	,  SetUp_Liquidation_Target		= (SELECT MIN(tar_SetUp_Liq) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 

	,  SetUp_DD_Pen_Target		= (SELECT MIN(tar_SetUp_DD) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 
	
	,  SetUp_PI_Rate_Target		= (SELECT MIN(tar_SetUp_PI_Rate) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 

	,  SetUp_Inc_Rate_Target		= 0.3

	,  Settle_Discount_Target	= (SELECT MIN(tar_Settle_Discount) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 

	,  AbnCall_Rate_Target		= (SELECT MIN(tar_AdnCall_Rate) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 
	
	,  RPC_Rate_Target		= (SELECT MIN(tar_RPC_Rate) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 
	
	,  On_Task_Rate_Target		= (SELECT MIN(tar_OnTask) 
					FROM 	risk..ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y) 
	
	,  SetUp_BP_Rate		= CASE WHEN SetUp_BP IS NOT NULL THEN ( CONVERT(DECIMAL,SetUp_BP) / CONVERT(DECIMAL,SetUp_BP_Denom) ) END
	,  SetUp_FP_Rate		= CASE WHEN SetUp_BP IS NOT NULL THEN ( CONVERT(DECIMAL,SetUp_FP) / CONVERT(DECIMAL,SetUp_BP_Denom) ) END
	,  Settle_BP_Rate		= CASE WHEN Settle_BP IS NOT NULL THEN ( CONVERT(DECIMAL,Settle_BP) / CONVERT(DECIMAL,Settle_BP_Denom) ) END
	,  Settle_FP_Rate		= CASE WHEN Settle_FP IS NOT NULL THEN ( CONVERT(DECIMAL,Settle_FP) / CONVERT(DECIMAL,Settle_BP_Denom) ) END

	,  SetUp_Liquidation		= CASE WHEN ISNULL(Setup_Plan,0) > 0 
				THEN CONVERT(DECIMAL,(CONVERT(DECIMAL,SetUp_Liq) / CONVERT(DECIMAL,Setup_Plan)) / 30.5) ELSE NULL END
 
	,  SetUp_DD_Pen			= CASE WHEN ISNULL(Setup_Plan,0) > 0 THEN (CONVERT(DECIMAL,SetUp_DD) / CONVERT(DECIMAL,Setup_Plan)) END

	,  SetUp_PI_Rate		= CASE WHEN ISNULL(Setup_Plan,0) > 0 THEN (CONVERT(DECIMAL,SetUp_Inc) / CONVERT(DECIMAL,Setup_Plan)) END

	,  Settle_Discount		= CASE WHEN ISNULL(Settle_Gross ,0) > 0 THEN (CONVERT(DECIMAL,Settle_Net) / CONVERT(DECIMAL,Settle_Gross)) END

	,  AbnCall_Rate			= CASE WHEN ISNULL(InCalls ,0) > 0 THEN CONVERT(DECIMAL,Abncalls) / CONVERT(DECIMAL,Incalls) END

	,  RPC_Rate			= CASE WHEN ISNULL(RPC,0) >0 THEN CONVERT(DECIMAL,(SetUp_Plan+Settle_Plan)) / CONVERT(DECIMAL,RPC) END

	,  On_Task_Rate			= CASE WHEN ISNULL(On_Task,0) >0 THEN CONVERT(DECIMAL,On_Task) / CONVERT(DECIMAL,cms_login_time) END
	
	,  SetUp_Inc_Rate		= CASE WHEN ISNULL(SetUp_Inc_Denom,0) >0 THEN CONVERT(DECIMAL,SetUp_Inc) / CONVERT(DECIMAL,SetUp_Inc_Denom) END

	,  SetUp_FTE_Actual		= CASE WHEN ISNULL(KPI_FTE,0) >0 THEN CONVERT(DECIMAL,Setup_Plan) / KPI_FTE END
	,  Settle_FTE_Actual		= CASE WHEN ISNULL(KPI_FTE,0) >0 THEN CONVERT(DECIMAL,Settle_Plan) / KPI_FTE END

	,  SetUp_Plans_Per_FTE		= CASE WHEN ISNULL(KPI_FTE,0) >0 THEN CONVERT(DECIMAL,Setup_Plan) / KPI_FTE END
	,  Settle_Plans_Per_FTE		= CASE WHEN ISNULL(KPI_FTE,0) >0 THEN CONVERT(DECIMAL,Settle_Plan) / KPI_FTE END


FROM	#KPIs KPI

go


-- Weekly to Daily Division

PRINT 'UPDATE TABLE *********************** PART TWO'
UPDATE #KPIs
SET	SetUp_Plans_Target = 
	CEILING(CONVERT(DECIMAL,SetUp_Plans_Target) / (SELECT COUNT(*) FROM risk.dbo.Calendar oCalendar
	WHERE oCalendar.W = kpi.W
	AND	oCalendar.Y = kpi.Y
	AND	oCalendar.IsHoliday = 0 ) ) 
	
	* (SELECT TargetValue FROM risk.dbo.Calendar oCalendar WHERE oCalendar.dt = kpi.dt ) 

	,  Settle_Plans_Target = 
	CEILING(CONVERT(DECIMAL,Settle_Plans_Target) / (SELECT COUNT(*) FROM risk.dbo.Calendar oCalendar
	WHERE oCalendar.W = kpi.W
	AND	oCalendar.Y = kpi.Y
	AND	oCalendar.IsHoliday = 0 ) ) 
		* (SELECT TargetValue FROM risk.dbo.Calendar oCalendar WHERE oCalendar.dt = kpi.dt ) 

FROM 	#KPIs	kpi

go

-- SET Target to NULL is not FTE present
PRINT 'UPDATE TABLE *********************** NULL Target No Staff'
UPDATE #KPIs
SET	SetUp_Plans_Target		= NULL
	,  Settle_Plans_Target  	= NULL
	,  SetUp_Plans_Target_Cum 	= NULL
	,  Settle_Plans_Target_Cum	= NULL
	,  SetUp_BP_Rate_Target		= NULL
	,  SetUp_FP_Rate_Target		= NULL
	,  SetUp_FTE_Target		= NULL
	,  Settle_FTE_Target		= NULL
	,  Settle_BP_Rate_Target	= NULL
	,  Settle_FP_Rate_Target	= NULL
	,  SetUp_Liquidation_Target	= NULL
	,  SetUp_DD_Pen_Target		= NULL
	,  SetUp_PI_Rate_Target		= NULL
	,  Settle_Discount_Target	= NULL
	,  AbnCall_Rate_Target		= NULL
	,  RPC_Rate_Target		= NULL
	,  On_Task_Rate_Target		= NULL
	,  SetUp_Inc_Rate_Target	= NULL
	,  SetUp_Plans_Per_FTE		= NULL
	,  Settle_Plans_Per_FTE		= NULL
FROM	#KPIs
WHERE	KPI_FTE IS NULL
go

-- Cumulative targets
PRINT 'UPDATE TABLE *********************** PART THREE'
UPDATE #KPIs
SET	SetUp_Plans_Target_Cum = (SELECT SUM(ISNULL(SetUp_Plans_Target,0)) 
					FROM #KPIs oKPIs 
					WHERE oKPIs.dt<= kpi.dt 
					)
	, Settle_Plans_Target_Cum = (SELECT SUM(ISNULL(Settle_Plans_Target,0)) 
					FROM #KPIs oKPIs 
					WHERE oKPIs.dt<= kpi.dt 
					 )
	,  SetUp_Cum = (SELECT SUM(ISNULL(SetUp_Plan,0)) 
					FROM #KPIs oKPIs 
					WHERE oKPIs.dt<= kpi.dt  
					 )
	,  Settle_Cum = (SELECT SUM(ISNULL(Settle_Plan,0)) 
					FROM #KPIs oKPIs 
					WHERE oKPIs.dt<= kpi.dt 
					 )
	
FROM 	#KPIs	kpi

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



