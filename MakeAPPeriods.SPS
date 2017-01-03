* From  'C:\Cassini\Data\BASEL\Mod\DCM_01Mod.sav' Makes 3 tables based upon AP's


GET FILE 'C:\Cassini\Data\BASEL\Mod\DCM_01Mod.sav'.

FILTER OFF.
USE ALL.
SELECT IF(Accounting_Period = 200208).
EXECUTE .

SAVE OUTFILE='c:\Cassini\Data\Basel\Mod\DCM_200208.sav'
/COMPRESSED.

FREQUENCIES
  VARIABLES=Accounting_Period
  /ORDER=  ANALYSIS .

GET FILE 'C:\Cassini\Data\BASEL\Mod\DCM_01Mod.sav'.

FILTER OFF.
USE ALL.
SELECT IF(Accounting_Period = 200209).
EXECUTE .

SAVE OUTFILE='c:\Cassini\Data\Basel\Mod\DCM_200209.sav'
/COMPRESSED.

FREQUENCIES
  VARIABLES=Accounting_Period
  /ORDER=  ANALYSIS .

GET FILE 'C:\Cassini\Data\BASEL\Mod\DCM_01Mod.sav'.

FILTER OFF.
USE ALL.
SELECT IF(Accounting_Period = 200210).
EXECUTE .

SAVE OUTFILE='c:\Cassini\Data\Basel\Mod\DCM_200210.sav'
/COMPRESSED.

FREQUENCIES
  VARIABLES=Accounting_Period
  /ORDER=  ANALYSIS .
