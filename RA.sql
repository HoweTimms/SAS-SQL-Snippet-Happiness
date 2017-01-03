

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- ad_cd 	System-generated business partner code. Links to business partner details
-- acc_cd	System generated account code (wk_ref)

SELECT	TOP 100
	parent_led_acc.acc_cd as wk_ref
	,  child_led_acc.acc_cd as ra_wk_ref

FROM	data_warehouse.dbo.vw_led_acc		parent_led_acc
	,  data_warehouse.dbo.vw_led_acc	child_led_acc

WHERE	parent_led_acc.ad_cd = child_led_acc.ad_cd
AND	parent_led_acc.acc_cd <> child_led_acc.acc_cd


DROP TABLE risk..CK

CREATE TABLE risk..CK (
wk_ref 	varchar(10)	PRIMARY KEY
  ,  Client_Key	varchar(39)	NOT NULL
  ,  Surname	varchar(30)	NOT NULL
  ,  Initial	varchar(1)	NULL
  ,  DOB	datetime	NULL
  ,  Postcode	varchar(7)	NULL
  ,  vPostCode	integer		NOT NULL
  ,  fDOB	integer		NULL
)


INSERT INTO risk..CK (wk_ref, Surname, Initial, DOB, Postcode, vPostCode, fDOB, Client_Key)
SELECT derived.wk_ref
	,  derived.surname + SPACE(30-LEN(derived.surname))as Surname
	,  derived.Initial
	,  derived.dob
	,  CASE WHEN derived.vpostcode < 9  then derived.Postcode ELSE 'XXXXXXX' END as Postcode
	,  derived.vPostcode
	,  derived.fDOB
	,  derived.surname + SPACE(30-LEN(derived.surname)) + CASE WHEN Initial IS NULL THEN ' '  ELSE Initial END + CASE WHEN fdob IS NULL THEN '99999999' ELSE fdob END as CK
FROM	(

SELECT 
  CONVERT(varchar(10),wk_ref) as wk_ref
  ,  UPPER(REPLACE(surname,' ','')) as Surname
  ,  LEFT(UPPER(REPLACE(forename,' ','')),1) as Initial
  ,  dob 
  ,  REPLACE(bigtable.vpostcode,' ','') as PostCode 
  ,  CASE WHEN UPPER(REPLACE(bigtable.vpostcode,' ','')) LIKE '[A-Z][0-9][0-9][A-Z][A-Z]' 		THEN 1
  	WHEN UPPER(REPLACE(bigtable.vpostcode,' ','')) LIKE '[A-Z][0-9][0-9][0-9][A-Z][A-Z]' 		THEN 2 
  	WHEN UPPER(REPLACE(bigtable.vpostcode,' ','')) LIKE '[A-Z][A-Z][0-9][0-9][A-Z][A-Z]' 		THEN 3 
 	WHEN UPPER(REPLACE(bigtable.vpostcode,' ','')) LIKE '[A-Z][A-Z][0-9][0-9][0-9][A-Z][A-Z]' 	THEN 4 
  	WHEN UPPER(REPLACE(bigtable.vpostcode,' ','')) LIKE '[A-Z][0-9][A-Z][0-9][A-Z][A-Z]' 		THEN 5 
  	WHEN UPPER(REPLACE(bigtable.vpostcode,' ','')) LIKE '[A-Z][A-Z][0-9][A-Z][0-9][A-Z][A-Z]' 	THEN 6 
	WHEN UPPER(REPLACE(bigtable.vpostcode,' ','')) LIKE 'BFP%'					THEN 7
  	ELSE 9 
  END as vPostCode 
  ,  REPLACE(CONVERT(Char,dob,103),'/','') as fdob

FROM data_warehouse.dbo.tblbigtable bigtable
WHERE	surname is not null
AND	(LEN(REPLACE(bigtable.vpostcode,' ','')) <= 7 OR vpostcode is NULL)


) as derived


CREATE INDEX iClient on risk..CK(Client_Key)

-- DROP TABLE risk.DistinctCK
SELECT 	Client_Key
	,  Count(*) as Obs
