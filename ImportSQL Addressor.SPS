

GET DATA
	/TYPE = ODBC
	/CONNECT= 'DSN=scukcaxd;UID=htimms;PWD=ABC123'
/UNENCRYPTED
/SQL=
'SELECT * FROM REORG.Howe_Timms.DCM_Addressor'.


SAVE OUTFILE='Z:\Cassini\Data\Basel\DCM_Addressor'
/COMPRESSED.
