** This section creates data for illustration purposes.
DATA LIST FREE /person.
BEGIN DATA.
1 3 2 4 5 
END DATA.
SET SEED=135792468.
LOOP subj=1 TO 15.
	COMPUTE rating=TRUNC(UNIFORM(1)*3).
	XSAVE OUTFILE='data.sav' /KEEP person subj rating.
END LOOP.
EXECUTE.
GET  FILE='data.sav'.

** Start the job.
AGGREGATE
  /OUTFILE=*
  /BREAK=person rating
  /N_BREAK=N.
AGGREGATE
  /OUTFILE='temp.sav'
  /BREAK=person
  /nb=SUM(n_break).
SORT CASES BY person.
MATCH FILES /FILE=*
 /TABLE='temp.sav'
 /BY person.
* In next line replace the 2 by the value which means 'Good'.
SELECT IF (rating=2).
COMPUTE pcgood=n_break/nb.

RANK
  VARIABLES=pcgood  (A) /RANK /PRINT=YES
  /TIES=CONDENSE .

