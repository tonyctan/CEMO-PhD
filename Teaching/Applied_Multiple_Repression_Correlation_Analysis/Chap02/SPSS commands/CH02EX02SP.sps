*************************************************************
Chapter 2: BIVARIATE CORRELATION AND REGRESSION
*************************************************************
Table 2.2.2  z Scores, z Score Differences, and z Score Products on Data Example
*************************************************************

GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP02\Data\C0202DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 TIME F2.1
 PUBS F2.1
 .
CACHE.
EXECUTE.

DESCRIPTIVES
  VARIABLES=time pubs  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .


COMPUTE zdiff = ztime-zpubs .
EXECUTE .

COMPUTE zXzY = ztime*zpubs .
EXECUTE .

COMPUTE zdiffsq = (ztime-zpubs)*(ztime-zpubs) .
EXECUTE .

SUMMARIZE
  /TABLES=time pubs ztime zpubs zdiff zxzy 
  /FORMAT=VALIDLIST NOCASENUM TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=COUNT SUM MEAN STDDEV .

DESCRIPTIVES
  VARIABLES=time pubs ztime zpubs zdiff zXzY zdiffsq
  /STATISTICS=MEAN SUM STDDEV.

CORRELATIONS
  /VARIABLES=time pubs
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=PAIRWISE .
DESCRIPTIVES
  VARIABLES=time pubs  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .
