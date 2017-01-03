
USE risk
IF EXISTS
	(SELECT name FROM SYSOBJECTS WHERE name = 'sp_Cumulative_Target' AND type = 'P')
	DROP PROCEDURE dbo.sp_Cumulative_Target
go
CREATE PROCEDURE dbo.sp_Cumulative_Target  AS
PRINT 'sp_Cumulative_Target AO Level'
UPDATE #KPIs
SET	SetUp_Plans_Target_Cum = (SELECT SUM(ISNULL(SetUp_Plans_Target,0)) 
					FROM #KPIs oKPIs 
					WHERE oKPIs.dt<= kpi.dt 
					AND	oKPIs.department = kpi.department
					AND	oKPIs.team = kpi.team
					AND	oKPIs.[user] = kpi.[user] 
							)
					, Settle_Plans_Target_Cum = (SELECT SUM(ISNULL(Settle_Plans_Target,0)) 
					FROM #KPIs oKPIs 
					WHERE oKPIs.dt<= kpi.dt 
					AND	oKPIs.department = kpi.department
					AND	oKPIs.team = kpi.team
					AND	oKPIs.[user] = kpi.[user] 
							 )
					,  SetUp_Cum = (SELECT SUM(ISNULL(SetUp_Plan,0)) 
					FROM #KPIs oKPIs 
					WHERE oKPIs.dt<= kpi.dt 
					AND	oKPIs.department = kpi.department
					AND	oKPIs.team = kpi.team
					AND	oKPIs.[user] = kpi.[user] 
							 )
					,  Settle_Cum = (SELECT SUM(ISNULL(Settle_Plan,0)) 
					FROM #KPIs oKPIs 
					WHERE oKPIs.dt<= kpi.dt 
					AND	oKPIs.department = kpi.department
					AND	oKPIs.team = kpi.team
					AND	oKPIs.[user] = kpi.[user] 
							 )	 
FROM 	#KPIs	kpi

	



CREATE PROCEDURE dbo.sp_TargetChecksFTE AS
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


USE risk
IF EXISTS
	(SELECT name FROM SYSOBJECTS WHERE name = 'sp_InsertWeeklyTarget' AND type = 'P')
	DROP PROCEDURE dbo.sp_InsertWeeklyTarget
go
CREATE PROCEDURE dbo.sp_InsertWeeklyTarget AS
PRINT 'UPDATE TABLE *********************** INSERT WEEKLY TARGETS' 
UPDATE #KPIs
SET	SetUp_Plans_Target		= (SELECT SUM(tar_SetUp) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department) 

	,  Settle_Plans_Target  	= (SELECT SUM(tar_Settle) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department)  
	
	,  SetUp_BP_Rate_Target		= (SELECT MIN(tar_SetUp_BP_Rate) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department)  
	
	,  SetUp_FP_Rate_Target		= (SELECT MIN(tar_SetUp_FP_Rate) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department)  

	,  SetUp_FTE_Target		= 15
	,  Settle_FTE_Target		= 2


	,  Settle_BP_Rate_Target		= (SELECT MIN(tar_Settle_BP_Rate) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department) 
	
	,  Settle_FP_Rate_Target		= (SELECT MIN(tar_Settle_FP_Rate) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department) 
	
	,  SetUp_Liquidation_Target		= (SELECT MIN(tar_SetUp_Liq) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department)  

	,  SetUp_DD_Pen_Target		= (SELECT MIN(tar_SetUp_DD) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department)  
	
	,  SetUp_PI_Rate_Target		= (SELECT MIN(tar_SetUp_PI_Rate) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department)  

	,  SetUp_Inc_Rate_Target		= 0.3

	,  Settle_Discount_Target	= (SELECT MIN(tar_Settle_Discount) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department) 

	,  AbnCall_Rate_Target		= (SELECT MIN(tar_AdnCall_Rate) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department)  
	
	,  RPC_Rate_Target		= (SELECT MIN(tar_RPC_Rate) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department)  
	
	,  On_Task_Rate_Target		= (SELECT MIN(tar_OnTask) 
					FROM 	risk.[CFSI\htimms].ref_KPI_Targets	refKPI
					WHERE	(refKPI.w*1000)+refKPI.y = (KPI.w*1000)+KPI.y
					AND refKPI.hierachy = KPI.department)  
	
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


CREATE PROCEDURE dbo.sp_AddTarget_KPI AS
PRINT 'ALTER KPI TABLE ***********************' 
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





USE risk
IF EXISTS
	(SELECT name FROM SYSOBJECTS WHERE name = 'sp_Weekly_To_Daily_Target' AND type = 'P')
	DROP PROCEDURE dbo.sp_Weekly_To_Daily_Target
