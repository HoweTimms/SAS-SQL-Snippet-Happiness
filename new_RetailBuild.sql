--  Kill all tables in preperation for build

use ¬Destination¬
go

If exists 
	(select 1 from sysobjects where uid = user_id() and type = 'U' and name = 'Retail_e411_new')
	Drop table Retail_e411_new    
go


If exists 
	(select 1 from sysobjects where uid = user_id() and type = 'U' and name = 'Retail_System')
	Drop table Retail_System   
go

If exists 
	(select 1 from sysobjects where uid = user_id() and type = 'U' and name = 'Retail_Base')
	Drop table Retail_Base   
go



-- Build Base Table
use ¬Destination¬
go

declare @Start smalldatetime
declare	@End	smalldatetime

Select 		@Start = dateadd(mm,-14,e440.Start_Date)
		,  @End = e440.End_Date

From	¬Database¬..E440_Processing_Dates e440
Where	e440.Processing_Date_Code = 'CAP'


Select  	e410.Account_Number
	,	e411.Proposal_Number
	,	e410.Inception_Date
	,	e410.First_Payment_Date
	,	e411.Credit_Score
	,	e411.Credit_Score_Card
	,	Convert(money,e411.APR) as 'APR'
	,	Convert(real,e411.Deferred_Period) as 'Deferred_Period'
	,	e411.Term
	,	e410.Advance
	,	e410.Credit_Limit 
	,	Convert(Char(1),e411.System_Decision) as 'System_Decision'
	,	Convert(Char(1),e411.Management_Decision) as 'Management_Decision'

	,	Case when e411.CCN_Product_Code not like '[0-9,#]%' then 'Super Decline'
		else
			Case when CCN_Product_Code Between '500' and '599' then 'Home Improvements'
			else
				case when(e411.CCN_Product_Code < '300'  or e411.CCN_Product_Code in ('692','698','632','636','639','662')) then 'Cards'
				else 'Loans'
				end
			end
		end  'Type'
	,	e413.Dealer_Number
	,	Convert(Char(3),e411.CCN_Product_Code) as 'CCN_Product_Code'
	,	Convert(Char(1),e411.Final_Grade) as 'Final_Grade'
	,	e411.Proposal_Date
	,	e411.Age_of_Applicant
	,	Convert(Char(1),e411.Employment_Status) as 'Employment_Status'
	,	Convert(Char(1),e411.Residential_Status) as 'Residential_Status'
	,	e411.Time_in_Employment
	,	e410.Joint_Indicator 
	,	e411.Underwriter_Id 
	,	e411.Current_Phone_Number 
	,	e411.Duplicate_Application_Ind 
	,	e411.Instant_Credit_Indicator


Into		¬Destination¬..Retail_Base 

From 		¬Database¬..E410_Financial_Agreement 	e410 
	,	¬Database¬..E413_Loan_Agmnt_Dealer_Agmnt 	e413 
	,	¬Database¬..E411_Proposal_Scoring_Data 	e411		

Where 	e410.Account_Number = e413.Account_Number
and		e410.Account_Number = e411.Account_Number
and		e413.Loan_Dealer_Link_Type = 'C'
and		e411.Proposal_Date between @Start and @End
go

create index iAcc on ¬Destination¬..Retail_Base (Account_Number)

go


-- Create Org Number Table

Select		Account_Number
		,  Case When (Substring(Account_Number,1,1) Like '[0-9]' and Type = 'Cards') then
			Convert(Real,Substring(Account_Number,3,3))
		Else
			Convert(real,substring((convert(char(10),(Dealer_Number+1000000000))),2,3)) 
		End 'Org_Number'

Into		¬Destination¬..Retail_Org

From 		¬Destination¬..Retail_Base ret
go

Create Index iAcc on ¬Destination¬..Retail_Org(Account_Number)

-- Create System Table

