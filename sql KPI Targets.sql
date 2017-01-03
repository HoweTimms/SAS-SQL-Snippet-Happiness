
/* Target Table */

Use risk
go

--DROP TABLE ref_KPI_Targets
--PRINT 'DROPIN' 
CREATE TABLE ref_KPI_Targets (
	hierachy_type 		VARCHAR(30)
	,  hierachy		VARCHAR(30)
	,  W 			INT
	,  Y			INT
	,  tar_SetUp		INT
	,  tar_SetUp_BP_Rate	DECIMAL(4,2)
	,  tar_SetUp_FP_Rate	DECIMAL(4,2)
	,  tar_SetUp_Liq	INT
	,  tar_SetUp_DD		DECIMAL(4,2)
	,  tar_SetUp_PI_Rate	DECIMAL(4,2)
	,  tar_Settle		INT
	,  tar_Settle_BP_Rate	DECIMAL(4,2)
	,  tar_Settle_FP_Rate	DECIMAL(4,2)
	,  tar_Settle_Discount  DECIMAL(4,2)
	,  tar_AdnCall_Rate	DECIMAL(4,2)
	,  tar_RPC_Rate		DECIMAL(4,2)
	,  tar_OnTask		DECIMAL(4,2)
)
go




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
PRINT 'My cursor row  |  ' + CONVERT(varchar,@iRow) + '  |  ' + @department + '  |  ' 

/*go to next row*/
SET @iRow = @iRow + 1
	
INSERT INTO ref_KPI_Targets
SELECT  'Department'
	,  @department 
	,  W 
	,  Y
	,  2020
	,  0.41
	,  0.2
	,  60
	,  0.5
	,  0.3
	,  300
	,  0.41
	,  0.05
	,  0.9
	,  0.05
	,  0.70
	,  0.75
FROM	risk.dbo.Calendar

GROUP BY
	W
	,  Y
ORDER BY
	W
	,  Y

END
go


SELECT * FROM risk..ref_KPI_Targets



DECLARE @StartDate VARCHAR(8), @EndDate VARCHAR(8), @Department VARCHAR(30), @Newvalue DECIMAL(4,2)

SET @Newvalue = 0.3
SET @StartDate = '20070301'
SET @EndDate = '20070501'
SET @Department = 'Account Management'


/* GEAR DOWN WEEKLY BP TARGETS */

UPDATE risk..ref_KPI_Targets SET  

	tar_SetUp_BP_Rate =   tar_SetUp_BP_Rate - 
	(Targets.W - 
	(SELECT min(w) - 1 FROM risk.dbo.Calendar  Calendar WHERE dt BETWEEN @StartDate AND @EndDate) ) 
	* ((tar_SetUp_BP_Rate - @Newvalue) 
		/ 
	(SELECT COUNT(DISTINCT(w))FROM	risk.dbo.Calendar  Calendar WHERE dt BETWEEN @StartDate AND @EndDate AND hierachy = @Department))
FROM	risk..ref_KPI_Targets 	Targets
WHERE	(w*1000)+y in (SELECT (w*1000)+y FROM risk.dbo.Calendar  WHERE dt BETWEEN @StartDate AND @EndDate AND hierachy = @Department)



UPDATE risk..ref_KPI_Targets SET
	tar_Settle_BP_Rate = tar_SetUp_BP_Rate 

FROM	risk..ref_KPI_Targets 	Targets
WHERE	(w*1000)+y in (SELECT (w*1000)+y FROM risk.dbo.Calendar  WHERE dt BETWEEN @StartDate AND @EndDate AND hierachy = @Department)



UPDATE  risk..ref_KPI_Targets SET
	tar_Settle_BP_Rate = @Newvalue
	,  tar_SetUp_BP_Rate = @Newvalue

FROM	risk..ref_KPI_Targets 	Targets
WHERE	(w*1000)+y in (SELECT (w*1000)+y FROM risk.dbo.Calendar  	Calendar WHERE dt >= @EndDate AND hierachy = @Department)


/*
SELECT * FROM risk..ref_KPI_Targets
WHERE	hierachy = 'Account Management'
ORDER BY
	Y
	,  W
*/

go


GRANT SELECT ON ref_KPI_Targets to PUBLIC


