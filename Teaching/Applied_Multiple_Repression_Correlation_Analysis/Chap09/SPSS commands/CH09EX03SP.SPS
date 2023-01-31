
*************************************************************
Chapter 9 Example 3 testing Dweck's theory with 3 levels of attribution, 2 levels of difficulty and 2 levels of failure.
*************************************************************.
GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP09\DATA\C0903DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 ATTRIB F1.0
 DIFF F1.0
 FAIL F1.0
 Y F16.2
 .
CACHE.
EXECUTE.

SORT CASES BY attrib diff fail .
SPLIT FILE
  LAYERED BY attrib diff fail .

DESCRIPTIVES
  VARIABLES=y
  /STATISTICS=MEAN STDDEV MIN MAX .

SPLIT FILE
  OFF.

****************
Recoding as dummy variables
****************.

COMPUTE a1_d = 0 .
IF (attrib = 1)  a1_d =1 .
COMPUTE a2_d = 0 .
IF (attrib=3) a2_d = 1 .
COMPUTE d3_d = 0 .
IF (diff = 1) d3_d = 1 .
COMPUTE f4_d = 0 .
IF (fail = 1) f4_d = 1 .

***Coding 2 way interactions between dummy variables.
COMPUTE a1d3_d = a1_d*d3_d .
COMPUTE a2d3_d = a2_d*d3_d .
COMPUTE a1f4_d = a1_d*f4_d .
COMPUTE a2f4_d = a2_d*f4_d .
COMPUTE d3f4_d = d3_d*f4_d .
***Coding 3 way interactions between dummy variables.
COMPUTE a1d3f4_d = a1_d*d3_d*f4_d .
COMPUTE a2d3f4_d = a2_d*d3_d*f4_d .
EXECUTE .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER a1_d a2_d d3_d f4_d  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER a1_d a2_d d3_d f4_d a1d3_d a2d3_d a1f4_d a2f4_d d3f4_d  .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER a1_d a2_d d3_d f4_d a1d3_d a2d3_d a1f4_d a2f4_d d3f4_d
  a1d3f4_d  .


***Alternative methods of coding study conditions.

COMPUTE a1_u = 0 .
IF (attrib = 1) a1_u = 1.
IF (attrib = 2) a1_u = -1 .
COMPUTE a2_u = 0 .
IF (attrib = 2) a2_u = -1 .
IF (attrib = 3) a2_u = 1.
COMPUTE d3_u = 1.
IF (diff = 2) d3_u = -1 .
COMPUTE f4_u = 1 .
IF (fail = 2) f4_u =-1 .
COMPUTE a1d3_u = a1_u*d3_u .
COMPUTE a2d3_u = a2_u*d3_u .
COMPUTE a1f4_u = a1_u*f4_u .
COMPUTE a2f4_u = a2_u*f4_u .
COMPUTE d3f4_u = d3_u*f4_u .
COMPUTE a1d3f4_u = a1_u*d3_u*f4_u .
COMPUTE a2d3f4_u = a2_u*d3_u*f4_u .

EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER a1_u a2_u d3_u f4_u a1d3_u a2d3_u a1f4_u a2f4_u d3f4_u
  a1d3f4_u a2d3f4_u  .

***This analysis is equivalent to the ANOVA analysis.
***Coding by alternative methods omitting the triple interactions that did not contribute.




COMPUTE a1_w = 0 .
IF (attrib = 1) a1_w = 1 .
IF (attrib = 2) a1_w = -(37/46) .
COMPUTE a2_w = 0.
IF (attrib = 3) a2_w = 1 .
IF (attrib = 2) a2_w = -(37/46) .
COMPUTE d3_w = 1 .
IF (diff = 2) d3_w = -(56/64) .
COMPUTE f4_w = 1 .
IF (fail = 2) f4_w = -(61/59) .
COMPUTE a1d3_w = a1_w*d3_w .
COMPUTE a2d3_w = a2_w*d3_w .
COMPUTE a1f4_w = a1_w*f4_w .
COMPUTE a2f4_w = a2_w*f4_w .
COMPUTE d3f4_w = d3_w*f4_w .
COMPUTE a1d3f4_w = a1_w*d3_w*f4_w .
COMPUTE a2d3f4_w = a2_w*d3_w*f4_w .

COMPUTE a1_c = 0 .
IF (attrib = 1) a1_c = .5 .
IF (attrib = 3) a1_c = -.5 .
COMPUTE a2_c = -.5 .
IF (attrib = 2) a2_c = 1 .
COMPUTE d3_c = .5 .
IF (diff = 2) d3_c = -.5 .
COMPUTE f4_c = .5 .
IF (fail = 2) f4_c = -.5 .
COMPUTE a1d3_c = a1_c*d3_c .
COMPUTE a2d3_c = a2_c*d3_c .
COMPUTE a1f4_c = a1_c*f4_c .
COMPUTE a2f4_c = a2_c*f4_c .
COMPUTE d3f4_c = d3_c*f4_c .

EXECUTE.
 
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER a1_w a2_w d3_w f4_w a1d3_w a2d3_w a1f4_w a2f4_w d3f4_w   a1d3f4_w a2d3f4_w.

******Although the main effect and 2 way interactions coeffients are different from the previous codes, the highest
******order interactions would be the same.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER a1_c a2_c d3_c f4_c a1d3_c a2d3_c a1f4_c a2f4_c d3f4_c  .
