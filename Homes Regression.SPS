GET
 FILE='C:\My Documents\Risk\Homes.sav'.
DATASET NAME Homes WINDOW=FRONT.


USE ALL.
COMPUTE filter_$=((AreaCode=4 & Price < 150000) And (AreaCode=4 & SqFt < 1800)).
VARIABLE LABEL filter_$ 'AreaCode=4 & (Price  <= 150000 And SqFt <= 1800)'+
 ' (FILTER)'.
VALUE LABELS filter_$  0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE .

FREQUENCIES
  VARIABLES=Price Bedrooms AreaCode SqFt
  /BARCHART  FREQ
  /ORDER=  ANALYSIS .

/**********************************************************************************/.
/**********************************************************************************/.
/******************            Initial Regression		****************/.
/**********************************************************************************/.
/**********************************************************************************/.
/**********************************************************************************/.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Price
  /METHOD=ENTER SqFt
  /SCATTERPLOT=(Price ,*ZRESID ) .

/*  Price = 45298 + 34.32 SqFt */.

COMPUTE Predicted = 45298 + (34.32* SqFt ).
EXE.

GRAPH
  /SCATTERPLOT(OVERLAY)=SqFt SqFt  WITH Price Predicted (PAIR)
  /MISSING=LISTWISE .

/**********************************************************************************/.
/**********************************************************************************/.
/******************            Quadratic Regression		****************/.
/**********************************************************************************/.
/**********************************************************************************/.
/**********************************************************************************/.

COMPUTE SqFt2 = SqFt**2.
EXE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Price
  /METHOD=ENTER SqFt SqFt2
  /SCATTERPLOT=(Price ,*ZRESID ) .


/*  Collinearity observed between SqFt and SqFt2 */.

GRAPH
  /SCATTERPLOT(BIVAR)=SqFt2 WITH SqFt
  /MISSING=LISTWISE .

CORRELATIONS
  /VARIABLES=SqFt SqFt2
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
NONPAR CORR
  /VARIABLES=SqFt SqFt2
  /PRINT=SPEARMAN ONETAIL NOSIG
  /MISSING=PAIRWISE .

/* Rubbish that idea SqFt2 is rejected */.

/**********************************************************************************/.
/**********************************************************************************/.
/******************  Categorical Explanatory Variables	****************/.
/**********************************************************************************/.
/**********************************************************************************/.
/**********************************************************************************/.

GRAPH
  /SCATTERPLOT(BIVAR)=Bedrooms WITH Price
  /MISSING=LISTWISE .

RECODE
  Bedrooms
  (1=0)  (2=0)  (3=1)  (4=1)  INTO  Bed_Cat .
VARIABLE LABELS Bed_Cat 'Bedrooms Cat'.
EXECUTE .

GRAPH
  /SCATTERPLOT(BIVAR)=Bed_Cat WITH Price
  /MISSING=LISTWISE .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Price
  /METHOD=ENTER Bed_Cat  .

/*  Price = 75700 + 15146 Bed_Cat */.

GRAPH
  /SCATTERPLOT(BIVAR)=Baths WITH Price
  /MISSING=LISTWISE .

COMPUTE Baths1 = 0.
COMPUTE Baths15 = 0.
COMPUTE Baths2 = 0.
COMPUTE Baths25 = 0.
EXE.

IF Baths = 1.5 Baths15 = 1.
IF Baths = 2 Baths2 = 1.
IF Baths = 2.5 Baths25 = 1.
IF (Baths15 + Baths2 + Baths25 = 0) Baths1 =1.
EXE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Price
  /METHOD=ENTER Baths15 Baths2 Baths25  .

/*  Price = 77504 + 20533 Baths15 + 12616 Baths2 + 44896 Baths25 */.
/*  Implies that baths are significant and contribute, however we have very little evidence for 2.5 baths */

Compute BathHalf = 0.
Compute BathFull = 0.
EXE.

/* Recode of Bath, Extra Half Bath vs Extra Full Bath */

IF Any(Baths / 0.5,3,5) BathHalf = 1.
IF Baths/ 0.5 >= 4 BathFull =1.
EXE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Price
  /METHOD=ENTER BathHalf BathFull.

/*  Price = 76929 + 23018 BathHalf + 15837 BathFull */.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Price
  /METHOD=ENTER SqFt Bed_Cat BathHalf BathFull.

/* Bed_Cat now is not significant so is removed and regression re done */.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Price
  /METHOD=ENTER SqFt BathHalf BathFull.

/* Price = 59268 + 16.78 SqFt + 16859 BathHalf + 13161 BathFull */



COMPUTE Predicted = 59268 + (16.78 * SqFt) + (16859 * BathHalf) + (13161 * BathFull ).
EXE.

GRAPH
  /SCATTERPLOT(OVERLAY)=ID ID  WITH Price Predicted (PAIR)
  /MISSING=LISTWISE .


/* Interaction analysis */
Compute SqFtBathHalf = SqFt * BathHalf.
EXE.


REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Price
  /METHOD=ENTER SqFt BathHalf SqFtBathHalf .

GRAPH
  /SCATTERPLOT(BIVAR)=SqFt WITH Price BY BathHalf
  /MISSING=LISTWISE .
