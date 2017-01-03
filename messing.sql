


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
	,  CASE WHEN type = 'P' THEN 1 ELSE 0 END 				AS Setup_Plan
	,  CASE WHEN type = 'P' THEN CONVERT(int,cancelled_plan) ELSE 0 END 	AS Setup_Canx
	,  CASE WHEN type = 'P' THEN CONVERT(int,broken_promise) ELSE 0 END 	AS Setup_BP
	,  CASE WHEN type = 'P' THEN CONVERT(int,failure) ELSE 0 END 		AS Setup_FP
	,  CASE WHEN ( type = 'P' AND pay_mth = 'P0003') THEN 1 ELSE 0 END		AS SetUp_DD
	,  CASE WHEN ( type = 'P' AND inc >= 5) THEN 1 ELSE 0 END		AS Setup_Inc
	,  CASE WHEN type = 'P' THEN (1 - CONVERT(int,cancelled_plan)) ELSE 0 END 	AS Setup_BP_Denom
	,  CASE WHEN type = 'P' THEN liquidation ELSE 0 END 			AS Setup_Liq
	,  CASE WHEN ( type = 'P' AND Prev_pln_num IS NOT NULL) THEN 1 ELSE 0 END 	As Inc_Denom

	,  CASE WHEN type = 'T' THEN 1 ELSE 0 END 					AS Settle_Plan
	,  CASE WHEN type = 'T' THEN CONVERT(int,cancelled_plan) ELSE 0 END 	AS Settle_Canx
	,  CASE WHEN type = 'T' THEN CONVERT(int,broken_promise) ELSE 0 END 	AS Settle_BP
	,  CASE WHEN type = 'T' THEN CONVERT(int,failure) ELSE 0 END 		AS Settle_FP
	,  CASE WHEN type = 'T' THEN gross_amt ELSE 0	END			AS Settle_Gross_Amt
	,  CASE WHEN type = 'T' THEN net_amt ELSE 0 END				AS Settle_Net_Amt
	--,  CASE WHEN type = 'T' THEN (1 - CONVERT(int,cancelled_plan) ELSE 0 END 	AS Settle_BP_Denom
	,  plans.wk_ref
	,  plans.pln_num
	,  plans.act_rev
	,  plans.prev_pln_num
	,  plans.pay_mth

FROM 	MI.dbo.tbl_kpi_plans		plans
	,  risk..ref_Date		refDates

	
WHERE	refDates.plan_create_date = plans.[date] 
AND	plans.department = 'Account Management'
AND	DateDiff("dd",plans.[date],GETDATE()) =5






SELECT 	*
From 	MI.dbo.tbl_kpi_cms_activity cms 
WHERE 	cms.department = 'Account Management'
AND	DateDiff("dd",cms.[date],GETDATE()) =5

SELECT	SUM(cms_login_time)


SELECT	CONVERT(Varchar,cms.[Date],103)
	,  SUM(cms_login_time) as cms_login_time
	,  SUM(cms_available_time) as cms_available_time
	,  SUM(cms_acw_time) as cms_acw_time
	,  SUM(cms_acd_time) as cms_acd_time
	,  SUM(cms_aux_time) as cms_aux_time
	,  SUM(cms_other_time) as cms_other_time
	,  SUM(cms_ring_time) as cms_ring_time
	,  SUM(cms_aux_0) as cms_aux_0
	,  SUM(cms_aux_1) as cms_aux_1
	,  SUM(cms_aux_2) as cms_aux_2
	,  SUM(cms_aux_3) as cms_aux_3
	,  SUM(cms_aux_4) as cms_aux_4
	,  SUM(cms_aux_5) as cms_aux_5
	,  SUM(cms_aux_6) as cms_aux_6
	,  SUM(cms_aux_7) as cms_aux_7
	,  SUM(cms_aux_8) as cms_aux_8
	,  SUM(cms_aux_9) as cms_aux_9
	,  SUM(inbound_cms_calls) as inbound_cms_calls
	,  SUM(outbound_cms_calls) as outbound_cms_calls
	,  SUM(total_cms_calls) as total_cms_calls

FROM	MI.dbo.tbl_kpi_cms_activity cms 
WHERE 	cms.department = 'Account Management'
AND	DateDiff("dd",cms.[date],GETDATE()) <=30

GROUP BY
	[Date]
ORDER BY
	[Date]












