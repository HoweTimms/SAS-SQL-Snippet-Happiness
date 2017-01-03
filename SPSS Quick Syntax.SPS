GET DATA /TYPE=ODBC /CONNECT=
 'DSN=MS Access Database;DBQ=C:\Documents and Settings\htimms\Desktop\ASAD'+
 ' reporter for Howe.mdb;DriverId=25;FIL=MS Access;'
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
DATASET NAME DataSet2 WINDOW=FRONT.


FREQUENCIES
  VARIABLES=category
  /NTILES=  4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEDIAN
  /BARCHART  FREQ
  /ORDER=  ANALYSIS .

DESCRIPTIVES
  VARIABLES=que
  /STATISTICS=MEAN STDDEV MIN MAX KURTOSIS .