select 		devMIP.Account_Number 	
		,  sum(case when e418.Reason_Code like 'R%' then 1 else 0 end) 'Refer' 	
		,  sum(case when e418.Reason_Code in ('RP60','RP66') then 1 else 0 end) 'Policy_Decline' 	
		,  sum(case when (e418.Reason_Code in ('SD10') and Sequence_Number = 1) then 1 else 0 end) 'UW_Decline' 	
		,  sum(case when (e418.Reason_Code like 'SC%' and Sequence_Number = 1) then 1 else 0 end ) 'Canx' 
		,  Sum(case when (e418.Reason_Code like 'SR%' and Sequence_Number = 1) then 1 else 0 end ) 'Pend' 	
		,  sum(case when e418.Reason_Code like 'SR%' and e418.Reason_Code not in ('SR91','SR99','SR88','SR89') then 1 else 0 end) 'DocError'
		,  sum(Case when e418.Reason_Code in ('RR98','RR36','RR35') then 1 else 0 end )  'Address_Refer' 	
		,  Sum(Case when e418.Reason_Code in ('RP66','RR77') then 1 else 0 end) 'CIFAS_Refer' 	
		,  Sum(Case when e418.Reason_Code in ('SR99') then 1 else 0 end) 'Force_Refer' 	
		,  Sum(Case when e418.Reason_Code in ('RD10','RD11','RD12') then 1 else 0 end) as 'Score_Exceptions'	
		,  Sum(Case when (e418.Reason_Code IN ('RR59', 'RR56') and e418.Reason_Code not in ('RD10','RD11','RD12')) then 1 else 0 end) as 'Rate4Risk'
		,  Sum(Case when e418.Reason_Code IN ('RD10') then 1 else 0 end) as 'RD10'
		,  Sum(Case when e418.Reason_Code IN ('RD11') then 1 else 0 end) as 'RD11'
		,  Sum(Case when e418.Reason_Code IN ('RD12') then 1 else 0 end) as 'RD12'
		
		,  sum(case when e418.Reason_Code ='RR01' then 1 else 0 end) as		'RR01'  		/*  Detect Index */
            	,  sum(case when e418.Reason_Code ='RR02' then 1 else 0 end) as		'RR02' 			/*  Detect Message (Old) */
		,  sum(case when e418.Reason_Code ='RR03' then 1 else 0 end) as		'RR03' 			/*  Detect 3+ Bureau Data */
		,  sum(case when e418.Reason_Code ='RR04' then 1 else 0 end) as		'RR04' 			/*  Detect Link Address */
		,  sum(case when e418.Reason_Code ='RR05' then 1 else 0 end) as		'RR05'			/*  Detect No Trace */
		,  sum(case when e418.Reason_Code ='RR06' then 1 else 0 end) as		'RR06' 			/*  Detect Age Imprersonation */		
		,  Sum(Case when e418.Reason_Code IN ('RR35') then 1 else 0 end) as 'RR35'	
		,  Sum(Case when e418.Reason_Code IN ('RR36') then 1 else 0 end) as 'RR36'	
		,  Sum(Case when e418.Reason_Code IN ('RR40') then 1 else 0 end) as 'RR40'
		,  Sum(Case when e418.Reason_Code IN ('RR98') then 1 else 0 end) as 'RR98'	
		,  Sum(Case when e418.Reason_Code IN ('RR51') then 1 else 0 end) as 'RR51'	
		,  Sum(Case when e418.Reason_Code IN ('RR52') then 1 else 0 end) as 'RR52'	
		,  Sum(Case when e418.Reason_Code IN ('RR53') then 1 else 0 end) as 'RR53'	
		,  Sum(Case when e418.Reason_Code IN ('RR54') then 1 else 0 end) as 'RR54'	
		,  Sum(Case when e418.Reason_Code IN ('RR55') then 1 else 0 end) as 'RR55'	
		,  Sum(Case when e418.Reason_Code IN ('RR56') then 1 else 0 end) as 'RR56'	
		,  Sum(Case when e418.Reason_Code IN ('RR57') then 1 else 0 end) as 'RR57'	
		,  Sum(Case when e418.Reason_Code IN ('RR58') then 1 else 0 end) as 'RR58'	
		,  Sum(Case when e418.Reason_Code IN ('RR77') then 1 else 0 end) as 'RR77'	
		,  Sum(Case when e418.Reason_Code IN ('RR21') then 1 else 0 end) as 'RR21'	
		,  Sum(Case when e418.Reason_Code IN ('RR49') then 1 else 0 end) as 'RR49'	
		,  Sum(Case when e418.Reason_Code IN ('RR59') then 1 else 0 end) as 'RR59'	
		,  Sum(Case when e418.Reason_Code IN ('SC10') then 1 else 0 end) as 'SC10'	
		,  Sum(Case when e418.Reason_Code IN ('SC20') then 1 else 0 end) as 'SC20'	
		,  Sum(Case when e418.Reason_Code IN ('AA10') then 1 else 0 end) as 'AA10'	
		,  Sum(Case when e418.Reason_Code IN ('AA30') then 1 else 0 end) as 'AA30'	
		,  Sum(Case when e418.Reason_Code IN ('PA10') then 1 else 0 end) as 'PA10' 	
		,  Sum(Case when e418.Reason_Code IN ('PA30') then 1 else 0 end) as 'PA30' 
		,  Sum(Case when e418.Reason_Code IN ('SR88') then 1 else 0 end) as 'SR88' 
		,  Sum(Case when e418.Reason_Code IN ('SR89') then 1 else 0 end) as 'SR89' 

