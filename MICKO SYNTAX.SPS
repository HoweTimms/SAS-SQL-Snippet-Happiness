GET
  FILE='C:\Program Files\SPSSEval\Employee data.sav'.
DATASET NAME DataSet16 WINDOW=FRONT.


COMPUTE newcol = prevexp + jobtime + educ.
EXE.

FREQUENCIES
  VARIABLES=newcol
  /BARCHART  FREQ
  /ORDER=  ANALYSIS .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER newcol
  /SCATTERPLOT=(salary ,*ZRESID ) .

COMPUTE Predicted = 36639.141 +  (-11.654*Newcol).
EXE.

GRAPH
  /SCATTERPLOT(OVERLAY)= newcol newcol WITH salary Predicted (PAIR)
  /MISSING=LISTWISE .

*/sort of works... ish :0\ .../*


GET
  FILE='C:\Program Files\SPSSEval\sales.sav'.
DATASET NAME DataSet20 WINDOW=FRONT.


FREQUENCIES
  VARIABLES=revenue industry
  /BARCHART  FREQ
  /ORDER=  ANALYSIS .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT revenue
  /METHOD=ENTER industry
  /SCATTERPLOT=(revenue ,*ZRESID ) .

Compute Predicted = 2497.331 + (9.689 * Industry).
EXE.

GRAPH
  /SCATTERPLOT(OVERLAY)= industry industry WITH revenue Predicted (PAIR)
  /MISSING=LISTWISE .

*/ish.../*


GET
  FILE='C:\Program Files\SPSSEval\Cars.sav'.
DATASET NAME DataSet22 WINDOW=FRONT.


FREQUENCIES
  VARIABLES=cylinder accel horse
  /BARCHART  FREQ
  /ORDER=  ANALYSIS .


REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT accel
  /METHOD=ENTER cylinder
  /SCATTERPLOT=(accel ,*ZRESID ) .


COMPUTE Predicted = 20.251 + (-0.866 * Cylinder).
EXE.


GRAPH
  /SCATTERPLOT(OVERLAY)= cylinder cylinder  WITH accel Predicted (PAIR)
  /MISSING=LISTWISE .

