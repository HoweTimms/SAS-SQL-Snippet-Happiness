* Objective: Save data file with the current date as part of the name.
* rlevesque@videotron.ca 2004/05/24.

* Define dummy data .
DATA LIST FREE /a.
BEGIN DATA 
1 2 3 
END DATA.

* Define a macro which will yield the current date.
STRING #cdate(A9).
COMPUTE #cdate=$DATE.
DO IF $casenum=1.
WRITE OUTFILE 'c:\temp\temp.sps' /"DEFINE !date()'"#cdate"'!ENDDEFINE.".
END IF.
EXECUTE.
* Run the macro.
INCLUDE 'c:\temp\temp.sps'.

SAVE OUTFILE='c:\temp\example1_' + !date + '.sav'.