into		¬Destination¬..Retail_System 


from		¬Destination¬..Retail_Base  devMIP 	
		,  ¬Database¬..E418_Reason_Codes 		e418

where		devMIP.Account_Number = e418.Account_Number

group by 	devMIP.Account_Number

go

Create index iAcc on ¬Destination¬..Retail_System (Account_Number)
go


--  Create 'new' table (Which is desired result)


Select 	devMIP.*
	,  isnull(org.Major_Name,'Missing') 'Major_Name'
	,   isnull(org.Minor_Name,'Missing') 'Minor_Name'
	,   isnull(org.refKey,'Missing') 'refKey'
	,   Convert(int,substring(e4117.DELPHI_Code_1,3,4)) 'Delphi'
	,   'ACC' as 'System_Proposal_Status'
	,   'ACC' as 'Report_Proposal_Status'

	,  Case when RR01 >= 1 and ((RR02 + RR03 +  RR04 + RR05 + RR06) =0) then 'Index' 
	else 
		case when RR01 =0 and ((RR02 + RR03 +  RR04 + RR05 + RR06) >=1 ) then 'Policy' 
		else
			case when RR01 >= 1 and ((RR02 + RR03 +  RR04 + RR05 + RR06) >=1) then 'Both' 
			else 'No'
			end
		end
	end 'Detect_Refferal'

	,  replicate('x',12) as Detect_Policy

	,  Case when Policy_Decline >= 1 then 'P' 
	else 
		case when Refer = 0 then 'U' 
		else 
			Case When RR59 >0 then 'A'
			else 
				Case When (RR49 + RR56) = Refer then 'A'
				else 'R'
				end
			end
		end
	end 'System'

	,  'xxxxxxxxxxx' Auto_Decision
	,   0 as Overide
	,   'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' Product_Type
	,   'xxxxxxxxxx' ChampionChallenger 
	,   Refer as 'No_Referral' 
	,   Rate4Risk 
	,  Case when ((RR01+(RR02 + RR03 +  RR04 + RR05 + RR06) + RR77) = (Refer - RR56 - RR49) and (RR01+ (RR02 + RR03 +  RR04 + RR05 + RR06) + RR77) > 0) then 'Detect'
	else
		Case When (RR35+RR36+RR40+RR98) = (Refer - RR56 - RR49) and (RR35+RR36+RR40+RR98) >0 then 'Address'
		else
			Case When (RR57+RR58) = (Refer - RR56 - RR49) and (RR57+RR58)>0 then 'Adverse'
			else
				Case When Refer = 0 then 'Auto'
				else
					Case When RR59 = Refer then 'Mandatory'
					else 
						Case When (RR49 + RR56) = Refer and (RR49 + RR56) > 0 then 'Rev_Mand'
						else
							Case When (RD10 + RD11 + RD12) = (Refer - RR56 - RR49) and (RD10 + RD11 + RD12) > 0  then 'Policy'
							else
								Case When Policy_Decline > 0 then 'Auto_Reject'
								else 'Multiple'
								end
							end
						end
					end
				end
			end
		end
	end as 'Referrals' 
	,   Canx as Cancellation 
	,   Force_Refer
	,  0 as Score_Oride
	,  Loss_Rate


