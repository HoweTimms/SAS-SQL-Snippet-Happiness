

use risk

DROP TABLE  risk.dbo.Calendar  
CREATE TABLE risk.dbo.Calendar  
(  
    	dt 			SMALLDATETIME NOT NULL PRIMARY KEY CLUSTERED
	,  isWeekday 		BIT
	,  isHoliday 		BIT
	,  Y 			SMALLINT
	,  FY 			SMALLINT
	,  Q 			TINYINT
	,  M 			TINYINT
	,  D 			TINYINT
	,  DW 			TINYINT
	,  monthname 		VARCHAR(9)
	,  dayname 		VARCHAR(9)
	,  W 			TINYINT
	,  EOWProcess 		BIT DEFAULT 0
	,  EOMProcess 		BIT DEFAULT 0
	,  SpecialProcess	BIT DEFAULT 0
	,  TargetValue		DECIMAL(4,2) DEFAULT 1
	
) 
go




-- POPULATE WITH DATES

SET NOCOUNT ON 
DECLARE @dt SMALLDATETIME 
SET @dt = '20060601' 
WHILE @dt < '20100101' 
BEGIN 
    INSERT risk.dbo.Calendar(dt) SELECT @dt 
    SET @dt = @dt + 1 
END
go

-- UPDATE Calendar Values

UPDATE risk.dbo.Calendar  SET 
 
    isWeekday = CASE  
        WHEN DATEPART(DW, dt) IN (1,7)  
        THEN 0 
        ELSE 1 END 
 
    ,  isHoliday = 0 
 
    ,  Y = YEAR(dt)
 
    -- if our fiscal year 
    -- starts on May 1st: 
 
    ,  FY = CASE  
        WHEN MONTH(dt) < 5 
        THEN YEAR(dt)-1  
        ELSE YEAR(dt) END
 
    ,  Q = CASE 
        WHEN MONTH(dt) <= 3 THEN 1 
        WHEN MONTH(dt) <= 6 THEN 2 
        WHEN MONTH(dt) <= 9 THEN 3 
        ELSE 4 END  
 
    ,  M = MONTH(dt)
 
    ,  D = DAY(dt)
 
    ,  DW = DATEPART(DW, dt)
 
    ,  monthname = DATENAME(MONTH, dt)
 
    ,  dayname = DATENAME(DW, dt)  
 
    ,  W = DATEPART(WK, dt) 

go

-- UPDATE Holiday Flags

UPDATE risk.dbo.Calendar   SET 
	isHoliday =1 
	,  TargetValue = 0
WHERE dayname in ('Sunday')
	
go


-- UPDATE Target Flags

UPDATE risk.dbo.Calendar   SET 
	TargetValue = 0.5
WHERE dayname in ('Saturday')
	
go

-- UPDATE EOWProcess

UPDATE risk.dbo.Calendar   SET 
	EOWProcess = 1 Where dayname = 'Monday'
go


-- UPDATE EOMProcess

UPDATE risk.dbo.Calendar   SET 
	EOMProcess = 1 Where dt IN 
	(SELECT MIN(dt)
	FROM	risk.dbo.Calendar  
	WHERE	isHoliday = 0
	GROUP BY
		M
		, Y)
go


SELECT 	*
FROM	risk.dbo.Calendar  





CREATE FUNCTION dbo.udf_isProcessDate (@date datetime, @Type varchar(10))
RETURNS BIT
BEGIN
DECLARE @x BIT
SET @x=NULL
IF @type='isHoliday' 
SELECT @x = isHoliday FROM risk.dbo.Calendar 
    WHERE CONVERT(VARCHAR(10),dt,112) =CONVERT(VARCHAR(10),@date,112)
IF @type='isWeekday' 
SELECT @x = isWeekday FROM risk.dbo.Calendar 
    WHERE CONVERT(VARCHAR(10),dt,112) =CONVERT(VARCHAR(10),@date,112)
If @type='EOM' 
SELECT @x = EOMProcess FROM risk.dbo.Calendar 
    WHERE CONVERT(VARCHAR(10),dt,112) =CONVERT(VARCHAR(10),@date,112)
If @type='EOW' 
SELECT @x = EOWProcess FROM risk.dbo.Calendar 
    WHERE CONVERT(VARCHAR(10),dt,112) =CONVERT(VARCHAR(10),@date,112)
If @type='Special' 
SELECT @x = SpecialProcess FROM risk.dbo.Calendar 
    WHERE CONVERT(VARCHAR(10),dt,112) =CONVERT(VARCHAR(10),@date,112)
RETURN @x
END
go

select risk.dbo.udf_isProcessDate(getdate(),'isWeekday')








CREATE FUNCTION dbo.udf_WorkDays (@date DATETIME, @WorkDays INT))
RETURNS DATETIME
BEGIN
DECLARE @x INT
SET @x=1

WHILE @x < @WorkDays
	

RETURN @x
END
go


AND	Calendar.dt >= (SELECT Max(dt)
			FROM	(SELECT 	dt
			,  (SELECT COUNT(*)
			FROM risk..Calendar oCalendar 
			WHERE oCalendar.dt >= iCalendar.dt 
			AND oCalendar.dt <= GETDATE()
			AND isHoliday = 0)as WorkDays
			FROM	risk..Calendar iCalendar
			WHERE	iCalendar.dt <= GETDATE()) AS Derived
			WHERE	WorkDays >=11 )