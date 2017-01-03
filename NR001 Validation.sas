

proc sql;			
	Select base.Parameter_Date Format = MONYY.
	,  Temp_Score___Rating_Grade	
	,  Count(*) as Obs	
	,  Sum (Case When perform.Bad_12 >0 then 1 else 0 end) as Bads	

	From	
		NR001.NonRetail_Live as base
		,  NR001.Test perform
	Where	
		base.UniqueKey = perform.UniqueKey
		and Param1 is not NULL
	Group By	
		base.Parameter_Date 
		,  Temp_Score___Rating_Grade

;		
title1 'Portfolio Bad Rate';		
quit;		