Into	¬Destination¬..Retail_e411_new

From	¬Destination¬..Retail_Base 			devMIP 
	,  ¬Destination¬..Retail_System 		system
	,  ¬Database¬..E411_7_Old_Link_Data 		e4117
	,  ¬Destination¬..ref_Retail_ORG		org
	,  RISK.Nicholas_Brown.ref_AA_Retail_GB_Odds 	bads

Where	devMIP.Account_Number *= system.Account_Number
and	devMIP.Account_Number *= e4117.Account_Number
and	devMIP.Org_Number *= org.Org
and	devMIP.Credit_Score *= bads.Credit_Score

go

Create index iAcc on ¬Destination¬..Retail_e411_new(Account_Number)
go

declare @result int
declare @test int

select 	@result = count(*) from ¬Destination¬..Retail_e411_new
select	@test = Count(*) from ¬Destination¬..Retail_Base

If @test = @result
	Drop table ¬Destination¬..Retail_Base
go


-- Updates Table to complete Build

/* Build Reference Table */

Select	risk.Account_Number
		,  (RR02 +RR03 + RR04 + RR05 + RR06 ) Nars

Into		&Destination&..temp_DetCount

From	&Destination&..Retail_e411_new			risk 
		,  &destination&..Retail_System 	system

Where	risk.Account_Number = system.Account_Number
and		Detect_Refferal in ('Policy','Both')

go

Create Index iAcc on &Destination&..temp_DetCount(Account_Number)
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go

/* Build Temp Tables Identifying */

Select 	risk.Account_Number

Into		&Destination&..temp_ret_RR02

From	&Destination&..temp_DetCount		risk 
		,  &destination&..Retail_System 	system

Where	risk.Account_Number = system.Account_Number
and		Nars = 1
and		RR02 = (RR02 +RR03 + RR04 + RR05 + RR06 )

go

Select 	risk.Account_Number

Into		&Destination&..temp_ret_RR03

From	&Destination&..temp_DetCount		risk 
		,  &destination&..Retail_System 	system

Where	risk.Account_Number = system.Account_Number
and		Nars = 1
and		RR03 = (RR02 +RR03 + RR04 + RR05 + RR06 )

go

Select 	risk.Account_Number

Into		&Destination&..temp_ret_RR04

From	&Destination&..temp_DetCount		risk 
		,  &destination&..Retail_System 	system

Where	risk.Account_Number = system.Account_Number
and		Nars = 1
and		RR04 = (RR02 +RR03 + RR04 + RR05 + RR06 )

go

Select 	risk.Account_Number

Into		&Destination&..temp_ret_RR05

From	&Destination&..temp_DetCount		risk 
		,  &destination&..Retail_System 	system

Where	risk.Account_Number = system.Account_Number
and		Nars = 1
and		RR05 = (RR02 +RR03 + RR04 + RR05 + RR06 )

go

Select 	risk.Account_Number

Into		&Destination&..temp_ret_RR06

From	&Destination&..temp_DetCount		risk 
		,  &destination&..Retail_System 	system

Where	risk.Account_Number = system.Account_Number
and		Nars = 1
and		RR06 = (RR02 +RR03 + RR04 + RR05 + RR06 )

go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


Update	&destination&..Retail_new

Set		Detect_Policy = 'Old_Policy'

