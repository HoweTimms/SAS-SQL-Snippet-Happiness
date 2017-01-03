GET
 FILE='D:\My Documents\Risk\Projects\TPD\Bmouth\tpd_ht_b Ap Client and Address Only File.sav'.


STRING str1 TO str4(A20) /namep1 to namep4(A20).
STRING ClientName(A48).

* Identify Cases that are just blank

COMPUTE pos1 = 0.
EXECUTE.

LOOP cnt = 1 to 48.
DO IF SUBSTR(Borrower_Name_01,cnt,1) = ' '.
COMPUTE pos1 = pos1 + 1.
END IF.
END LOOP.
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF(pos1 < 48).
EXECUTE .

* Identify Cases that start with a space


COMPUTE pos1 =  INDEX(RTRIM(Borrower_Name_01),' ').
EXECUTE.

DO IF pos1 =1.
COMPUTE ClientName = Substr(Borrower_Name_01,pos1+1).
ELSE.
COMPUTE ClientName = Borrower_Name_01.
END IF.
EXECUTE.

* name up to first gap
COMPUTE pos1 =  INDEX(RTRIM(ClientName),' ').
EXECUTE.


DO IF pos1 < Len(RTRIM(ClientName)).
COMPUTE str1=SUBSTR(ClientName,1,INDEX(ClientName,' ')-1).
ELSE.
COMPUTE str1='INVALID'.
END IF.
EXECUTE.

* Get last section of name

COMPUTE str3 = SUBSTR(ClientName,RINDEX(RTRIM(ClientName),' ')+1).

* Test to see if there is a second section and pull in raw first name

DO IF (INDEX(ClientName,' ')+1 <= (RINDEX(RTRIM(ClientName),' ') - INDEX(RTRIM(ClientName),' ')-1)).
COMPUTE str2=SUBSTR(ClientName,INDEX(ClientName,' ')+1,RINDEX(RTRIM(ClientName),' ')-INDEX(RTRIM(ClientName),' ')-1).
ELSE.
COMPUTE str2='TestFalse'.
END IF.
EXECUTE.

COMPUTE pos1 = INDEX(RTRIM(str2),' ').
EXECUTE.

DO IF pos1 < LEN(RTRIM(str2)) AND pos1 > 0 AND RTRIM(str2) <> 'TestFalse'.
COMPUTE str4 = SUBSTR(str2,pos1+1).
COMPUTE str2 = SUBSTR(str2,1,pos1-1).
END IF.
EXECUTE.

* Ensure Middle Name has not become associated with Surname

DO IF Len(RTRIM(str4)) >0.
COMPUTE pos1 = INDEX(RTRIM(str4),' ').
END IF.
EXECUTE.

DO IF (pos1 > 0 & pos1 < LEN(RTRIM(str4))).
COMPUTE str4 = SUBSTR(str4,1,pos1).
ELSE.
COMPUTE str4 = str4.
END IF.
EXECUTE. 


* Set Out Trimmed Names

COMPUTE namep1 = RTRIM(Title_Borrow_02).
COMPUTE namep2 = RTRIM(str1).
EXE.

DO IF SUBSTR(str4,1,1) ~= ' '.
	COMPUTE namep4 = RTRIM(str4).
ELSE. 
	COMPUTE namep4 = RTRIM(str3).
END IF.
EXE.

IF str2 ~= 'TestFalse' namep3 = str2.
EXE.

EXECUTE.

STRING Valid (A2).
EXECUTE.

RECODE
  namep4
  ('                    '='0')  (ELSE='1')  INTO  Valid .
VARIABLE LABELS Valid 'Valid Client Name Ind'.
EXECUTE .

FREQUENCIES
  VARIABLES=Valid
  /ORDER=  ANALYSIS .


SAVE OUTFILE='D:\My Documents\Risk\Projects\TPD\Bmouth\tpd_ht_b Ap Client 01.sav'
 /COMPRESSED.