go
CREATE PROCEDURE dbo.sp_Weekly_To_Daily_Target AS
UPDATE #KPIs SET
	SetUp_Plans_Target = 
	CEILING(CONVERT(DECIMAL,SetUp_Plans_Target) 
	/ (SELECT SUM(TargetValue) FROM risk.dbo.Calendar oCalendar
		WHERE oCalendar.W = kpi.W
		AND	oCalendar.Y = kpi.Y
		AND	oCalendar.IsHoliday = 0 )  
	)
	* CASE WHEN ISNULL(kpi_fte,0) = 0 THEN NULL ELSE 1 END

	
		,  Settle_Plans_Target = 
	CEILING(CONVERT(DECIMAL,Settle_Plans_Target) 
	/ (SELECT SUM(TargetValue) FROM risk.dbo.Calendar oCalendar
		WHERE oCalendar.W = kpi.W
		AND	oCalendar.Y = kpi.Y
		AND	oCalendar.IsHoliday = 0 )  
	)
	* CASE WHEN ISNULL(kpi_fte,0) = 0 THEN NULL ELSE 1 END

	
	FROM 	#KPIs	kpi

go

USE risk
IF EXISTS
	(SELECT name FROM SYSOBJECTS WHERE name = 'sp_Weekly_To_Daily_DEPT_Target' AND type = 'P')
	DROP PROCEDURE dbo.sp_Weekly_To_Daily_Target
go
CREATE PROCEDURE dbo.sp_Weekly_To_Daily_DEPT_Target AS
UPDATE #KPIs SET
	SetUp_Plans_Target = 
	CEILING(CONVERT(DECIMAL,SetUp_Plans_Target) 
	/ (SELECT SUM(TargetValue) FROM risk.dbo.Calendar oCalendar
		WHERE oCalendar.W = kpi.W
		AND	oCalendar.Y = kpi.Y
		AND	oCalendar.IsHoliday = 0 )  
	)
	* CASE WHEN ISNULL(kpi_fte,0) = 0 THEN NULL ELSE 1 END

	*  (SELECT TargetValue FROM risk.dbo.Calendar oCalendar
	WHERE oCalendar.dt = kpi.dt )

		,  Settle_Plans_Target = 
	CEILING(CONVERT(DECIMAL,Settle_Plans_Target) 
	/ (SELECT SUM(TargetValue) FROM risk.dbo.Calendar oCalendar
		WHERE oCalendar.W = kpi.W
		AND	oCalendar.Y = kpi.Y
		AND	oCalendar.IsHoliday = 0 )  
	)
	* CASE WHEN ISNULL(kpi_fte,0) = 0 THEN NULL ELSE 1 END

	*  (SELECT TargetValue FROM risk.dbo.Calendar oCalendar
	WHERE oCalendar.dt = kpi.dt )
	
	FROM 	#KPIs	kpi

go







USE risk
IF EXISTS
	(SELECT name FROM SYSOBJECTS WHERE name = 'sp_Granularity' AND type = 'P')
	DROP PROCEDURE dbo.sp_Granularity
go
CREATE PROCEDURE dbo.sp_Granularity (@Level Int)
AS
PRINT 'GRANULARITY PROCEDURE'
IF @Level = 1
BEGIN
	UPDATE #KPIs
	SET	SetUp_Plans_Target = CEILING(CONVERT(DECIMAL,SetUp_Plans_Target) / (SELECT COUNT(DISTINCT(team)) 
							FROM RISK..temp_KPI_Raw_Plan rawplan
							WHERE	rawplan.department = kpi.department
							AND	team NOT IN ('(Unallocated)','ADMINISTRATION')) )
	
		,  Settle_Plans_Target = CEILING(CONVERT(DECIMAL,Settle_Plans_Target) / (SELECT COUNT(DISTINCT(team)) 
							FROM RISK..temp_KPI_Raw_Plan rawplan
							WHERE	rawplan.department = kpi.department
							AND	team NOT IN ('(Unallocated)','ADMINISTRATION')) )
	FROM 	#KPIs	kpi
END

--  INDIVIDUALS ARE EXPECTED TO CONTRIBUTE 10% INDIVIDUALLY TO TEAM TARGET
IF @Level = 2
BEGIN
	UPDATE #KPIs
	SET	SetUp_Plans_Target = CEILING(0.1*(CONVERT(DECIMAL,SetUp_Plans_Target) / (SELECT COUNT(DISTINCT(team)) 
							FROM RISK..temp_KPI_Raw_Plan rawplan
							WHERE	rawplan.department = kpi.department
							AND	team NOT IN ('(Unallocated)','ADMINISTRATION')) ))
	
		,  Settle_Plans_Target = CEILING(0.1*(CONVERT(DECIMAL,Settle_Plans_Target) / (SELECT COUNT(DISTINCT(team)) 
							FROM RISK..temp_KPI_Raw_Plan rawplan
							WHERE	rawplan.department = kpi.department
							AND	team NOT IN ('(Unallocated)','ADMINISTRATION')) ))
	
	FROM 	#KPIs	kpi
END
go


