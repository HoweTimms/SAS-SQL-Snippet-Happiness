proc freq data = NR001.NonRetail_Live;
	Tables Parameter_Date;
	Format Parameter_Date MONYY.;
run;


proc sql;
	Create Table NR001.Dups as
	Select  base.crn
			,  base.Parameter_Date
			,  Count(*)
				
	From	NR001.NonRetail_Live as base

	Group By  base.crn , base.Parameter_Date
	Having Count(*) >1
;
quit;

proc sort data =  NR001.NonRetail_Live;
	by crn Parameter_Date ;
run;

data NR001.NonRetail_Live;
	Set NR001.NonRetail_Live ;
	where crn NE '';
	UniqueKey = KSTRCAT(CRN , Parameter_Date);
run;


proc sql;
	Create Table NR001.UniqueDups as
	Select  base.UniqueKey
			,  Count(*)
				
	From	NR001.NonRetail_Live as base

	Group By  UniqueKey
	Having Count(*) >1
;
quit;

proc sql;
	Create Table NR001.NonRetail_LiveInd as
	Select  base.*
				
	From	NR001.NonRetail_Live as base
			,  NR001.UniqueDups as dup

	Where	base.UniqueKey = dup.UniqueKey
;
quit;

data NR001.NonRetail_LiveInd;
	Set NR001.NonRetail_LiveInd ;
	where Balance_Value_SUM NE .;
run;

proc sql;
	Delete * 
	
	From	NR001.NonRetail_Live as base

	Where	base.UniqueKey in (Select dup.UniqueKey from NR001.UniqueDups as dup)
;
quit;

data NR001.NonRetail_Live ;
	set NR001.NonRetail_Live NR001.NonRetail_LiveInd;
run;

proc freq data = NR001.NonRetail_Live;
	Tables Parameter_Date;
	Format Parameter_Date MONYY.;
run;

