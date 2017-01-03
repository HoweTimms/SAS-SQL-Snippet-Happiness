*(Q)I want to compute a set of two new variables (one based on the lower limit of the
CI of the mean of a variable) and one based on the (upper limit of the CI of the
mean for the same variable).

*(A) Posted to SPSSX-L list by Raynald Levesque on 2003/06/03.

*//////////////.
DEFINE !AddCInt (vname=!TOKENS(1) /conf=!TOKENS(1) /fname=!TOKENS(1))

SET MPRINT=yes.
GET FILE=!fname.
/* next command is only for checking purposes */

SELECT IF NOT MISSING(!vname).
EXAMINE
  VARIABLES=!vname
  /COMPARE GROUP /PLOT=NONE
  /STATISTICS DESCRIPTIVES
  /CINTERVAL !conf
  /MISSING LISTWISE
  /NOTOTAL.

COMPUTE nobreak=1.
AGGREGATE OUTFILE=*
	/BREAK=nobreak
	/N=n /sd_var=SD(!vname) /mean_var=MEAN(!vname).
COMPUTE se_mean=sd_var/SQRT(n).


COMPUTE lowCI=mean_var - se_mean * IDF.T(1-(100-!conf)/200,n-1).
COMPUTE upCI =mean_var + se_mean * IDF.T(1-(100-!conf)/200,n-1).
VARIABLE LABELS lowCI !QUOTE(!CONCAT("Lower ",!conf,"% CI for mean ",!vname)).
VARIABLE LABELS upCI !QUOTE(!CONCAT("Upper ",!conf,"% CI for mean ",!vname)).
SAVE OUTFILE='c:\temp\temp.sav' /KEEP=nobreak lowCI upCI.

GET FILE=!fname.
COMPUTE nobreak=1.
MATCH FILES FILE=*
	/TABLE='c:\temp\temp.sav' 
	/BY=nobreak.
EXECUTE.
SET MPRINT=no.
!ENDDEFINE.
*//////////////.

** Example 1 (95% CI for a large sample).
!addCInt 	vname=salary 
		conf=95 
		fname='c:\Program Files\SPSS\Employee data.sav'.


** Example 2 (90% CI for a small sample).
GET FILE='c:\Program Files\SPSS\Employee data.sav'.
N OF CASES 15.
SAVE OUTFILE='c:\temp\eee data.sav'.
!addCInt 	vname=salbegin
		conf=90 
		fname='c:\temp\eee data.sav'.

** Example 3 (95% CI when there are missing values).
GET FILE='c:\Program Files\SPSS\Employee data.sav'.

* Create some missing values.
IF UNIFORM(1)<.2 salbegin=$SYSMIS.

SAVE OUTFILE='c:\temp\eee data2.sav'.
!addCInt 	vname=salbegin
		conf=95 
		fname='c:\temp\eee data2.sav'.

