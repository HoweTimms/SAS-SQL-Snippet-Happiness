Use MI

--	Account M'Ment KPI's 
--	Code created by HT in a hurry on 09/02/2007
--	Version 1.01 First Draft 09/02/2007

--	Data dictionary bespoke to this script follows

--	,  CASE WHEN type = 'P' THEN 1 ELSE 0 END 				AS Setup_Plan
--	,  CASE WHEN type = 'P' THEN CONVERT(int,cancelled_plan) ELSE 0 END 	AS Setup_Canx
--	,  CASE WHEN type = 'P' THEN CONVERT(int,broken_promise) ELSE 0 END 	AS Setup_BP
--	,  CASE WHEN type = 'P' THEN CONVERT(int,failure) ELSE 0 END 		AS Setup_FP
--	,  CASE WHEN ( type = 'P' AND pay_mth = 'P003') THEN 1 ELSE 0 END	AS SetUp_DD
--	,  CASE WHEN ( type = 'P' AND inc >= 5) THEN 1 ELSE 0 END		AS Setup_Inc
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

Use MI
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT	DISTINCT
	[date]			AS	plan_create_date
	,  CONVERT(varchar,[date],103)AS	dDate
	,  DATEPART(wk,[date])	AS 	dWeekPart
	,  DATEPART(mm,[date])	AS	dMonth
	,  DATENAME(mm,[date])	AS	dMonth_Name
	,  DATENAME(yyyy,[date])	AS	dYear

INTO	risk..ref_Date

FROM 	MI.dbo.tbl_kpi_plans

ORDER BY
	[date]
go

CREATE INDEX iDate on risk..ref_Date(plan_create_date)
go



-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


use risk
go
IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'temp_KPI_Raw_Plan')
BEGIN
	PRINT 'DROPING TABLE temp_KPI_Raw_Plan' 
	DROP TABLE temp_KPI_Raw_Plan
END

use MI
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Select 	refDates.dWeekPart							AS Week_Num
	,  plans.[date]								AS Plan_Date
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
	,  risk..ref_Date		refDates

	
WHERE	refDates.plan_create_date = plans.[date] 
--AND	DateDiff("dd",plans.[date],GETDATE()) <= 8
AND	department = 'Account Management'


GROUP BY
	refDates.dWeekPart
	,  plans.[date]		
	,  plans.[year]	
	,  plans.[month]
	,  plans.department
	,  plans.team
	,  plans.phase
	,  plans.[user]

ORDER BY
	refDates.dWeekPart
	,  plans.[date]		
	,  plans.[year]	
	,  plans.[month]
	,  plans.department
	,  plans.team
	,  plans.phase
	,  plans.[user]


--SELECT * FROM RISK..temp_KPI_Raw_Plan

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
---------------------------------------------------------------------------------------------------
/* DAILY */
/* Department */
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

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT  raw_plan.department
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

	,  (SELECT SUM(fte_worked) FROM	MI.dbo.tbl_kpi_fte kpi_fte WHERE raw_plan.Plan_Date = kpi_fte.[date] AND raw_plan.department = kpi_fte.department )  AS KPI_FTE

	,  (SELECT SUM(incalls) FROM MI.dbo.tbl_kpi_vdn kpi_vdn WHERE kpi_vdn.department = raw_plan.department AND raw_plan.Plan_Date = kpi_vdn.[date]) AS Incalls
	,  (SELECT SUM(abncalls) FROM MI.dbo.tbl_kpi_vdn kpi_vdn ,  MI.dbo.tbl_ref_vdn	ref_vdn WHERE	kpi_vdn.VDN = ref_vdn.VDN AND ref_vdn.department = raw_plan.department AND raw_plan.Plan_Date = kpi_vdn.[date]) AS Abncalls

	,  (SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] From MI.dbo.tbl_kpi_contact contact WHERE contact.department = raw_plan.department AND raw_plan.Plan_Date = contact.[date]) AS RPC

	,  (SELECT SUM(cms_login_time) as cms_login_time From MI.dbo.tbl_kpi_cms_activity cms WHERE cms.department = raw_plan.department AND cms.[date] = raw_plan.Plan_Date ) AS cms_login_time
	,  (SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time)) As On_Task From MI.dbo.tbl_kpi_cms_activity cms WHERE cms.department = raw_plan.department AND cms.[date] = raw_plan.Plan_Date ) AS On_Task



FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan

WHERE	DateDiff("dd",raw_plan.Plan_Date,GETDATE()) <= 10
AND	department = @department
GROUP BY
	raw_plan.department
	,  raw_plan.Plan_Date

ORDER BY
	raw_plan.department
	,  raw_plan.Plan_Date

/*go to next row*/
	SET @iRow = @iRow + 1
	
END

go

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

/* Team */
/* DAILY */

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
	, @team = team
FROM @tbl
WHERE RowID = @iRow
/*perform operations with single row*/
PRINT 'My cursor row  |  ' + CONVERT(varchar,@iRow) + '  |  ' + @department + '  |  ' + @team

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT  raw_plan.department
	,  raw_plan.team
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
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team 
		AND cms.[date] = raw_plan.Plan_Date 
	) AS On_Task

FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan

WHERE	DateDiff("dd",raw_plan.Plan_Date,GETDATE()) <= 10
AND	department = @department
AND	team = @team

GROUP BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.Plan_Date

ORDER BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.Plan_Date

/*go to next row*/
	SET @iRow = @iRow + 1
	