GET
 FILE='D:\My Documents\Risk\Projects\TPD\Bmouth\tpd_ht_b Ap Client and Address Only File.sav'.


STRING str1 TO str4(A20) /namep1 to namep4(A20).
STRING ClientName(A48).

* Identify Cases that are just blank

COMPUTE pos1 = 0.
EXECUTE.

LOOP cnt = 1 to 48.
DO IF SUBSTR(Borrower_Name_02,cnt,1) = ' '.
COMPUTE pos1 = pos1 + 1.
END IF.
END LOOP.
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF(pos1 < 48).
EXECUTE .

* Identify Cases that start with a space


COMPUTE pos1 =  INDEX(RTRIM(Borrower_Name_02),' ').
EXECUTE.

DO IF pos1 =1.
COMPUTE ClientName = Substr(Borrower_Name_02,pos1+1).
ELSE.
COMPUTE ClientName = Borrower_Name_02.
END IF.
EXECUTE.

* name up to first gap
COMPUTE pos1 =  INDEX(RTRIM(ClientName),' ').
EXECUTE.


DO IF pos1 < Len(RTRIM(ClientName)).
COMPUTE str1=SUBSTR(ClientName,1,INDEX(ClientName,' ')-1).
ELSE.
COMPUTE str1='INVALID'.
END IF.
EXECUTE.

* Get last section of name

COMPUTE str3 = SUBSTR(ClientName,RINDEX(RTRIM(ClientName),' ')+1).

* Test to see if there is a second section and pull in raw first name

DO IF (INDEX(ClientName,' ')+1 <= (RINDEX(RTRIM(ClientName),' ') - INDEX(RTRIM(ClientName),' ')-1)).
COMPUTE str2=SUBSTR(ClientName,INDEX(ClientName,' ')+1,RINDEX(RTRIM(ClientName),' ')-INDEX(RTRIM(ClientName),' ')-1).
ELSE.
COMPUTE str2='TestFalse'.
END IF.
EXECUTE.

COMPUTE pos1 = INDEX(RTRIM(str2),' ').
EXECUTE.

DO IF pos1 < LEN(RTRIM(str2)) AND pos1 > 0 AND RTRIM(str2) <> 'TestFalse'.
COMPUTE str4 = SUBSTR(str2,pos1+1).
COMPUTE str2 = SUBSTR(str2,1,pos1-1).
END IF.
EXECUTE.

* Ensure Middle Name has not become associated with Surname

DO IF Len(RTRIM(str4)) >0.
COMPUTE pos1 = INDEX(RTRIM(str4),' ').
END IF.
EXECUTE.

DO IF (pos1 > 0 & pos1 < LEN(RTRIM(str4))).
COMPUTE str4 = SUBSTR(str4,1,pos1).
ELSE.
COMPUTE str4 = str4.
END IF.
EXECUTE. 


* Set Out Trimmed Names

COMPUTE namep1 = RTRIM(Title_Borrow_03).
COMPUTE namep2 = RTRIM(str1).
EXE.

DO IF SUBSTR(str4,1,1) ~= ' '.
	COMPUTE namep4 = RTRIM(str4).
ELSE. 
	COMPUTE namep4 = RTRIM(str3).
END IF.
EXE.

IF str2 ~= 'TestFalse' namep3 = str2.
EXE.

EXECUTE.

STRING Valid (A2).
EXECUTE.

RECODE
  namep4
  ('                    '='0')  (ELSE='1')  INTO  Valid .
VARIABLE LABELS Valid 'Valid Client Name Ind'.
EXECUTE .

FREQUENCIES
  VARIABLES=Valid
  /ORDER=  ANALYSIS .


SAVE OUTFILE='D:\My Documents\Risk\Projects\TPD\Bmouth\tpd_ht_b Ap Client 02.sav'
 /COMPRESSED.
