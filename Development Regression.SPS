********DEVELOPMENT REGRESSION SCRIPT***********.

******Note - remember to amend apprate & badrate according to current dev sample*******.

GET
  FILE='g:\mip\creditc\nick\retail\Accepts.sav'.
compute x = 1.
ADD FILES /FILE=*
/FILE='g:\mip\creditc\nick\retail\rejects.sav'.
recode x (sysmis = 0).
recode gbrflag(sysmis = 50).

compute gb = gbrflag.
COMPUTE Z1 = 1.
COMPUTE Z2 = 1.


compute apprate = 84.1.           /* Ave. App. rate (%)of the sample window
compute badrate = 3.1.           /* Ave Bad rate (%)  of the sample window
execute.

*************************************************************************.

COMPUTE WTFCT = 1.
compute noofcur1 = 0.
compute noofbad1 = 0.
compute noofrej1 = 0.
IF ( GB = 200) NOOFCUR1 = 1.
IF ( GB = 100) NOOFBAD1 = 1.
IF ( GB =  50) NOOFrej1 = 1.
AGGREGATE
  /OUTFILE='g:\mip\creditc\nick\retail\AGGR.SAV'
  /BREAK=wtfct
  /NOOFBAD = SUM(NOOFBAD1) /NOOFCUR = SUM(NOOFCUR1) /NOOFrej = SUM(NOOFrej1).
MATCH FILES /FILE=*
 /TABLE='g:\mip\creditc\nick\retail\AGGR.sav'
 /BY wtfct.

compute factor  = 1500/noofbad. /* The factor to weight the sample to 1500
execute.

***************************************************************.
* Re - create TTD.
***************************************************************.

if (gb    =  200 ) wtfct =APPRATE*(100 - BADRATE)/NOOFCUR.
if (gb    =  100 ) wtfct =APPRATE*BADRATE/NOOFBAD.
if (gb    =   50 ) wtfct =(100 - APPRATE)*100/(NOOFREJ).

************************************************************************.

** First Regression Analysis **.

compute wtfct = 1.
if (GB = 200) wtfct = noofbad/noofcur.
compute wtfct = wtfct*factor.
weight by wtfct.

reg vars=GB z1 to z2 
 /select GB ge 100
 /MISSING LISTWISE
 /CRITERIA=FIN(2.5) FOUT(2.00)
 /sta f end
 /dep=GB
 /method=step dnage1 dnage2 dnage3 dnage4 dnage5 dnage6 dnage7 dnage8 dnage9 dnage10
  dnage11 dnres1 dnres2 dnres3
  dntel1 dntel2 dntemp1 dntemp2 dntemp3 dntemp4 dnemps1 dnemps2 dnvade0
  dnvade1 dnvade2 dncheq0 dncheq1 dndef0 dndef1 dntwb0 dntwb1 dntwb2 dntwb3 
 /method = enter    dndel1 dndel2 dndel3 dndel4 dndel5 dndel6 
 /save=pred(score).

compute score1=trunc(score).
execute.

****************************************************************.

weight off.

temporary.
select if ( gb >= 100).

if (GB = 200) we =apprate*(100 - badrate)/NOOFCUR.
if (GB = 100) we =apprate*badrate/noofbad.
weight by we.

aggregate outfile='g:\mip\creditc\nick\retail\rejwtfac.sav'
 /break=score1
 /pbad=flt(GB,150).

temporary.
select if (GB >= 100).
save outfile ='g:\mip\creditc\nick\retail\accept.sav'.

select if (GB = 50).

string infer (a1).
compute infer='B'.
save outfile='g:\mip\creditc\nick\retail\rejb.sav'.
compute infer='G'.
save outfile='g:\mip\creditc\nick\retail\rejg.sav'.

add files file='g:\mip\creditc\nick\retail\accept.sav'
        / file='g:\mip\creditc\nick\retail\rejb.sav'
        / file='g:\mip\creditc\nick\retail\rejg.sav'.

sort cases by score1.
save outfile='g:\mip\creditc\nick\retail\check.sav'.
INCLUDE FILE='g:\mip\creditc\nick\retail\reject_inference.SPS'.
EXECUTE.
get file='g:\mip\creditc\nick\retail\check.sav'.
match files file=* / table='g:\mip\creditc\nick\retail\rejwtfac.sav' / by score1.
execute.

recode pbad (missing=0.99999)(1=0.99999)(0=0.00001).
compute wtfct=1.

if (GB = 200) wtfct = apprate*(100 - badrate)/noofcur.
if (GB = 100) wtfct = apprate*badrate/noofbad.
if (GB = 50 ) wtfct = (100 - APPRATE)*100/noofrej.

weight by wtfct.
if (infer='G') wtfct=wtfct*(1-pbad).
if (infer='B') wtfct=wtfct*(pbad).
if (GB =  200) infer='G'.
if (GB =  100) infer='B'.
if (infer='G') iGB= 200.
if (infer='B') iGB= 100.


CROSSTABS
  /TABLES=GB BY iGB
  /FORMAT= AVALUE NOINDEX BOX LABELS TABLES
  /CELLS= COUNT COLUMN .
execute.
weight off.

compute wtfct1 = 1.
compute infbad1 = 0.
compute infcur1 = 0.
if (igb = 100) infbad1 = wtfct.
if (igb = 200) infcur1 = wtfct.
AGGREGATE
  /OUTFILE='g:\mip\creditc\nick\retail\AGGR1.SAV'
  /BREAK=wtfct1
  /infBAD = SUM(infbad1) /infCUR = SUM(infCUR1).
MATCH FILES /FILE=*
 /TABLE='g:\mip\creditc\nick\retail\AGGR1.sav'
 /BY wtfct1.


if (iGB = 200) wtfct=wtfct*infbad/infcur.
compute factor2 = 1500/infbad.
compute wtfct=wtfct*factor2.

WEIGHT BY WTFCT.


CROSSTABS
  /TABLES=GB BY iGB
  /FORMAT= AVALUE NOINDEX BOX LABELS TABLES
  /CELLS= COUNT COLUMN ROW.


WEIGHT BY WTFCT.

** Second Regression Analysis **

reg vars=iGB z1 to z2
 /select iGB ge 100
 /MISSING LISTWISE
 /CRITERIA=FIN(2.5) FOUT(2.00)
 /sta f end
 /dep=iGB
 /method=step dnage1 dnage2 dnage3 dnage4 dnage5 dnage6 dnage7 dnage8 dnage9 dnage10
  dnage11 dnres1 dnres2 dnres3
  dntel1 dntel2 dntemp1 dntemp2 dntemp3 dntemp4 dnemps1 dnemps2 dnvade0
  dnvade1 dnvade2 dncheq0 dncheq1 dndef0 dndef1 dntwb0 dntwb1 dntwb2 dntwb3 
 /method = enter    dndel1 dndel2 dndel3 dndel4 dndel5 dndel6 
 /save=pred(score2).

compute fscore=trunc(score2/10)*10.
execute.

SAVE OUTFILE='g:\mip\creditc\nick\retail\temptab.sav'
   /COMPRESSED.

*COMPUTE SCORE2 = SCORE.
*COMPUTE GB = GBIND2.
INCLUDE FILE='g:\mip\creditc\nick\retail\gini_calculation.SPS'.
.
