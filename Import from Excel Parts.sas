PROC IMPORT OUT= NR001.SAS_002_2 
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Ris
k\NR001\Data\Excel\SAS Prep\SAS_002.xls" 
            DBMS=EXCEL REPLACE;
     SHEET="Main_1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
