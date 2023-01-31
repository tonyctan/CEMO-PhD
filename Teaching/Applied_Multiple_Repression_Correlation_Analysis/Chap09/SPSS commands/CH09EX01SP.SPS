*********************************
SPSS code file CH09EX01SP
*********************************
Chapter 9 Example 1 Three patterns of relationship in a 2 by 2 experimental design
*********************************.
GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP09\DATA\C0901DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 YA F16.2
 YB F16.2
 YC F16.2
 LESION$ A7
 DRUG$ A7
 .
CACHE.
EXECUTE.


UNIANOVA
  ya  BY lesion$ drug$
  /METHOD = SSTYPE(3)
  /INTERCEPT = INCLUDE
  /CRITERIA = ALPHA(.05)
  /DESIGN = lesion$ drug$ lesion$*drug$ .

UNIANOVA
  yb  BY lesion$ drug$
  /METHOD = SSTYPE(3)
  /INTERCEPT = INCLUDE
  /CRITERIA = ALPHA(.05)
  /DESIGN = lesion$ drug$ lesion$*drug$ .

UNIANOVA
  yc  BY lesion$ drug$
  /METHOD = SSTYPE(3)
  /INTERCEPT = INCLUDE
  /CRITERIA = ALPHA(.05)
  /DESIGN = lesion$ drug$ lesion$*drug$ .


****NOW WE ARE CONTRAST CODING THE RESEARCH FACTORS.
COMPUTE lesion_c = .5 .
IF (lesion$ = 'SHAM') lesion_c = -.5 .
COMPUTE drug_c = .5 .
IF (drug$ = 'PLACEBO') drug_c = -.5 .
COMPUTE lesdrg_c = lesion_c*drug_c .


REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT ya
  /METHOD=ENTER lesion_c drug_c lesdrg_c  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT yb
  /METHOD=ENTER lesion_c drug_c lesdrg_c  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT yc
  /METHOD=ENTER lesion_c drug_c lesdrg_c  .


****NOW WE CODE THE SAME EXPERIMENTAL CONDITIONS AS DUMMY VARIABLES

COMPUTE lesion_d = 0.
IF (lesion$ = 'SURGERY') lesion_d = 1.
COMPUTE drug_d = 0.
IF (drug$ = 'ACTIVE') drug_d = 1.
COMPUTE lesdrg_d = lesion_d*drug_d .
EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT ya
  /METHOD=ENTER lesion_d drug_d lesdrg_d  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT yb
  /METHOD=ENTER lesion_d drug_d lesdrg_d  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT yc
  /METHOD=ENTER lesion_d drug_d lesdrg_d  .








