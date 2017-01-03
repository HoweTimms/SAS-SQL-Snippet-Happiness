libname NR001 'C:\Documents and Settings\htimms\My Documents\Risk\NR001\Data\SAS\' ;

* dec 2002.xls;

PROC IMPORT OUT= NR001.SAS_001_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\dec 2002.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


* JAN TO APR 2004.xls;
PROC IMPORT OUT= NR001.SAS_002_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\JAN TO APR 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* JAN TO APR 2004.xls;
PROC IMPORT OUT= NR001.SAS_002_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\JAN TO APR 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* JAN TO APR 2004.xls;
PROC IMPORT OUT= NR001.SAS_002_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\JAN TO APR 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


* jan to april 03.xls;
PROC IMPORT OUT= NR001.SAS_003_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\jan to april 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* jan to april 03.xls;
PROC IMPORT OUT= NR001.SAS_003_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\jan to april 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* jan to april 03.xls;
PROC IMPORT OUT= NR001.SAS_003_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\jan to april 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;



* may to aug 03.xls;
PROC IMPORT OUT= NR001.SAS_004_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* may to aug 03.xls;
PROC IMPORT OUT= NR001.SAS_004_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* may to aug 03.xls;
PROC IMPORT OUT= NR001.SAS_004_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;



* may to aug 04.xls;
PROC IMPORT OUT= NR001.SAS_005_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 04.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* may to aug 04.xls;
PROC IMPORT OUT= NR001.SAS_005_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 04.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* may to aug 04.xls;
PROC IMPORT OUT= NR001.SAS_005_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 04.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;



* may to aug 2004.xls;
PROC IMPORT OUT= NR001.SAS_006_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* may to aug 2004.xls;
PROC IMPORT OUT= NR001.SAS_006_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* may to aug 2004.xls;
PROC IMPORT OUT= NR001.SAS_006_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
*  Need to add Paramater Date X ;
* nov 2002.XLS.xls;
PROC IMPORT OUT= NR001.SAS_007_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\nov 2002.XLS.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* nov 2002.XLS.xls;
PROC IMPORT OUT= NR001.SAS_007_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\nov 2002.XLS.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* nov 2002.XLS.xls;
PROC IMPORT OUT= NR001.SAS_007_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\nov 2002.XLS.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
*  Need to add Paramater Date X ;
* OCT 2002.XLS.xls;
PROC IMPORT OUT= NR001.SAS_008_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\OCT 2002.XLS.xls"
           	DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* OCT 2002.XLS.xls;
PROC IMPORT OUT= NR001.SAS_008_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\OCT 2002.XLS.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* OCT 2002.XLS.xls;
PROC IMPORT OUT= NR001.SAS_008_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\OCT 2002.XLS.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* sept to dec 2003.xls;
PROC IMPORT OUT= NR001.SAS_009_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sept to dec 2003.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* sept to dec 2003.xls;
PROC IMPORT OUT= NR001.SAS_009_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sept to dec 2003.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* sept to dec 2003.xls;
PROC IMPORT OUT= NR001.SAS_009_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sept to dec 2003.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


* sept to dec 2004.xls;
PROC IMPORT OUT= NR001.SAS_010_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sep to dec 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* sept to dec 2004.xls;
PROC IMPORT OUT= NR001.SAS_010_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sep to dec 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

* sept to dec 2004.xls;
PROC IMPORT OUT= NR001.SAS_010_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sep to dec 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


**** Trim tables down to remove irritating variables (ONLY clean those if we have to) ;

data NR001.Sas_Trim_1;
	Set NR001.Sas_001_1
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
	attrib Parameter_Date format = date9. informat = date9.;
	Parameter_Date = MDY(12,01,2002);
run;

data NR001.Sas_Trim_2;
	Set NR001.Sas_002_1
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_3;
	Set NR001.Sas_002_2
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_4;
	Set NR001.Sas_002_3
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_5;
	Set NR001.Sas_003_1
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_6;
	Set NR001.Sas_003_2
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_7;
	Set NR001.Sas_003_3
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_8;
	Set NR001.Sas_004_1
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_9;
	Set NR001.Sas_004_2
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_10;
	Set NR001.Sas_004_3
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_11;
	Set NR001.Sas_006_1
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_12;
	Set NR001.Sas_006_2
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_13;
	Set NR001.Sas_006_3
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_14;
	Set NR001.Sas_007_1
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
	attrib Parameter_Date format = date9. informat = date9.;
	Parameter_Date = MDY(11,01,2002);
run;

data NR001.Sas_Trim_15;
	Set NR001.Sas_008_1
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
	attrib Parameter_Date format = date9. informat = date9.;
	Parameter_Date = MDY(10,01,2002);
run;

data NR001.Sas_Trim_16;
	Set NR001.Sas_009_1
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_17;
	Set NR001.Sas_009_2
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_18;
	Set NR001.Sas_009_3
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_19;
	Set NR001.Sas_010_1
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_20;
	Set NR001.Sas_010_2
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;

