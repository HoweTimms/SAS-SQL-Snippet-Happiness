GET DATA /TYPE=ODBC /CONNECT=
 'DSN=B4;UID=;APP=SPSS For Windows;WSID=CAB00496;DATABASE=risk;Trusted_Conn'+
 'ection=Yes'
 /SQL = 'SELECT  package_id,  "portfolio name" AS portfolio_name,  Maturity'+
 ',  Factor_Value,  Factor,  Obs FROM  '
 '"CFSI\htimms".Characteristic_Stability'
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
DATASET NAME Char_Stab WINDOW=FRONT.
AGGREGATE
 /OUTFILE=*
 /BREAK=Maturity Factor Factor_Value
 /Obs_sum = SUM(Obs).
DATASET CLOSE Char_Stab.