From	&destination&..Retail_e411_new 		risk
		,  &Destination&..temp_ret_RR02	detect

Where	detect.Account_Number = risk.Account_Number

go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


Update	&destination&..Retail_new

Set		Detect_Policy = 'Default Data'

From	&destination&..Retail_e411_new 		risk
		,  &Destination&..temp_ret_RR03	detect

Where	detect.Account_Number = risk.Account_Number

go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


Update	&destination&..Retail_new

Set		Detect_Policy = 'Link Address'

From	&destination&..Retail_e411_new 		risk
		,  &Destination&..temp_ret_RR04	detect

Where	detect.Account_Number = risk.Account_Number

go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


Update	&destination&..Retail_e411_new

Set		Detect_Policy = 'No Trace Ind'

From	&destination&..Retail_new 		risk
		,  &Destination&..temp_ret_RR05	detect

Where	detect.Account_Number = risk.Account_Number

go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go

Update	&destination&..Retail_new

Set		Detect_Policy = 'DOB Mismatch'

From	&destination&..Retail_new 		risk
		,  &Destination&..temp_ret_RR06	detect

Where	detect.Account_Number = risk.Account_Number

go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


Update	&destination&..Retail_new

Set		Detect_Policy = 'Interact_2'

From	&destination&..Retail_new 		risk
		,  &Destination&..temp_DetCount	detect

Where	detect.Account_Number = risk.Account_Number
and		detect.Nars = 2

go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go

Update	&destination&..Retail_new

Set		Detect_Policy = 'Interact_3'

From	&destination&..Retail_new 		risk
		,  &Destination&..temp_DetCount	detect

Where	detect.Account_Number = risk.Account_Number
and		detect.Nars = 3

go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go

Update	&destination&..Retail_new

Set		Detect_Policy = 'All'

From	&destination&..Retail_new 		risk
		,  &Destination&..temp_DetCount	detect

Where	detect.Account_Number = risk.Account_Number
and		detect.Nars = 4

go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


/* Drop Temp Tables */

Drop table &Destination&..temp_DetCount
Drop table &Destination&..temp_ret_RR02
Drop table &Destination&..temp_ret_RR03
Drop table &Destination&..temp_ret_RR04
Drop table &Destination&..temp_ret_RR05
Drop table &Destination&..temp_ret_RR06

/*	DFS String Updates */
Update		¬Destination¬..Retail_e411_new
Set		Major_Name = Case when Substring(Convert(Char(9),Dealer_Number),4,3) <= '500' then 'DFS_1st' 
		else 'DFS_2nd' end
From 		¬Destination¬..Retail_e411_new
Where		Major_Name = 'DFS'
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go

/* Cancellation */
Update          ¬Destination¬..Retail_e411_new 	
Set 		Cancellation = 1                    
From            ¬Destination¬..Retail_e411_new 		e411
		,  ¬Destination¬..Retail_System 	system
Where           system.Account_Number = e411.Account_Number
And		Canx > 0 
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go

/*
-- Sets TRF tag on ALL proposals --
*/
Update          ¬Destination¬..Retail_e411_new 	
Set 		System_Proposal_Status = 'TRF',
		Report_Proposal_Status = 'TRF'                                            
From            ¬Destination¬..Retail_e411_new e411
Where           e411.Inception_Date is not Null
go 

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go

/*
-- Sets Report TRF tag on Accept proposals --
*/

Update          ¬Destination¬..Retail_e411_new 	
Set 		Report_Proposal_Status = 'TRF'  
From            ¬Destination¬..Retail_e411_new 		e411 
		,  ¬Destination¬..Retail_System 	system
Where           system.Account_Number = e411.Account_Number
And		PA30 >= 1
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go

/*
-- Sets Status PEN --
*/
Update          ¬Destination¬..Retail_e411_new
Set 		System_Proposal_Status = 'PEN'
		,  Report_Proposal_Status = 'PEN'                            
From            ¬Destination¬..Retail_e411_new 		e411
		,  ¬Destination¬..Retail_System 	system
