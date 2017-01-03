*  http://pages.infinit.net/rlevesqu/Syntax/WorkingWithManyFiles/RunMacroOnSeveralFiles.txt
* How can run the same macro on several different files?
* Answer by Ray.
* This macro gets the data files; 


DEFINE !GETIT ().

!DO !var=200301 !TO 200311.

GET DATA
	/TYPE = ODBC
	/CONNECT= 'DSN=scukcaxd;UID=htimms;PWD=ABC123'
/UNENCRYPTED
/SQL=
!QUOTE(!CONCAT("SELECT * FROM REORG.Howe_Timms.DCM_Perform",!var)).


SAVE OUTFILE=!QUOTE(!CONCAT("C:\Cassini\Data\BASEL\Perform",!var,".sav"))
 /COMPRESSED.


!DOEND.


!ENDDEFINE.



!GETIT.


