
*** Define File Path Variables ****.

define !DataPath ()'C:\Documents and Settings\HTimms\My Documents\Risk\SC Developments\BASEL\Extraction\Data\' !EndDefine.
define !SyntaxPath ()'C:\Documents and Settings\HTimms\My Documents\Risk\SC Developments\BASEL\Extraction\Syntax\'!EndDefine.
define !OutPath ()'C:\Documents and Settings\HTimms\My Documents\Risk\SC Developments\BASEL\Extraction\Documents\' !EndDefine.

*** Get Base File ****.

GET FILE = !DataPath + 'SPSS\Cards_DCM_01a.sav'.

* Ensure no duplicates

MATCH FILES /FILE = *
 /FIRST = temp /BY Account_Number.
SELECT IF temp.
EXECUTE.

* Clean up

DELETE VARIABLES temp.

* Sort Cases so appends wont fail

SORT CASES BY
  Account_Number (A) .
EXECUTE.

SAVE OUTFILE = !DataPath + 'SPSS\bas_ret_FullBase.sav'
 /COMPRESSED.