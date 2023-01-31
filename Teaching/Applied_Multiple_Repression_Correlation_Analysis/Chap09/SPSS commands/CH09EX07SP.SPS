**************************
SPSS code file CH09EX07SP
**************************
Chapter 9 Example 7 and Table 9.3.5 of Academic salary in three departments
**************************.
GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP09\DATA\C0907DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 DEPART F1.0
 PUB F2.1
 TIME F2.1
 SALARYX F16.2
 SEX F1.0
 .
CACHE.
EXECUTE.

**************************
Centering Time and squaring
**************************.
COMPUTE TIMEC = TIME - 8.09 .
EXECUTE .
COMPUTE TIMEC2 = timec*timec .
EXECUTE .

SORT CASES BY depart .
SPLIT FILE
  LAYERED BY depart .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salaryx
  /METHOD=ENTER timec timec2  .

SPLIT FILE
  OFF.

COMPUTE D1 = 0 .
IF (depart = 2) d1 = 1 .
COMPUTE D2 = 0 .
IF (depart = 3) d2 = 1 .
COMPUTE TIMED1 = timec*d1 .
COMPUTE TIMED2 = timec*d2 .
COMPUTE TIME2D1 = timec2*d1 .
COMPUTE TIME2D2 = timec2*d2 .
EXECUTE .


****************************
The following analyses produce Table 9.3.8 .
**************************** .
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salaryx
  /METHOD=ENTER d1 d2 timec  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salaryx
  /METHOD=ENTER d1 d2 timec timec2 timed1 timed2 time2d1 time2d2  .



