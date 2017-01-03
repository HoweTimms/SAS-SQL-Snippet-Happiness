Use risk
go

IF EXISTS (SELECT 1 FROM sysobjects WHERE uid = user_id() AND type = 'U' AND NAME = 'ref_AddressData')
BEGIN
	PRINT 'DROPING TABLE risk..ref_AddressData' 
	DROP TABLE risk..ref_AddressData
END
go


CREATE TABLE risk..ref_AddressData(
  Address_Data 	CHAR(50) NOT NULL
, Gospel_Address_Data CHAR(8) NOT NULL)

go

INSERT INTO risk..ref_AddressData(Address_Data , Gospel_Address_Data)
SELECT 'NULL','Unknown'
UNION ALL SELECT '','Unknown'
UNION ALL SELECT '[Skip]','None'
UNION ALL SELECT 'Address','None'
UNION ALL SELECT 'Address Unknown','None'
UNION ALL SELECT 'b&e','C/O'
UNION ALL SELECT 'Bankrupt','Bankrupt'
UNION ALL SELECT 'Busienss','Business'
UNION ALL SELECT 'Business','Business'
UNION ALL SELECT 'C/O','C/O'
UNION ALL SELECT 'C/O - No House No.','C/O'
UNION ALL SELECT 'C/O Barclays Bank','C/O'
UNION ALL SELECT 'CAB','C/O'
UNION ALL SELECT 'check','None'
UNION ALL SELECT 'Check - incomplete address','None'
UNION ALL SELECT 'Check - street number/name?','None'
UNION ALL SELECT 'Check - Town & County Mismatch','None'
UNION ALL SELECT 'Check - Town & Postcode Mismatch','None'
UNION ALL SELECT 'Check Name','None'
UNION ALL SELECT 'CO','C/O'
UNION ALL SELECT 'DCA','C/O'
UNION ALL SELECT 'Deceased','C/O'
UNION ALL SELECT 'Forces','Forces'
UNION ALL SELECT 'Foreign','Overseas'
UNION ALL SELECT 'Fraud','Unlikely'
UNION ALL SELECT 'Immediate PUT','PUT'
UNION ALL SELECT 'MBNA PUT Request','PUT'
UNION ALL SELECT 'MBNA Recall','PUT'
UNION ALL SELECT 'MBNA Reqd Repurch','PUT'
UNION ALL SELECT 'No Address','None'
UNION ALL SELECT 'No adress','None'
UNION ALL SELECT 'No Postcode','Postcode'
UNION ALL SELECT 'None','None'
UNION ALL SELECT 'OK','OK'
UNION ALL SELECT 'Old Address','None'
UNION ALL SELECT 'Oversaes','Overseas'
UNION ALL SELECT 'Overseas','Overseas'
UNION ALL SELECT 'Overseas (Ireland)','Overseas'
UNION ALL SELECT 'Overseas (Irish)','Overseas'
UNION ALL SELECT 'Overseas -  Usa','Overseas'
UNION ALL SELECT 'Overseas - Americas','Overseas'
UNION ALL SELECT 'Overseas - Canada','Overseas'
UNION ALL SELECT 'Overseas - France','Overseas'
UNION ALL SELECT 'Overseas - Germany','Overseas'
UNION ALL SELECT 'Overseas - India','Overseas'
UNION ALL SELECT 'Overseas - Ireland','Overseas'
UNION ALL SELECT 'Overseas - Malaysia','Overseas'
UNION ALL SELECT 'Overseas - MEA','Overseas'
UNION ALL SELECT 'Overseas - NZ','Overseas'
UNION ALL SELECT 'Overseas - Other Asia','Overseas'
UNION ALL SELECT 'Overseas - Other Europe','Overseas'
UNION ALL SELECT 'Overseas - Singapore','Overseas'
UNION ALL SELECT 'Overseas - Spain','Overseas'
UNION ALL SELECT 'Overseas - USA','Overseas'
UNION ALL SELECT 'Overseas -Australia','Overseas'
UNION ALL SELECT 'Partial Address','Overseas'
UNION ALL SELECT 'PI Box','PO Box'
UNION ALL SELECT 'PO Box','PO Box'
UNION ALL SELECT 'Post Code','Postcode'
UNION ALL SELECT 'Postcode','Postcode'
UNION ALL SELECT 'Prison','Prison'
UNION ALL SELECT 'SEQUESTRATED','Bankrupt'
UNION ALL SELECT 'Unikely','Unlikely'
UNION ALL SELECT 'Unliely','Unlikely'
UNION ALL SELECT 'Unlikely','Unlikely'
UNION ALL SELECT 'Unlikey','Unlikely'
UNION ALL SELECT 'Unlikley','Unlikely'
go