END

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
---------------------------------------------------------------------------------------------------
/* WEEKLY */
/* Department */
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

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT  raw_plan.department
	,  raw_plan.Week_Num
	,  MIN(raw_plan.Plan_Date)	As [Date]
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
		FROM	MI.dbo.tbl_kpi_fte kpi_fte 
		,  risk..ref_Date	ref_Date
		WHERE 	ref_Date.plan_create_date = kpi_fte.[date]
		AND	raw_plan.Week_Num = ref_Date.dWeekPart
		AND 	raw_plan.department = kpi_fte.department 
	)  AS KPI_FTE

	,  (
		SELECT SUM(incalls) 
		FROM MI.dbo.tbl_kpi_vdn kpi_vdn 
		,  risk..ref_Date	ref_Date
		WHERE ref_Date.plan_create_date = kpi_vdn.[date]
		AND	raw_plan.Week_Num = ref_Date.dWeekPart
		AND	kpi_vdn.department = raw_plan.department 
		
	) AS Incalls
	,  (
		SELECT SUM(abncalls) 
		FROM MI.dbo.tbl_kpi_vdn kpi_vdn 
		,  MI.dbo.tbl_ref_vdn	ref_vdn 
		,  risk..ref_Date	ref_Date
		WHERE	kpi_vdn.VDN = ref_vdn.VDN 
		AND ref_vdn.department = raw_plan.department 
		AND ref_Date.plan_create_date = kpi_vdn.[date]
		AND raw_plan.Week_Num = ref_Date.dWeekPart
	) AS Abncalls

	,  (
		SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] 
		From MI.dbo.tbl_kpi_contact contact 
		,  risk..ref_Date	ref_Date
		WHERE contact.department = raw_plan.department 
		AND ref_Date.plan_create_date = contact.[date]
		AND raw_plan.Week_Num = ref_Date.dWeekPart
	) AS RPC

	,  (
		SELECT SUM(cms_login_time) as cms_login_time 
		From MI.dbo.tbl_kpi_cms_activity cms 
		,  risk..ref_Date	ref_Date
		WHERE cms.department = raw_plan.department 
		AND ref_Date.plan_create_date = cms.[date]
		AND raw_plan.Week_Num = ref_Date.dWeekPart
	) AS cms_login_time

	,  (
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		,  risk..ref_Date	ref_Date
		WHERE cms.department = raw_plan.department 
		AND ref_Date.plan_create_date = cms.[date]
		AND raw_plan.Week_Num = ref_Date.dWeekPart
	) AS On_Task

FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan

WHERE	DateDiff("ww",raw_plan.Plan_Date,GETDATE()) > 0
AND	department = @department
GROUP BY
	raw_plan.department
	,  raw_plan.Week_Num


ORDER BY
	raw_plan.department
	,  MIN(raw_plan.Plan_Date)

/*go to next row*/
	SET @iRow = @iRow + 1
	
END
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

/* Team and Phase */
/* WEEKLY */

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
	, @team = team
FROM @tbl
WHERE RowID = @iRow
/*perform operations with single row*/
PRINT 'My cursor row  |  ' + CONVERT(varchar,@iRow) + '  |  ' + @department + '  |  ' + @team

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT  raw_plan.department
	,  raw_plan.team
	,  raw_plan.Week_Num
	,  MIN(raw_plan.Plan_Date)	As [Date]
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
		FROM	MI.dbo.tbl_kpi_fte kpi_fte 
		,  risk..ref_Date	ref_Date
		WHERE 	ref_Date.plan_create_date = kpi_fte.[date]
		AND	raw_plan.Week_Num = ref_Date.dWeekPart
		AND 	raw_plan.department = kpi_fte.department 
		AND	raw_plan.team = kpi_fte.team
	)  AS KPI_FTE

	,  NULL AS Incalls
	,  NULL	AS Abncalls

	,  (
		SELECT SUM(CASE WHEN con_cd IN ('CUST') THEN 1 ELSE 0 END) AS [RPC] 
		From MI.dbo.tbl_kpi_contact contact 
		,  risk..ref_Date	ref_Date
		WHERE contact.department = raw_plan.department 
		AND contact.team = raw_plan.team
		AND ref_Date.plan_create_date = contact.[date]
		AND raw_plan.Week_Num = ref_Date.dWeekPart
	) AS RPC

	,  (
		SELECT SUM(cms_login_time) as cms_login_time 
		From MI.dbo.tbl_kpi_cms_activity cms 
		,  risk..ref_Date	ref_Date
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team
		AND ref_Date.plan_create_date = cms.[date]
		AND raw_plan.Week_Num = ref_Date.dWeekPart
	) AS cms_login_time

	,  (
		SELECT SUM((cms_available_time + cms_acd_time + cms_ring_time)) As On_Task 
		From MI.dbo.tbl_kpi_cms_activity cms 
		,  risk..ref_Date	ref_Date
		WHERE cms.department = raw_plan.department 
		AND cms.team = raw_plan.team
		AND ref_Date.plan_create_date = cms.[date]
		AND raw_plan.Week_Num = ref_Date.dWeekPart
	) AS On_Task

FROM 	RISK..temp_KPI_Raw_Plan 	raw_plan

WHERE	DateDiff("ww",raw_plan.Plan_Date,GETDATE()) > 0
AND	department = @department
And	team = @team

GROUP BY
	raw_plan.department
	,  raw_plan.team
	,  raw_plan.Week_Num


ORDER BY
	raw_plan.department
	,  raw_plan.team
	,  MIN(raw_plan.Plan_Date)


/*go to next row*/
	SET @iRow = @iRow + 1
	
END
go

