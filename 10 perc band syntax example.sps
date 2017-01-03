SET MPRINT=ON.
* Define a data file for illustration purposes.
NEW file.
input program.
set seed=987654321.
loop casenum=1 to 100.
compute draw=uniform(100).
compute class1=rnd(uniform(1)).
end case.
end loop.
end file.
end input program.
execute.

*It is important to define this dummy variable in the main data file.
COMPUTE dummy=1.
SAVE OUTFILE='temp.sav'.

* Say you need to determine deciles (divide data in 10 pieces) based on cases where class1=1.
* and that you must then recode ALL values of draw usign the break points obtained using cases where class1=0.
* Raynald Levesque.

SELECT IF class1=0.

SORT CASES BY draw.
* Number cases and calculate number of cases.
COMPUTE nb=$casenum.
RANK draw /n INTO n.

* In next line, change the number 10 by the number you need.
COMPUTE #delta=n/(10-.0001).

* balance of paragraph finds the cut off points.
COMPUTE flag=TRUNC(nb/#delta).
AGGREGATE
  /OUTFILE=*
  /BREAK=flag
  /cut_off = FIRST(draw).

* prepare cut off points data for merger with main data file.
FLIP
  VARIABLES=cut_off.
COMPUTE dummy=1.
SAVE OUTFILE='cutoff points.sav'.

*add cut_off points to original data file.
GET FILE='temp.sav'.
MATCH FILES /FILE=*
 /TABLE='C:\Program Files\SPSS\cutoff points.sav'
 /BY dummy.

DEFINE !rank_it (vname=!TOKENS(1)
		/nb_bins=!TOKENS(1))
VECTOR cutoff=var001 TO !CONCAT('var',!nb_bins).
COMPUTE rank1=1.
LOOP #cnt=2 TO !nb_bins.
COMPUTE rank1=rank1 + (!vname>cutoff(#cnt)).
END LOOP.
EXECUTE.
!ENDDEFINE.