*  http://pages.infinit.net/rlevesqu/Syntax/WorkingWithManyFiles/RunMacroOnSeveralFiles.txt
* How can run the same macro on several different files?
* Answer by Ray.
* This macro gets the data files; 


DEFINE !GETIT ().

!DO !var=1 !TO 18.

GET DATA
	/TYPE = ODBC
	/CONNECT= 'DSN=scukcaxd;UID=htimms;PWD=ABC123'
/UNENCRYPTED
/SQL=
!QUOTE(!CONCAT("SELECT * FROM RISK_TEMP.Howe_Timms.Bmouth_Perform_",!var)).

SAVE OUTFILE=!QUOTE(!CONCAT("\\Cwlchow37960\burner\TPD\Bmouth_Perform_",!var,".sav"))
 /COMPRESSED.

!DOEND.

!ENDDEFINE.

!GETIT.