Where           system.Account_Number = e411.Account_Number
and		Pend > 0
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go

/*
-- Sets Status rej --
*/

Update          ¬Destination¬..Retail_e411_new	
Set 		System_Proposal_Status = 'REJ'
		,  Report_Proposal_Status = 'REJ'
From            ¬Destination¬..Retail_e411_new 		e411 
		,  ¬Destination¬..Retail_System 	system
Where           system.Account_Number = e411.Account_Number
and		(
		UW_Decline > 0 
		or 
		substring(e411.Account_Number,1,1) not like '[0-9,#]%'
		)
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


/*
-- Update Auto Decision for 'Super Delcines' --
*/
Update          ¬Destination¬..Retail_e411_new 
Set 		Auto_Decision	 = 'AutoReject'                                            
From            ¬Destination¬..Retail_e411_new e411 
Where           e411.Type = 'Super Decline'
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


/*
-- Update Auto Decision for 'Auto Accepts' --
*/
Update          ¬Destination¬..Retail_e411_new 
Set 		Auto_Decision	 = 'AutoAccept'   
From            ¬Destination¬..Retail_e411_new 		e411 
		,  ¬Destination¬..Retail_System 	system
Where        	system.Account_Number = e411.Account_Number
And		Refer = 0
And		System <> 'A'
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


/*
-- Update Auto Decision for Refer Decisions --
*/

Update          ¬Destination¬..Retail_e411_new 	
Set 		Auto_Decision	 = 	Case when e411.System_Proposal_Status in ('REJ') then 'ReferReject' 
					else  'ReferAccept' 
					end                                            
From            ¬Destination¬..Retail_e411_new e411 
		,  ¬Destination¬..Retail_System system
Where           system.Account_Number = e411.Account_Number
And		Refer >= 1
And		System <> 'A'
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


/*
-- Update Auto Decision for 'Auto Rejects' --
*/
Update          ¬Destination¬..Retail_e411_new 	
Set 		Auto_Decision	 = 'AutoReject'   
From          	¬Destination¬..Retail_e411_new 		e411 
		,  ¬Destination¬..Retail_System 	system
Where           system.Account_Number = e411.Account_Number
And		Policy_Decline >= 1 
And 		e411.System_Proposal_Status not in ('ACC','TRF','PEN')
And		System <> 'A'
go


/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


/*
-- Update Auto Decision for 'Mand Accepts' --
*/

Update          ¬Destination¬..Retail_e411_new 	
Set 		Auto_Decision	 = 'Mandatory'   
From            ¬Destination¬..Retail_e411_new 		e411 
		,  ¬Destination¬..Retail_System 	system
Where         	system.Account_Number = e411.Account_Number
And		e411.System = 'A'
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


/*
-- Update Auto Decision for 'Mand Rejects' --
*/

Update          ¬Destination¬..Retail_e411_new 	
Set 		Auto_Decision	 = 'MandReject'    
From          	¬Destination¬..Retail_e411_new 		e411 
		,  ¬Destination¬..Retail_System 	system
Where           system.Account_Number = e411.Account_Number
And		e411.System = 'A'
And 		e411.System_Proposal_Status not in ('ACC','TRF','PEN')
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go


/*
-- Updates Overide Column using Refer codes from System table and the Previously updated System_Proposal_Status 
-- This column used to identify Proposal Status which is not consitant with expected System recommendation
*/

Update		¬Destination¬..Retail_e411_new
Set		Overide = case when 
			(Referrals = 'Auto_Reject' and e411.System_Proposal_Status not in ('REJ')) 
		or 	(Referrals in ('Auto','Mandatory','Rev_Mand') and e411.System_Proposal_Status not in ('ACC','TRF','PEN')) 
			then 1
			else 0
			end					
From		¬Destination¬..Retail_System 	system
		,  ¬Destination¬..Retail_e411_new 		e411
Where		system.Account_Number = e411.Account_Number
go

/* Dump Transaction Logs*/

dump transaction ¬Destination¬ with truncate_only
go
