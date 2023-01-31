*************************************************************
Chapter 2: BIVARIATE CORRELATION AND REGRESSION
*************************************************************
Table 2.2.1  Income and Major Household Appliances in Original Units, Deviation Units, and z Scores
************************************************************* .

GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP02\DATA\C0201DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 INCOME F5.2
 APPLIANC F1.0
 .
CACHE.
EXECUTE.

DESCRIPTIVES
  VARIABLES= income applianc / SAVE
  /STATISTICS= SUM MEAN VARIANCE STDDEV .

COMPUTE incc = income-MEAN(24000, 29000, 27000, 30000) .
COMPUTE applc = applianc-MEAN(3,7,4,5) .
COMPUTE inc2 = incc*incc .
COMPUTE applc2 = applc*applc .
EXECUTE .

RANK
  VARIABLES= income applianc (A) /RANK /PRINT=YES
  /TIES=MEAN .

COMPUTE zinc2 = zincome*zincome .
EXECUTE .

COMPUTE zappl2 = zapplian*zapplian .
EXECUTE .

DESCRIPTIVES
  VARIABLES=income applianc zincome zapplian incc applc inc2 applc2 rincome
  rapplian zinc2
  /STATISTICS=MEAN SUM STDDEV .

GRAPH
  /SCATTERPLOT(BIVAR)= income WITH applianc
  /MISSING=LISTWISE
  /TITLE= 'Fig. 2.2.1 (using original units)'.


GRAPH
  /SCATTERPLOT(BIVAR)= zincome WITH zapplian  /MISSING=LISTWISE
  /TITLE= 'Fig. 2.2.1 (using z scores)'.
