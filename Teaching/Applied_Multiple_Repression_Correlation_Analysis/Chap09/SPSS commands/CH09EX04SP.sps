**********************************
SPSS code file CH09EX04SP
**********************************
Chapter 9 Example 4 of Academic salary by department
**********************************.
GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP09\DATA\C0904DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 DEPART F1.0
 PUB F2.1
 TIME F2.1
 SALARY F16.2
 SEX F1.0
 .
CACHE.
EXECUTE.


SORT CASES BY depart .
SPLIT FILE
  LAYERED BY depart .

DESCRIPTIVES
  VARIABLES=salary
  /STATISTICS=MEAN STDDEV MIN MAX .


SPLIT FILE
  OFF.


COMPUTE d1 = 0 .
IF (depart=2) d1 = 1 .
COMPUTE d2 = 0 .
IF (depart=3) d2 = 1 .
EXECUTE .
COMPUTE pubd =pub - 15.5  .
COMPUTE pd1 = pubd*d1 .
COMPUTE pd2 = pubd*d2 .
EXECUTE .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER d1 d2 pub  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER d1 d2 pub pd1 pd2  .

***********************************
The next coding produces effects coded by department.
***********************************.

COMPUTE d1_e = -1 .
IF (depart=2) d1_e = 1 .
IF (depart=3) d1_e = 0 .
EXECUTE .

COMPUTE d2_e = -1 .
IF (depart=2) d2_e = 0 .
IF (depart=3) d2_e = 1 .
EXECUTE .


COMPUTE pd1_e = pubd*d1_e .
COMPUTE pd2_e = pubd*d2_e .
EXECUTE .



REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER d1_e d2_e pubd  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER d1_e d2_e pubd pd1_e pd2_e  .

*********************************
The next analyses code departments as contrasts.
*********************************.
COMPUTE d1_c = 0.333 .
IF (depart = 1) d1_c = .667 .
COMPUTE d2_c = 0 .
IF (depart = 2) d2_c = -0.5 .
IF (depart = 3) d2_c = 0.5 .
COMPUTE pd1_c = pubd*d1_c .
COMPUTE pd2_c = pubd*d2_c .
EXECUTE.


REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER d1_c d2_c pubd  .
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER d1_c d2_c pubd pd1_c pd2_c  .