INTO	risk.DistinctCK
FROM 	risk..CK
WHERE	DOB is not NULL
GROUP BY
	Client_Key
ORDER BY
	Client_Key

CREATE INDEX iClient on risk.DistinctCK(Client_Key)

/* Show the number of RA within BigTable */

SELECT 	Obs
	,  Count(*) as Freq
FROM 	risk.DistinctCK
GROUP BY
	Obs
ORDER BY
	Obs

/* Somebody has 15!!  so take a look */

SELECT 	TOP 1000 risk.*
	
FROM	risk..CK 			risk
	,  risk.DistinctCK 		drisk
WHERE	risk.Client_Key = drisk.Client_Key 
AND	drisk.Obs = 15
ORDER BY risk.Client_Key
	,  risk.wk_ref


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT 	TOP 1000 ledacc.ad_cd
	,  risk.*
	
FROM	risk..CK 			risk
	,  risk.DistinctCK 		drisk
	,  data_warehouse.dbo.vw_led_acc	ledacc
WHERE	risk.Client_Key = drisk.Client_Key 
AND	drisk.Obs =15
AND	risk.wk_ref = ledacc.acc_cd
ORDER BY risk.Client_Key
	,  risk.wk_ref

SELECT	bigtable.bp_ref
	,  risk.wk_ref
	,  risk.Client_Key
	,  bigtable.category
	,  bigtable.strategy
	,  bigtable.que
	,  bigtable.current_balance
	,  bigtable.package_id
	,  bigtable.vpostcode
	,  bigtable.vadd1

FROM	data_warehouse.dbo.tblbigtable bigtable
	,  risk..CK 			risk
	,  risk.DistinctCK 		drisk
WHERE	bigtable.wk_ref = risk.wk_ref
AND	risk.Client_Key = drisk.Client_Key 
AND	drisk.Obs =15

ORDER BY
	risk.wk_ref Asc


/* RA at time of purchase */
--DROP TABLE risk..RA_Purchase
Select	cust.wk_ref
	,  SUM(CASE WHEN isnull(risk.Purchase_Date,'01-JAN-1994') >= derived.Purchase_Date THEN 1 ELSE 0 END) AS RA
	,  SUM(CASE WHEN isnull(risk.Purchase_Date,'01-JAN-1994') >= derived.Purchase_Date THEN [Balance Purchased] ELSE 0 END) AS RA_Exposure

INTO	risk..RA_Purchase

FROM	risk..CK 	cust
	,  risk..tmpVendor	risk
	,  	(SELECT cust.wk_ref
		,  cust.Client_Key
		,  ISNULL(risk.Purchase_Date,'01-JAN-1994') as Purchase_Date
		FROM	risk..CK 	cust
		,  risk..tmpVendor	risk
		Where	cust.wk_ref = risk.[debt-code] ) as derived
Where	cust.wk_ref = risk.[debt-code]
AND	cust.Client_Key = derived.Client_Key 
AND	cust.DOB IS NOT NULL -- Deals with rubbish Client Key
Group By cust.wk_ref

go
CREATE INDEX iWk_Ref on risk..RA_Purchase(wk_ref)
go

/* Test table counts */

SELECT Count(*) from risk..tmpVendor
Where [debt-code] not in (select wk_ref from risk..RA_Purchase)
go
--  Attributed loss of accounts to no RA possible for cases with no Surname (risk..CK condition)
SELECT Count(*) from risk..tmpVendor
Where [debt-code] not in (select wk_ref from risk..CK)
go


SELECT RA
	,  COUNT(*) as Freq
FROM	risk..RA_Purchase
GROUP BY
	RA
ORDER BY
	RA

SELECT *
FROM 	risk..CK 		cust
	,  risk..tmpVendor	risk

WHERE	cust.wk_ref = risk.[debt-code]
AND	cust.Client_Key in 
(SELECT Client_Key FROM risk..RA_Purchase ra, risk..CK ck where ra.wk_ref = ck.wk_ref AND RA = 0)