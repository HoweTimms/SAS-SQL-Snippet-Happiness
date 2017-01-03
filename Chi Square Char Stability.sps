GET DATA
 /TYPE=ODBC
 /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00838;DATABASE=risk;Trusted_Connection=Yes'
 /SQL =
" SELECT Maturity "
"  ,  Factor "
"  ,  Factor_Value "
"  ,  Sum(Obs) as Obs "
"  FROM  Characteristic_Stability "
"  WHERE Factor = 'sAge_At_Default' "
"  GROUP BY "
"  Maturity "
"  ,  Factor "
"  ,  Factor_Value "
"  ORDER BY "
"  Maturity "
"  ,  Factor "
"  ,  Factor_Value "
 /ASSUMEDSTRWIDTH=255.
CACHE.
EXE.

WEIGHT BY Obs.

SORT CASES BY Maturity .
SPLIT FILE
  SEPARATE BY Maturity .

NPAR TEST
  /CHISQUARE=Factor_Value
  /EXPECTED=12.7 32.6 16.2 28.4 10.1
  /MISSING ANALYSIS.

SELECT IF Maturity <= 10.
EXE.

* Chart Builder.
GGRAPH
 /GRAPHDATASET NAME="graphdataset" VARIABLES=Factor_Value COUNT()[name=
 "COUNT"] Maturity[LEVEL=ORDINAL] MISSING=LISTWISE REPORTMISSING=NO
 /GRAPHSPEC SOURCE=INLINE.
 BEGIN GPL
 SOURCE: s=userSource(id("graphdataset"))
 DATA: Factor_Value=col(source(s), name("Factor_Value"), unit.category())
 DATA: COUNT=col(source(s), name("COUNT"))
 DATA: Maturity=col(source(s), name("Maturity"), unit.category())
 GUIDE: axis(dim(1), label("Factor_Value"))
 GUIDE: axis(dim(2), label("Percent"))
 GUIDE: axis(dim(4), label("Maturity"), opposite())
 SCALE: cat(dim(1))
 SCALE: linear(dim(2), include(0))
 SCALE: cat(dim(4))
 ELEMENT: interval(position(summary.percent(Factor_Value*COUNT*1*Maturity,
 base.all(acrossPanels()))), shape.interior(shape.square))
 END GPL.


* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Factor_Value COUNT()[name=
  "COUNT"] Maturity[LEVEL=ORDINAL] MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
 SOURCE: s=userSource(id("graphdataset"))
 DATA: Factor_Value=col(source(s), name("Factor_Value"), unit.category())
 DATA: COUNT=col(source(s), name("COUNT"))
 DATA: Maturity=col(source(s), name("Maturity"), unit.category())
 GUIDE: axis(dim(1), label("Factor_Value"))
 GUIDE: axis(dim(2), label("Percent"))
 GUIDE: axis(dim(4), label("Maturity"), opposite())
 SCALE: cat(dim(1))
 SCALE: linear(dim(2), include(0))
 SCALE: cat(dim(4))
 ELEMENT: interval(position(summary.percent(Factor_Value*COUNT*1*Maturity,
   base.all())), shape.interior(shape.square))
END GPL.
