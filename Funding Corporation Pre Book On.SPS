GET DATA  /TYPE = TXT
 /FILE = 'C:\My Documents\Risk\Data\Data(CSV)\Funding Corporation DEBT_SALE_WO_OUTPUT Cabot 260906.xls'
 /DELCASE = LINE
 /DELIMITERS = ","
 /QUALIFIER = '"'
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 AGREEMENT_NUMBER F11.2
 AGREEMENT F11.2
 PRODUCT_DESCRIPTION A30
 LIVE_DATE A10
 AGREEMENT_COMPLETED_DATE A10
 COMPANY A31
 APR F4.2
 ADVANCE F8.2
 TERM_IN_MONTHS F3.2
 DEPOSIT F4.2
 RETAIL_PRICE F6.2
 INSTALMENT_AMOUNT F6.2
 OUTSTANDING_BALANCE F8.2
 EMPLOYER_NAME A31
 EMPLOYER_TELEPHONE A13
 OCCUPATION A30
 ADMIN_FEE F3.2
 OPTION_FEE F3.2
 BANK_SORT_CODE F6.2
 .
CACHE.
EXECUTE.
DATASET NAME FundingCorp WINDOW=FRONT.

SAVE OUTFILE='C:\My Documents\Risk\Data\SPSS (SAV)\Funding Corporation DEBT_SALE_WO_OUTPUT Cabot 260906.sav'
 /COMPRESSED.


