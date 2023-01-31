***************************
SPSS code file CH09EX6SP 
***************************
Chapter 9 Example 6 and Table 9.3.5 of academic salary in three departments
***************************.
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

COMPUTE pubd = pub - 15.5 .
COMPUTE pub_20 = pub - 20 .
COMPUTE pub_10 = pub - 10 .
COMPUTE d1 = 0 .
IF (depart = 2) d1 = 1.
COMPUTE d2 = 0.
IF (depart = 3) d2 = 1 .
COMPUTE pubd = pub - 15.5 .
COMPUTE pd1 = pubd*d1 .
COMPUTE pd2 = pubd*d2 .
COMPUTE pd1_20 = pub_20*d1 .
COMPUTE pd2_20 = pub_20*d2 .
COMPUTE pd1_10 = pub_10*d1 .
COMPUTE pd2_10 = pub_10*d2 .

EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER pubd d1 d2 pd1 pd2  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER d1 d2 pub_20 pd1_20 pd2_20  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER d1 d2 pub_10 pd1_10 pd2_10  .


 
