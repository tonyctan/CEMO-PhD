****************************
SPSS code file CH09EX05SP 
****************************
Chapter 9 Example 5 and Table 9.3.5 of Academic salary in three departments.
****************************.
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

****************************
IN THESE CODES WE PREPARE TO MODEL THE SIMPLE SLOPES IN THREE DEPARTMENTS
****************************.
COMPUTE pubd = pub - 15.5 .
EXECUTE .
COMPUTE D1 = 0 .
IF (depart = 2) D1 = 1 .
COMPUTE D2 = 0 .
IF (depart = 3) D2 = 1 .
COMPUTE sd1 = 0 .
IF (depart = 1) sd1 = pubd .
COMPUTE SD2 = 0 .
IF (depart = 2) sd2 = pubd .
COMPUTE SD3 = 0 .
IF (depart = 3) sd3 = pubd .
EXECUTE.



REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER pubd d1 d2  .
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER pubd d1 d2 sd1 sd2 sd3  .
