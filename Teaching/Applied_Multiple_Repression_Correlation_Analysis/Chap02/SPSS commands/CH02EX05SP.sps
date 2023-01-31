
*************************************************************
Chapter 2: BIVARIATE CORRELATION AND REGRESSION
*************************************************************
Table 2.3.3  Correlation Between Two Sets of Ranks
*************************************************************

GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP02\DATA\C0205DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 X F1.0
 Y F1.0
 .
CACHE.
EXECUTE.

****The rank correlation equals the product-moment r providing there are no tied ranks.

COMPUTE D2 = (x-y)*(x-y) .
DESCRIPTIVES
  VARIABLES=d2
  /STATISTICS=SUM .

****** To get the rank R multiply the sum of D2 by 6 and divide by N (N2-1) and subtract this from one. 
****** Since N was 5 in this example 5(25-1) = 120 .
******1-(26*6)/120 .


CORRELATIONS
  /VARIABLES=x y
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE .
