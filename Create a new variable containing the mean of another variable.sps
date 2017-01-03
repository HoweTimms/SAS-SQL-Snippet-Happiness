* Create a new variable containing the mean of another variable.

* Ray 2003/06/17.

GET FILE='c:\program files\spss\employee data.sav'.
SORT CASES BY educ.
COMPUTE nobreak=1.
AGGREGATE OUTFILE='c:\temp\temp.sav'
	/PRESORTED
	/BREAK=nobreak
	/avgeduc=MEAN(educ).

MATCH FILES FILE=*
	/TABLE='c:\temp\temp.sav'
	/BY=nobreak.

* want mean educ within each jobcat.
GET FILE='c:\program files\spss\employee data.sav'.
SORT CASES BY jobcat.
AGGREGATE OUTFILE='c:\temp\temp.sav'
	/PRESORTED
	/BREAK=jobcat
	/avgeduc=MEAN(educ).

MATCH FILES FILE=*
	/TABLE='c:\temp\temp.sav'
	/BY=jobcat.