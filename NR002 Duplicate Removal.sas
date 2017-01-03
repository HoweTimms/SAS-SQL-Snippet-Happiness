libname NR001 'C:\Documents and Settings\htimms\My Documents\Risk\NR001\Data\SAS\' ;

* dec 2002.xls;

PROC IMPORT OUT= NR001.SAS_001_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\dec 2002.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;

RUN;

data NR001.Sas_001_1;
	Set NR001.Sas_001_1 ;
	attrib Parameter_Date format = date9. informat = date9.;
	Parameter_Date = MDY(12,01,2002);
run;

data NR001.SAS_001_1(drop=x y z Residual_Value_SUM Turnover Date_Of_Last_Agreement Date_Agreement_Last_Modified ) ;
 	set NR001.SAS_001_1(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z));

	Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


run;
* JAN TO APR 2004.xls;
PROC IMPORT OUT= NR001.SAS_002_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\JAN TO APR 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_002_1(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_002_1(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;


* JAN TO APR 2004.xls;
PROC IMPORT OUT= NR001.SAS_002_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\JAN TO APR 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_002_2(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_002_2(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;
* JAN TO APR 2004.xls;
PROC IMPORT OUT= NR001.SAS_002_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\JAN TO APR 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
data NR001.SAS_002_3(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_002_3(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	Param10_Value  = j* 1;
	Param11_Value  = k* 1;

run;
* jan to april 03.xls;
PROC IMPORT OUT= NR001.SAS_003_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\jan to april 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_003_1(drop=x y z) ;
 	set NR001.SAS_003_1(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


run;
* jan to april 03.xls;
PROC IMPORT OUT= NR001.SAS_003_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\jan to april 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


data NR001.SAS_003_2(drop=x y z) ;
 	set NR001.SAS_003_2(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


run;


* jan to april 03.xls;
PROC IMPORT OUT= NR001.SAS_003_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\jan to april 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


data NR001.SAS_003_3(drop=a b c d e f g h i j k x y z aa bb cc dd ee ff gg hh ii jj kk) ;
 	set NR001.SAS_003_3(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k Param1=aa	Param2=bb	Param3=cc	Param4=dd	Param5=ee	Param6=ff	Param7=gg	Param8=hh	Param9=ii	Param10=jj	Param11=kk));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

	if aa = 'NULL' then Param1  = . ;	else Param1  = a* 1;
	if bb = 'NULL' then Param2  = . ;	else Param2  = b* 1;
	if cc = 'NULL' then Param3  = . ;	else Param3  = c* 1;
	if dd = 'NULL' then Param4  = . ;	else Param4  = d* 1;
	if ee = 'NULL' then Param5  = . ;	else Param5  = e* 1;
	if ff = 'NULL' then Param6  = . ;	else Param6  = f* 1;
	if gg = 'NULL' then Param7  = . ;	else Param7  = g* 1;
	if hh = 'NULL' then Param8  = . ;	else Param8  = h* 1;
	if ii = 'NULL' then Param9  = . ;	else Param9  = i* 1;
	if jj = 'NULL' then Param10  = . ;	else Param10  = j* 1;
	if kk = 'NULL' then Param11  = . ;	else Param11  = k* 1;

run;


* may to aug 03.xls;
PROC IMPORT OUT= NR001.SAS_004_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

proc contents data = NR001.SAS_004_1 position ;
run;

data NR001.SAS_004_1(drop=x y z) ;
 	set NR001.SAS_004_1(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


run;
* may to aug 03.xls;
PROC IMPORT OUT= NR001.SAS_004_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_004_2(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_004_2(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;

* may to aug 03.xls;
PROC IMPORT OUT= NR001.SAS_004_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 03.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


data NR001.SAS_004_3(drop=a b c d e f g h i j k x y z aa bb cc dd ee ff gg hh ii jj kk) ;
 	set NR001.SAS_004_3(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k Param1=aa	Param2=bb	Param3=cc	Param4=dd	Param5=ee	Param6=ff	Param7=gg	Param8=hh	Param9=ii	Param10=jj	Param11=kk));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

	if aa = 'NULL' then Param1  = . ;	else Param1  = a* 1;
	if bb = 'NULL' then Param2  = . ;	else Param2  = b* 1;
	if cc = 'NULL' then Param3  = . ;	else Param3  = c* 1;
	if dd = 'NULL' then Param4  = . ;	else Param4  = d* 1;
	if ee = 'NULL' then Param5  = . ;	else Param5  = e* 1;
	if ff = 'NULL' then Param6  = . ;	else Param6  = f* 1;
	if gg = 'NULL' then Param7  = . ;	else Param7  = g* 1;
	if hh = 'NULL' then Param8  = . ;	else Param8  = h* 1;
	if ii = 'NULL' then Param9  = . ;	else Param9  = i* 1;
	if jj = 'NULL' then Param10  = . ;	else Param10  = j* 1;
	if kk = 'NULL' then Param11  = . ;	else Param11  = k* 1;

run;
* may to aug 04.xls;
PROC IMPORT OUT= NR001.SAS_005_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 04.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_005_1(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_005_1(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;

* may to aug 04.xls;
PROC IMPORT OUT= NR001.SAS_005_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 04.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_005_2(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_005_2(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;

* may to aug 04.xls;
PROC IMPORT OUT= NR001.SAS_005_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 04.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_005_3(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_005_3(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;

* may to aug 2004.xls;
PROC IMPORT OUT= NR001.SAS_006_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_006_1(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_006_1(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;
* may to aug 2004.xls;
PROC IMPORT OUT= NR001.SAS_006_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


data NR001.SAS_006_2(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_006_2(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;
* may to aug 2004.xls;
PROC IMPORT OUT= NR001.SAS_006_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\may to aug 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


data NR001.SAS_006_3(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_006_3(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;


*  Need to add Paramater Date X ;
* nov 2002.XLS.xls;
PROC IMPORT OUT= NR001.SAS_007_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\nov 2002.XLS.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_007_1(drop=x y z) ;
	set NR001.SAS_007_1(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


run;

data NR001.Sas_007_1;
	Set NR001.Sas_007_1 ;
	attrib Parameter_Date format = date9. informat = date9.;
	Parameter_Date = MDY(11,01,2002);
run;
*  Need to add Paramater Date X ;
* OCT 2002.XLS.xls;
PROC IMPORT OUT= NR001.SAS_008_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\OCT 2002.XLS.xls"
           	DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


data NR001.SAS_008_1(drop=x y z) ;
	set NR001.SAS_008_1(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


run;

data NR001.Sas_008_1;
	Set NR001.Sas_008_1 ;
	attrib Parameter_Date format = date9. informat = date9.;
	Parameter_Date = MDY(10,01,2002);
run;

* sept to dec 2003.xls;
PROC IMPORT OUT= NR001.SAS_009_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sept to dec 2003.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


data NR001.SAS_009_1(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_009_1(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;

* sept to dec 2003.xls;
PROC IMPORT OUT= NR001.SAS_009_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sept to dec 2003.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

proc contents data = NR001.SAS_009_2 position ;
run;


data NR001.SAS_009_2(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_009_2(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	if y = 'NULL' then Balance_Value_SUM  = . ;
	else Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;

* sept to dec 2003.xls;
PROC IMPORT OUT= NR001.SAS_009_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sept to dec 2003.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_009_3(drop=a b c d e f g h i j k x y z aa bb cc dd ee ff gg hh ii jj kk) ;
 	set NR001.SAS_009_3(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k Param1=aa	Param2=bb	Param3=cc	Param4=dd	Param5=ee	Param6=ff	Param7=gg	Param8=hh	Param9=ii	Param10=jj	Param11=kk));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

	if aa = 'NULL' then Param1  = . ;	else Param1  = a* 1;
	if bb = 'NULL' then Param2  = . ;	else Param2  = b* 1;
	if cc = 'NULL' then Param3  = . ;	else Param3  = c* 1;
	if dd = 'NULL' then Param4  = . ;	else Param4  = d* 1;
	if ee = 'NULL' then Param5  = . ;	else Param5  = e* 1;
	if ff = 'NULL' then Param6  = . ;	else Param6  = f* 1;
	if gg = 'NULL' then Param7  = . ;	else Param7  = g* 1;
	if hh = 'NULL' then Param8  = . ;	else Param8  = h* 1;
	if ii = 'NULL' then Param9  = . ;	else Param9  = i* 1;
	if jj = 'NULL' then Param10  = . ;	else Param10  = j* 1;
	if kk = 'NULL' then Param11  = . ;	else Param11  = k* 1;

run;

* sept to dec 2004.xls;
PROC IMPORT OUT= NR001.SAS_010_1
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sep to dec 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


data NR001.SAS_010_1(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_010_1(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;
* sept to dec 2004.xls;
PROC IMPORT OUT= NR001.SAS_010_2
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sep to dec 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_1$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_010_2(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_010_2(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	if f = 'NULL' then Param6_Value  = . ;	else Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	if h = 'NULL' then Param8_Value  = . ;	else Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;
* sept to dec 2004.xls;
PROC IMPORT OUT= NR001.SAS_010_3
            DATAFILE= "C:\Documents and Settings\HTimms\My Documents\Risk\NR001\Data\Excel\SAS Prep\sep to dec 2004.xls"
            DBMS=EXCEL REPLACE;
            SHEET="Main_2$";
     GETNAMES=YES;
     MIXED=YES;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

data NR001.SAS_010_3(drop=a b c d e f g h i j k x y z) ;
 	set NR001.SAS_010_3(rename=(Credit_Limit_SUM=x Balance_Value_SUM=y Icc_Score_When_Tempered = z Param1_Value=a	Param2_Value=b	Param3_Value=c	Param4_Value=d	Param5_Value=e	Param6_Value=f	Param7_Value=g	Param8_Value=h	Param9_Value=i	Param10_Value=j	Param11_Value=k));

	if x = 'NULL' then Credit_Limit_SUM  = . ;
	else Credit_Limit_SUM  = x* 1;

	Balance_Value_SUM  = y* 1;

	If z = 'NO ICC SCORE' then Icc_Score_When_Tempered = .;
	else if z = 'D' then Icc_Score_When_Tempered = 999;
	else if z = 'R' then Icc_Score_When_Tempered = 998;
	else if z = 'U' then Icc_Score_When_Tempered = 997;
	else if z = 'L' then Icc_Score_When_Tempered = 996;
	else IF Z = 'A' then Icc_Score_When_Tempered = 995;
	else IF Z = 'I' then Icc_Score_When_Tempered = 994;
	else Icc_Score_When_Tempered = z*1;


	if a = 'NULL' then Param1_Value  = . ;	else Param1_Value  = a* 1;
	if b = 'NULL' then Param2_Value  = . ;	else Param2_Value  = b* 1;
	if c = 'NULL' then Param3_Value  = . ;	else Param3_Value  = c* 1;
	if d = 'NULL' then Param4_Value  = . ;	else Param4_Value  = d* 1;
	if e = 'NULL' then Param5_Value  = . ;	else Param5_Value  = e* 1;
	Param6_Value  = f* 1;
	if g = 'NULL' then Param7_Value  = . ;	else Param7_Value  = g* 1;
	Param8_Value  = h* 1;
	if i = 'NULL' then Param9_Value  = . ;	else Param9_Value  = i* 1;
	if j = 'NULL' then Param10_Value  = . ;	else Param10_Value  = j* 1;
	if k = 'NULL' then Param11_Value  = . ;	else Param11_Value  = k* 1;

run;


*  Union Tables ;
*  Dulicate Files for May Aug 04 - Only one taken ;

Data NR001.Test ;
	Set NR001.Sas_001_1	NR001.Sas_002_1;
run;


proc contents data = NR001.SAS_002_1 position ;
run;


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
	Create Table NR001.BadDups as
	Select  base.crn
				
	From	NR001.Dups as base
			,  NR001.Arrears

	Where	base.crn = Arrears.Co__Registration_no
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

/* from http://www.sas.com/service/techsup/faq/data_step/workwith267.html */

/*test data, ALL character data*/
data chardata;
x='12345';y='0987'; output;
a='3';b='4';output;
run;

/*var names and position*/
proc contents noprint data=chardata out=varname(keep=name npos);
run;

/* sort by pos in the data set, yields vars
   in the order they appear in the data set*/
proc sort;
by npos;
run;

data _null_;
 do i=1 to nobs;
   set varname nobs=nobs end=end;
    call symput('mac'||left(put(i,4.)),name);     /*creates macro variables for name of vars*/
    call symput('num'||left(put(i,4.)),'num'||left(put(i,4.)));   /*creates new macro numeric vars*/
     if end then call symput('end',put(nobs,8.));   /*determines number of variables, 1 per obs*/
 end;         /*assumes none of char vars are larger than 8 bytes*/
run;


/*macro generates the drop and rename, so numeric vars have original names*/
%macro create;
 data numdata(drop= %do i=1 %to &end;&&mac&i %end;
            rename=(%do i=1 %to &end; &&num&i=&&mac&i  %end;));
     %do i=1 %to &end;
        set chardata ;
        /*create numeric macro vars, which resolve to num1-num5*/
        &&num&i=input(&&mac&i,5.);
     %end;
 run;
%mend;

%create;

/*verify that the new data set contains all numeric vars*/
proc contents data=numdata;
run;

*  Division *;

proc freq data=NR001.Test;
      tables Division;
 run;

proc contents data = NR001.SAS_001_1;
run;

proc freq data=NR001.Sas_001_1;
      tables Credit_Limit_SUM Balance_Value_SUM;
 run;

proc sort data = NR001.SAS_001_1 noduplicates;
	by crn;
run;

proc freq data=NR001.Sas_001_1;
	tables Date_Of_Last_Agreement ;
run;

proc freq data=NR001.Sas_001_1;
	tables Date_Of_Last_Agreement;
	format Date_Of_Last_Agreement MONYY.;
run;

proc freq data=NR001.Sas_001_1;
	tables Date_Of_Last_Agreement;
	format Date_Of_Last_Agreement YYQC6.;
run;


proc freq data=NR001.Sas_001_1;
	tables Date_Of_Last_Agreement ;
	format Date_Of_Last_Agreement YEAR4.;
run;

proc freq data=NR001.Sas_001_1;
	tables Turnover;
run;

proc freq data=NR001.Sas_002_1;
	tables Param7_Value Param8_Value Param9_Value Param10_Value Param11_Value;
run;

*  Date_Agreement_Last_Modified  All Set to same value?  Why? ;
proc freq data = NR001.Sas_001_1;
	tables Balance_Value_SUM ;
run;
