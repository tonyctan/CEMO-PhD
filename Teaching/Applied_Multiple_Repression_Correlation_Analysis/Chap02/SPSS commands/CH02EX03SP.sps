
*************************************************************
Chapter 2: BIVARIATE CORRELATION AND REGRESSION
*************************************************************
Table 2.3.1  Correlation Between a Dichotomous and a Scales Variable
*************************************************************

GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP02\DATA\C0203DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 STIMULUS A4
 TASK F2.1
 .
CACHE.
EXECUTE.

*****First we turn the 2-category variable into a numeric variable.

COMPUTE stima=0.
IF (stimulus='Stim') stima=1 .

****Then we standardize the variables.

DESCRIPTIVES
  VARIABLES=stima task  /SAVE
  /STATISTICS=MEAN STDDEV .

*****Suppose we choose a different 2 values for coding the binary variable.

COMPUTE stimb=50.
IF (stimulus='Stim') stimb=20 .

DESCRIPTIVES
  VARIABLES=stimb  /SAVE
  /STATISTICS=MEAN STDDEV .

COMPUTE ZyZa = ztask*zstima .
COMPUTE ZyZb = ztask*zstimb .
EXECUTE .


CORRELATIONS
  /VARIABLES= task stima stimb
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=PAIRWISE .

****So it really doesn't matter which 2 values were selected


SORT CASES BY stimulus .
SPLIT FILE
  SEPARATE BY stimulus .

DESCRIPTIVES
  VARIABLES=  task  
  /STATISTICS=MEAN STDDEV MIN MAX .

SPLIT FILE
  OFF.

