
GET DATA /TYPE=XLS
 /FILE='C:\Documents and Settings\htimms\My Documents\audits.xls'
 /SHEET=name 'Sheet1'
 /CELLRANGE=RANGE 'A1:A20864'
 /READNAMES=on
 /ASSUMEDSTRWIDTH=32767.

COMPUTE LEN = LENGTH(RTRIM(CLEANEDRECORDS)). 
EXE.

FREQUENCIES
  VARIABLES=LEN  /FORMAT=NOTABLE
  /STATISTICS=MINIMUM MAXIMUM
  /BARCHART  FREQ
  /ORDER=  ANALYSIS .

STRING Trim(A126).
EXE.
LOOP #cnt = 1 to  LENGTH(RTRIM(CLEANEDRECORDS)). 
DO IF SUBSTR(CLEANEDRECORDS,#cnt,1) = 'S'  & RANGE(SUBSTR(CLEANEDRECORDS,#cnt+1,1),'0','9') > 0.
	COMPUTE Trim= SUBSTR(CLEANEDRECORDS,#cnt).
	COMPUTE RefPos = #cnt.
END IF.
END LOOP.
EXE.

* Trim Blanks *.

IF LENGTH(RTRIM(Trim)) > 1 Trim = RTRIM(LTRIM(Trim)).
EXE.

LOOP IF INDEX(Trim,' ')>0 & ( INDEX(Trim,' ') < LENGTH(RTRIM(Trim)) ) .
	COMPUTE #I = INDEX(Trim,' ') .
	COMPUTE Trim=CONCAT(SUBSTR(Trim,1,#I-1),SUBSTR(Trim,#I+1)).
END LOOP .
EXE.

* Extract S C and P *.

STRING S(A2).
LOOP #cnt = 1 to  LENGTH(RTRIM(Trim)). 
DO IF SUBSTR(Trim,#cnt,1) = 'S'  & RANGE(SUBSTR(Trim,#cnt+1,1),'0','9') > 0.
	COMPUTE S= SUBSTR(Trim,#cnt,#cnt+1).
END IF.
END LOOP.
EXE.

STRING C(A2).
LOOP #cnt = 1 to  LENGTH(RTRIM(Trim)). 
DO IF SUBSTR(Trim,#cnt,1) = 'C'  & RANGE(SUBSTR(Trim,#cnt+1,1),'0','9') > 0.
	COMPUTE C= SUBSTR(Trim,#cnt,#cnt+1).
END IF.
END LOOP.
EXE.

STRING P(A2).
LOOP #cnt = 1 to  LENGTH(RTRIM(Trim)). 
DO IF SUBSTR(Trim,#cnt,1) = 'P'  & RANGE(SUBSTR(Trim,#cnt+1,1),'0','9') > 0.
	COMPUTE P= SUBSTR(Trim,#cnt,#cnt+1).
END IF.
END LOOP.
EXE.

* Frequncy tables to ensure the extract worked (Which it does - of course) *.

FREQUENCIES
  VARIABLES=S C P
  /ORDER=  ANALYSIS .

STRING Name(A192).

IF RefPos > 0 Name =SUBSTR(CLEANEDRECORDS,RINDEX(CLEANEDRECORDS,'\')+1,RefPos-RINDEX(CLEANEDRECORDS,'\')-2).
EXE.


LOOP #cnt = 1 to  LENGTH(RTRIM(Name)). 
DO IF SUBSTR(Name,#cnt,1) = ' '  & RANGE(SUBSTR(Name,#cnt+1,1),'0','9') > 0.
	COMPUTE Name= SUBSTR(Name,1,#cnt-1).
END IF.
END LOOP.
EXE.


*  Optional trim any chars after occurance of number 5 chars in *.
LOOP #cnt = 5 to  LENGTH(RTRIM(Name)). 
DO IF RANGE(SUBSTR(Name,#cnt,1),'0','9') > 0.
	COMPUTE Name= SUBSTR(Name,1,#cnt-1).
END IF.
END LOOP.
EXE.

* Optional remove '(' at end of char *.
DO IF SUBSTR(Name,LENGTH(RTRIM(Name)),1) = ')'
	COMPUTE Name= SUBSTR(Name,1,LENGTH(RTRIM(Name))-1).
END IF.
EXE.