data NR001.Sas_Trim_21;
	Set NR001.Sas_010_3
	(Drop = Residual_Value_SUM Balance_Value_SUM Date_Of_Last_Agreement Date_Agreement_Last_Modified Date_Tempering_Last_Modified Credit_Limit_Sum Turnover Param1	Param2	Param3	Param4	Param5	Param6	Param7	Param8	Param9	Param10	Param11	Param1_Value	Param2_Value	Param3_Value	Param4_Value	Param5_Value	Param6_Value	Param7_Value	Param8_Value	Param9_Value	Param10_Value	Param11_Value) ;
run;


*  Union Tables ;
*  Dulicate Files for May Aug 04 - Only one taken ;

Data NR001.Test ;
	Set NR001.Sas_Trim_1	NR001.Sas_Trim_2	NR001.Sas_Trim_3	NR001.Sas_Trim_4	NR001.Sas_Trim_5	NR001.Sas_Trim_6	NR001.Sas_Trim_7	NR001.Sas_Trim_8	NR001.Sas_Trim_9	NR001.Sas_Trim_10	NR001.Sas_Trim_11	NR001.Sas_Trim_12	NR001.Sas_Trim_13	NR001.Sas_Trim_14	NR001.Sas_Trim_15	NR001.Sas_Trim_16	NR001.Sas_Trim_17	NR001.Sas_Trim_18	NR001.Sas_Trim_19	NR001.Sas_Trim_20	NR001.Sas_Trim_21 ;
Run;


data NR001.Test ;
	Set NR001.Test ;
	attrib Outcome format = date9. informat = date9.;
	Outcome = INTNX('month',Parameter_Date,12);
Run;

proc sort data = NR001.TEST   ;
    by
    Crn Parameter_Date    ;
run;


proc freq data = NR001.Test;
     tables Default_Y_or_N;
run;

**  Insert syntax to import date here *;


proc sort data = NR001.Arrears   ;
    by
    Co__Registration_No Date_of_Default   ;
run;

** Change dates from text to date ;

data NR001.Arrears;
	Set NR001.Arrears ;
	attrib Out_Date format = date9. informat = date9.;
	attrib In_Date format = date9. informat = date9.;

	IF Off_Status_Date ^= 'NULL' Then
		Out_Date = Input(
		KSTRCAT(Substr(Off_Status_Date,1,2) , Substr(Off_Status_Date,4,3) , Substr(Off_Status_Date,8,4))
		,date9.);
	Else
		 Out_Date = MDY(01,01,2010);
	In_Date = Input(
		KSTRCAT(Substr(Date_of_Default,1,2) , Substr(Date_of_Default,4,3) , Substr(Date_of_Default,8,4))
		,date9.);
	
run;

proc freq data = NR001.Test;
     tables Default_Y_or_N;
run;

proc sql;
	Create Table NR001.Bads as
	Select  base.crn
			,  base.Parameter_Date
			,  Sum(Case When Outcome Between In_Date and Out_Date 
				Then 1
				Else 0 End) as GoodBad_ind 
			,  Sum(Case When Parameter_Date Between In_Date and Out_Date 
				Then 1
				Else 0 End) as Arrears
			
	From	NR001.Test as base
			,  NR001.Arrears as arrears

	Where base.crn = arrears.Co__Registration_No 
	And		arrears.Status_Approval = 'A'

	Group By  base.crn , base.Parameter_Date;
quit;

proc freq data = NR001.Bads;
     tables GoodBad_Ind;
run;
proc sql;
	Create Table NR001.Goods as
	Select	base.crn
			,  0 as GoodBad_Ind 
			,  0 as Arrears
	From	NR001.Test as base  
	Where 	base.crn not in (Select bads.CRN from NR001.Bads as bads);
quit;

proc freq data = NR001.Goods;
     tables GoodBad_Ind;
run;


*  The following is simply a proof of the Good Bad Flag ;

proc sql;
	Create Table NR001.Bads_Proof as
	Select  base.crn
			,  base.Parameter_Date
			,  Sum(Case When Outcome Between In_Date and Out_Date 
				Then 1
				Else 0 End) as GoodBad_ind 
			,  Sum(Case When Parameter_Date Between In_Date and Out_Date 
				Then 1
				Else 0 End) as Arrears
			
	From	NR001.Test as base
			,  NR001.Arrears as arrears

	Where base.crn = arrears.Co__Registration_No 
	And		arrears.Status_Approval = 'A'

	Group By  base.crn , base.Parameter_Date;
quit;


proc sql;
	Create Table NR001.Dups as
	Select  base.crn
			,  base.Parameter_Date
			,  Count(*)
	
			
	From	NR001.Test as base

	Group By  base.crn , base.Parameter_Date
	Having Count(*) >1
;
quit;

proc sql;
	Create Table NR001.Distinct as
	Select Distinct base.crn
	From	NR001.Dups as base
	;
Quit;


proc freq data = NR001.Test;
     tables Scottish_Af_Y_Or_N;
run;

proc sql;
	Create Table NR001.Scottish as
	Select base.crn
			,  base.Parameter_Date
			,  master.Scottish_Af_Y_Or_N

	From	NR001.Dups as base
			,  NR001.Test as master

	Where	base.crn = master.crn
	And		base.Parameter_Date = master.Parameter_Date
	;
Quit;
proc freq data = NR001.Scottish;
     tables Scottish_Af_Y_Or_N;
run;

* Delete Duplicates from Base Table ;
* Produce report to define numbers of cases affected ;

* Document Arrears table issues *;

