
GET FILE 'C:\Cassini\Data\BASEL\Mod\DCM_200209.sav'.

NUMERIC OUTFINE(F8.2).
NUMERIC TEMPC(F8.2).


COMPUTE OUTFINE = Fine200209.
EXECUTE.

VECTOR Vp = Fine200209 TO Fine200309.

LOOP #i = 1 TO 12.

IF (SYSMIS( Vp(#i) )  ~= 1) TEMPC = Vp(#i) .
IF (SYSMIS( Vp(#i) )  = 1) TEMPC = 1 .

DO IF TEMPC > OUTFINE.
	COMPUTE OUTFINE = TEMPC.
END IF.

END LOOP.
EXECUTE.

DO IF ( (SYSMIS(Fine200309) = 1) and OUTFINE = 3).
	COMPUTE OUTFINE = 4.
END IF.

DELETE VARIABLES TEMPC.





GET FILE 'C:\Cassini\Data\BASEL\Mod\DCM_200209.sav'.

NUMERIC OUTFINE(F8.2).
NUMERIC TEMPC(F8.2).


COMPUTE OUTFINE = Fine200209.
EXECUTE.

VECTOR Vp = Fine200209 TO Fine200309.

LOOP #i = 1 TO 12.

IF (SYSMIS( Vp(#i) )  ~= 1) TEMPC = Vp(#i) .
IF (SYSMIS( Vp(#i) )  = 1) TEMPC = 1 .

DO IF TEMPC > OUTFINE.
	COMPUTE OUTFINE = TEMPC.
END IF.

END LOOP.
EXECUTE.

DO IF ( (SYSMIS(Fine200309) = 1) and OUTFINE = 3).
	COMPUTE OUTFINE = 4.
END IF.

DELETE VARIABLES TEMPC.



