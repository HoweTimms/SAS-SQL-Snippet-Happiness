
*  Create a table that can be used for Bad / Not bad rates and DDR ;

proc sql;
	Create Table NR001.Bads as
	Select  UniqueKey

		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<1) then 1 else 0 end) as Bad_1
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<2) then 1 else 0 end) as Bad_2
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<3) then 1 else 0 end) as Bad_3
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<4) then 1 else 0 end) as Bad_4
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<5) then 1 else 0 end) as Bad_5
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<6) then 1 else 0 end) as Bad_6
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<7) then 1 else 0 end) as Bad_7
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<8) then 1 else 0 end) as Bad_8
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<9) then 1 else 0 end) as Bad_9
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<10) then 1 else 0 end) as Bad_10
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<11) then 1 else 0 end) as Bad_11
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<12) then 1 else 0 end) as Bad_12
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<13) then 1 else 0 end) as Bad_13
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<14) then 1 else 0 end) as Bad_14
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<15) then 1 else 0 end) as Bad_15
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<16) then 1 else 0 end) as Bad_16
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<17) then 1 else 0 end) as Bad_17
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<18) then 1 else 0 end) as Bad_18
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<19) then 1 else 0 end) as Bad_19
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<20) then 1 else 0 end) as Bad_20
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<21) then 1 else 0 end) as Bad_21
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<22) then 1 else 0 end) as Bad_22
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<23) then 1 else 0 end) as Bad_23
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<24) then 1 else 0 end) as Bad_24
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<25) then 1 else 0 end) as Bad_25
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<26) then 1 else 0 end) as Bad_26
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<27) then 1 else 0 end) as Bad_27
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<28) then 1 else 0 end) as Bad_28
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<29) then 1 else 0 end) as Bad_29
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<30) then 1 else 0 end) as Bad_30
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<31) then 1 else 0 end) as Bad_31
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<32) then 1 else 0 end) as Bad_32
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<33) then 1 else 0 end) as Bad_33
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<34) then 1 else 0 end) as Bad_34
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<35) then 1 else 0 end) as Bad_35
		, Sum(Case When (INTCK('month',Parameter_Date ,Out_Date  ) >=0 )And (INTCK('month',Parameter_Date ,In_Date  )<36) then 1 else 0 end) as Bad_36

	From	NR001.NonRetail_Live as base
			,  NR001.Arrears as arrears

	Where 	base.crn = arrears.Co__Registration_No 
	And		arrears.Status_Approval = 'A'

	Group By
			UniqueKey ;
quit;

*  Prove that the DDR works - see Excel worksheet ;

proc sql;
	Create Table NR001.BadsTest as
	Select	base.*
			,  arrears.*

	From	NR001.NonRetail_Live as base
			,  NR001.Bads as arrears

	Where 	base.UniqueKey = arrears.UniqueKey
	And		base.crn = '00062615'
;
quit;

