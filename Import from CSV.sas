PROC IMPORT OUT= NR001.Arrears 
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Ris
k\NR001\Data\CSV\Arrears NR001.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
