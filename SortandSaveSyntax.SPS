GET
  FILE='C:\Cassini\Data\BASEL\Perform200208.sav'.
EXECUTE.
SORT CASES BY
  Account_Number (A) .
EXECUTE.
SAVE OUTFILE='C:\Cassini\Data\BASEL\Perform200208.sav'
 /COMPRESSED.
