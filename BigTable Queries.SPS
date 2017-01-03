GET DATA /TYPE=ODBC /CONNECT=
 'DSN=MS Access Database;DBQ=C:\Documents and Settings\htimms\Desktop\ASAD reporter for Howe.mdb;DriverId=25;FIL=MS Access;'
  'MaxBufferSize=2048;PageTimeout=5;'
 /SQL = 'SELECT  wk_ref,  category,  strategy,  que,  current_balance, '+
 ' add_ref,  product_type,  package_id,  paid_to_date,  '
  'last_payment_date,  last_payment_amount,  next_payment_date, '+
 ' vendor_last_payment_date,  statute_barred_date,  '
  'last_trn_cd,  latest_plan_number,  vpostcode,  charge_off_date, '+
 ' default_date,  default_amount,  pseudo_package_id,  '
  'debt_couns,  original_card_number,  case_wk_seq,  bookon_date,  owner, '+
 ' bp_ref,  ass_ref,  date_interest_last_applied,  '
  'interest_applied,  daily_interest_amount,  interest_accrued,  `SC1 Score`'+
 ' AS SC1_Score,  occupation,  payment_method,  '
  'original_debt_value,  `currency` FROM  mtb_BigTable'
 /ASSUMEDSTRWIDTH=255
 .
CACHE.
DATASET NAME mtbBigTable WINDOW=FRONT.

SORT CASES BY
  wk_ref (A) .


COMPUTE Accounting_Period = XDATE.YEAR(Bookon_Date) * 100 + XDATE.MONTH(Bookon_Date).
EXE.
FORMAT Accounting_Period (F6.0).

COMPUTE Default_Months = DATEDIF(default_date, $TIME, "months").
EXE.

COMPUTE Last_Months = DATEDIF(last_payment_date, $TIME, "months").
EXE.

COMPUTE Vendor_Months = DATEDIF(vendor_last_payment_date, $TIME, "months").
EXE.

COMPUTE Charge_Months = DATEDIF(Charge_Off_date, $TIME, "months").
EXE.

FREQUENCIES
  VARIABLES=Default_Months Last_Months Vendor_Months Charge_Months
 /FORMAT=NOTABLE
  /STATISTICS=MINIMUM MAXIMUM
  /BARCHART  FREQ
  /ORDER=  ANALYSIS .


*Visual Bander.
*current_balance.
RECODE current_balance
     ( MISSING = COPY )
     ( LO THRU 491.04 =1 )
     ( LO THRU 789.94 =2 )
     ( LO THRU 965.93 =3 )
     ( LO THRU 1087.95 =4 )
     ( LO THRU 1283.58 =5 )
     ( LO THRU 1502 =6 )
     ( LO THRU 1795.55 =7 )
     ( LO THRU 2261.275 =8 )
     ( LO THRU 3629.08 =9 )
     ( LO THRU HI = 10 )
     ( ELSE = SYSMIS ) INTO bCurrent_Balance.
VARIABLE LABELS bCurrent_Balance 'current_balance (Banded)'.
FORMAT bCurrent_Balance (F5.0).
VALUE LABELS bCurrent_Balance
        1  '<= 491.04'
        2  '491.05 - 789.94'
        3  '789.95 - 965.93'
        4  '965.94 - 1087.95'
        5  '1087.96 - 1283.58'
        6  '1283.59 - 1502.00'
        7  '1502.01 - 1795.55'
        8  '1795.56 - 2261.28'
        9  '2261.29 - 3629.08'
        10  '3629.09+'.
MISSING VALUES bCurrent_Balance ( ).
VARIABLE LEVEL bCurrent_Balance ( ORDINAL ).
EXECUTE.


FREQUENCIES
  VARIABLES=bCurrent_Balance
  /BARCHART  FREQ
  /ORDER=  ANALYSIS .

FORMAT Current_Balance (COMMA19.0).
EXE.

FORMAT Default_Amount(COMMA19.0).
EXE.

FORMAT Original_Debt_Value(COMMA19.0).
EXE.


GET DATA /TYPE=ODBC /CONNECT=
 'DSN=odbc_Main_Data_CI;Description=Odbc Link to \\Data\;UID=;APP=SPSS For'+
 ' Windows;WSID=CAB00838;DATABASE=main_data_ci;'
  'Trusted_Connection=Yes'
 /SQL = 'SELECT  "debt-code" AS debtcode,  "dr-postcode" AS drpostcode,  "dr'+
 '-dob" AS drdob,  "from-date" AS fromdate FROM  '
  'dbo.vw_debtor'
 /ASSUMEDSTRWIDTH=255
 .
SAMPLE  0.100000  .
CACHE.
EXECUTE.
DATASET NAME DataSet2 WINDOW=FRONT.
