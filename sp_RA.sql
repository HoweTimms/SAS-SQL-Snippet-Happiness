ALTER PROCEDURE dbo.sp_ra AS

--The SP populates the tbl_ra table with all the related assets linked in Collect-i along with
--the RAs identified from within bigtable based on matching dob, surname and then if they also match
--initial and post-code

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

--Get all the linked accounts from Collect-i
SELECT 	la1.acc_cd as wk_ref, --8 seconds
	la2.acc_cd as ra_wk_ref
INTO #ci_ra
FROM vw_led_acc la1
INNER JOIN vw_led_acc la2
ON la1.ad_cd=la2.ad_cd
WHERE la1.acc_cd<>la2.acc_cd

--Get a summary of the information we are interested in from tblbigtable
--This summary temp-table shoudl be more efficient than using the main table
--in the later SQL
CREATE TABLE #bt
(wk_ref [varchar](10) NOT NULL,
surname [varchar](40) NULL,
initial [varchar](1) NULL,
dob [datetime] NULL,
postcode [varchar](12) NULL)

--Populate the table with the records from tblbigtable
INSERT INTO #bt		--1:03
(wk_ref, surname, initial, dob, postcode)
SELECT CONVERT(varchar(10),wk_ref) as wk_ref,
	LEFT(surname, 40), 
	CONVERT(varchar(1), LEFT(forename, 1)) as initial, 
	dob, 
	LEFT(REPLACE(vpostcode,' ', ''),12) as postcode
FROM tblbigtable

--Add a PK onto the tblbigtable temp table for quicker linking
ALTER TABLE [#bt] WITH NOCHECK ADD --10 secs
	CONSTRAINT [PK_bt] PRIMARY KEY  CLUSTERED 
	(
		[wk_ref]
	)  ON [PRIMARY] 

--Index the dob and surname for quick match
CREATE --12 secs
  INDEX [bt_dob_sur] ON [#bt] 
	([dob], 
	[surname])
ON [PRIMARY]

--Index the postcode for quick match
CREATE --12 secs
  INDEX [bt_postcode] ON [#bt] 
	([postcode])
ON [PRIMARY]

--Get all the bigatble records that match surname and dob and then flag if the postcode or initial match too
SELECT 	bt1.wk_ref as wk_ref, 	--10 seconds!!
	bt2.wk_ref as ra_wk_ref,
	CASE bt1.initial 
		WHEN bt2.initial THEN 1 
		ELSE 0 
	END AS chk_initial,
	CASE bt1.postcode 
		WHEN bt2.postcode THEN 1 
		ELSE 0 
	END AS chk_postcode
INTO #bt_ra
FROM #bt bt1
INNER JOIN #bt bt2
ON bt1.dob=bt2.dob
AND bt1.surname=bt2.surname
AND bt1.wk_ref<>bt2.wk_ref
AND bt1.dob IS NOT NULL


--We are replacing the table entirely so see if it exists first...
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tbl_ra]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tbl_ra]

--re-create it
CREATE TABLE [dbo].[tbl_ra] (
	[wk_ref] [varchar] (12) NOT NULL ,
	[ra_wk_ref] [varchar] (12) NOT NULL ,
	[chk_ci] [bit] NULL ,
	[chk_dob_sur] [bit] NULL ,
	[chk_initial] [bit] NULL ,
	[chk_postcode] [bit] NULL 
) ON [PRIMARY]

--put the PK on
ALTER TABLE [dbo].[tbl_ra] WITH NOCHECK ADD 
	CONSTRAINT [PK_tbl_ra] PRIMARY KEY  CLUSTERED 
	(
		[wk_ref],
		[ra_wk_ref]
	)  ON [PRIMARY] 

--put all the rows in...
INSERT INTO tbl_ra
SELECT ISNULL(ci.wk_ref, bt.wk_ref) as wk_ref,
	ISNULL(ci.ra_wk_ref, bt.ra_wk_ref) as ra_wk_ref,
	CASE ISNULL(ci.wk_ref,'') WHEN '' THEN 0 ELSE 1 END AS chk_ci,
	CASE ISNULL(bt.wk_ref,'') WHEN '' THEN 0 ELSE 1 END AS chk_dob_sur,
	ISNULL(bt.chk_initial, 0) AS chk_initial,
	ISNULL(bt.chk_postcode, 0) AS chk_postcode
FROM #ci_ra ci 
FULL OUTER JOIN #bt_ra bt
ON ci.wk_ref=bt.wk_ref
AND ci.ra_wk_ref=bt.ra_wk_ref

--chuck out the rubbish
DROP TABLE #ci_ra
DROP TABLE #bt_ra
DROP TABLE #bt






