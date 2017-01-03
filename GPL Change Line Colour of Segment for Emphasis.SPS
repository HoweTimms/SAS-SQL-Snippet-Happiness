/* Change colour of line segment for emphasis */.

GET
  FILE='C:\Program Files\SPSS\Tutorial\sample_files\stocks2004.sav'.
IF (XDATE.MONTH(Date)=11) close2 = close .
EXECUTE .
* Chart Builder.
GGRAPH
 /GRAPHDATASET NAME="graphdataset" VARIABLES=Date MEAN(close2)[rename=
  "MEAN_close2"] MEAN(Close)[rename="MEAN_Close"] MISSING=VARIABLEWISE
 /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
 SOURCE: s=userSource(id("graphdataset"))
 DATA: Date=col(source(s), name("Date"))
 DATA: MEAN_Close=col(source(s), name("MEAN_Close"))
 DATA: MEAN_close2=col(source(s), name("MEAN_close2"))
 GUIDE: axis(dim(1), label("Date"))
 GUIDE: axis(dim(2), label("Mean close2"))
 ELEMENT: line(position(Date*MEAN_Close), missing.wings(), color(color.red) )
 ELEMENT: line(position(Date*MEAN_close2), missing.wings(), color(color.blue) )
END GPL.
