PROC IMPORT OUT= NR001.SAS_001 
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Ris
k\NR001\Data\Excel\SAS_001.xls" 
            DBMS=EXCEL REPLACE;
     SHEET="Main$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
