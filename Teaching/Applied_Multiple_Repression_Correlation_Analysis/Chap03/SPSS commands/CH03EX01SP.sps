
*************************************************************
Chapter 3: TWO OR MORE INDEPEDENT VARIABLES
*************************************************************
Table 3.2.1  Senority, Publication, and Salary Data on 15 Faculty Members
*************************************************************

GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP03\DATA\C0301DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 TIME F2.1
 PUBS F2.1
 SALARY F5.2
 .
CACHE.
EXECUTE.

CORRELATIONS
  /VARIABLES=Time pubs salary
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE .

*First we do a regression of salary on time, then salary on publications, and finally, salary on time and publications.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER Time .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER pubs .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT salary
  /METHOD=ENTER Time pubs .


***Finally, we use the regression coefficients to calculate estimated salaries.
COMPUTE Estsal = (982.87 * tIME) + (121.80 * Pubs) + 43082.40.
EXECUTE.

***Residuals are the difference between the estimated and observed values.

COMPUTE ressal = salary - estsal . 

SUMMARIZE
  /TABLES=time pubs salary estsal ressal
  /FORMAT=VALIDLIST NOCASENUM TOTAL LIMIT=100
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=COUNT .

CORRELATIONS
  /VARIABLES=salary estsal ressal
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE .
