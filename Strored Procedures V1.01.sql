USE risk
go
-- Cursor Simulator
CREATE PROC sp_DateItterator 
AS 

/*Prepare TABLE variable to take resultset*/
DECLARE @tbl TABLE(	
        RowID 			INT IDENTITY(1, 1)
        ,  BookOn_Month 	VARCHAR(3)
        ,  BookOn_Year 		VARCHAR(2)
	,  Maturity 		INT 
	,  Accounting_Period	INT	)

/*Local variables */
DECLARE @BookOn_Month 		VARCHAR(3)
	,  @BookOn_Year 	VARCHAR(2)
	,  @count 		INT	/*create local @@fetch_status*/
	,  @iRow 		INT 	/*row pointer (index)*/
	,  @ExecString 		VARCHAR(1000)
	,  @Accounting_Period	INT	/* Value will be later passed to the Asset Table */

/* create array simulator */
INSERT @tbl 
SELECT 	DISTINCT
	LEFT(CONVERT (varchar,big.bookon_date , 7),3)		as BookOn_Month
	,  RIGHT(CONVERT (varchar,big.bookon_date , 7),2)	as BookOn_Year
	,  DATEDIFF("m",big.bookon_date,GETDATE()) 		as Maturity
	,  Year(big.bookon_date) * 100 + Month(big.bookon_date)	as Accounting_Period
	
FROM	data_warehouse.dbo.tblbigtable big
WHERE	big.bookon_date >= (Select MIN(big.bookon_date) FROM risk..temp_Original_Value big)
ORDER BY
	DATEDIFF("m",big.bookon_date,GETDATE()) desc


/*get array Upper Bound (highest ID number)*/
SET @count = @@ROWCOUNT
/*initialize index counter*/
SET @iRow = 1
/*establish loop structure*/

/*Check to see if result table exists and kill it if it does */
IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'temp_Asset_Mment')
BEGIN
	PRINT 'DROPING TABLE temp_Asset_Mment' 
	DROP TABLE temp_Asset_Mment
END

WHILE @iRow <= @count
BEGIN
/*get row values*/
SELECT @BookOn_Month = BookOn_Month
	,  @BookOn_Year = BookOn_Year 
	,  @Accounting_Period = Accounting_Period
FROM @tbl
WHERE RowID = @iRow
/*perform operations with single row*/
PRINT 'My cursor row  |  ' + CONVERT(varchar,@iRow) + '  |  ' + @BookOn_Month + '  |  ' + @BookOn_Year + ' | ' + CONVERT(VARCHAR,@Accounting_Period)
SET  	@ExecString = @BookOn_Month + @BookOn_Year 
PRINT 	@ExecString
EXEC 	sp_AssetLocation @ExecString , @Accounting_Period
/*go to next row*/
	SET @iRow = @iRow + 1
	
END


CREATE PROC sp_AssetLocation @DatePart VARCHAR(5) , @Accounting_Period INT
AS
/* Local Variables */
DECLARE @tblName VARCHAR(29)	/* The Historic Table Name */
DECLARE @tblExists INT		/* Trigger used to see if the Historic table exists */
DECLARE @parSQL VARCHAR(3000)	/* A string used to parcel the sql */
DECLARE @Trigger INT		/* Trigger used to set the first Insert */

/* Initialize tblName */
SET @tblName = 'Historic Asset Status ' + @DatePart 
PRINT @tblName 




/*Check to see if the Historic Table Exists */
IF EXISTS (SELECT 1 FROM HistoricAssetTables..sysobjects WHERE NAME = @tblName)
BEGIN
	PRINT 'Table ' + @tblName + ' exists.  Set @tblExists to positive state '
	SET @tblExists = 1
END
ELSE	
BEGIN
	PRINT 'Table ' + @tblName + ' does NOT exist.  Set @tblExists to negative state '
	SET @tblExists = 0
END

/* Check to see if the Base table exists */
IF EXISTS (SELECT 1 FROM sysobjects WHERE NAME = 'temp_Original_Value')
BEGIN
	PRINT 'Table temp_Original_Value exists.  Apply positive to Trigger state '
	SET @tblExists = 1 * @tblExists
END
ELSE	
BEGIN
	PRINT 'Table temp_Original_Value does NOT exist.  Apply negative to Trigger state '
	SET @tblExists = 0 * @tblExists
END
/* Initialize Trigger */
SET @Trigger = 1

IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'temp_Asset_Mment')
BEGIN
	PRINT 'Initialise Trigger' 
	/* First Loop Assumption */
	SET @Trigger = 0
END


IF @tblExists = 1 /*Both tables exist */
BEGIN
	IF @Trigger = 1		/* Only true in the first loop */ 
	BEGIN
		PRINT 'Trigger set so needs to use the INTO SQL'
		SET @parSQL = 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
		SELECT ' + Char(39) + @DatePart + Char(39) + ' 		as Period 
		,  ref.bookon
		,  datediff("m",ref.[purchase date],base.[record date]) as Maturity
		,  ref.package_id
		,  [Current Pool Status] 
		,  SUM(base.Curbal) 					as Current_Balance
		,  COUNT(*) 						as Obs
		,  ' + CONVERT(VARCHAR,@Accounting_Period) + '		as Accounting_Period
		INTO risk..temp_Asset_Mment
		FROM HistoricAssetTables.dbo.['+ @tblName + '] 		base
		, risk..temp_Original_Value  				ref
		WHERE base.[debt-code] =  ref.wk_ref  
		GROUP BY ref.bookon, datediff("m",[purchase date],[record date]) , ref.package_id,  [Current Pool Status]'
	PRINT @parSQL
	SET @Trigger = 0	/* And now trigger is closed */
	END

	ELSE			/* True for all subsequent loops */
	BEGIN
		PRINT 'Trigger NOT set so needs to use INSERT SQL'
		SET @parSQL = 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
		INSERT INTO risk..temp_Asset_Mment
		SELECT ' + Char(39) + @DatePart + Char(39) + ' 		as Period 
		,  ref.bookon
		,  datediff("m",ref.[purchase date],base.[record date]) as Maturity
		,  ref.package_id
		,  [Current Pool Status] 
		,  SUM(base.Curbal) 					as Current_Balance
		,  COUNT(*) 						as Obs
		,  ' + CONVERT(VARCHAR,@Accounting_Period) + '		as Accounting_Period
		FROM HistoricAssetTables.dbo.['+ @tblName + '] 		base
		, risk..temp_Original_Value  				ref
		WHERE base.[debt-code] =  ref.wk_ref  
		GROUP BY ref.bookon, datediff("m",[purchase date],[record date]) , ref.package_id,  [Current Pool Status]'
	END

EXEC(@parSQL)	/*Exec the parcelled sql */
END
