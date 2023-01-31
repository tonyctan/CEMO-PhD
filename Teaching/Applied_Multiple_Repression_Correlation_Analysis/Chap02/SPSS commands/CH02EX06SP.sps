
*************************************************************
Chapter 2: BIVARIATE CORRELATION AND REGRESSION
*************************************************************
Table 2.6.1  Estimated and REsidual Scores for Academic Example
*************************************************************

GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP02\DATA\C0206DT.txt'
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

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT pubs
  /METHOD=ENTER Time  .

***** We use the regression estimates obtained above to create estimated publications for each case.

COMPUTE Estpubs = 4.731 + 1.983 * time.
COMPUTE Respubs = pubs  -  estpubs .
EXECUTE .
FORMAT Estpubs  Respubs (F8.2).

*This saves the standardized variables for time and pubs.
DESCRIPTIVES
  VARIABLES=time pubs  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .

COMPUTE Respubs = Pubs - Respubs.
COMPUTE Estzpubs = .657 * Ztime.
COMPUTE Reszpubs = Zpubs - Estzpubs.
FORMAT Estzpubs Reszpubs (F8.2).
EXECUTE.


*This uses the means obtained above to calculate estimates of Pubs if the slope was 2.0 (W) or 1.9 (V).
COMPUTE Estpubw = 2 * (Time - 7.667) + 19.933.
COMPUTE Respubw = Pubs - Estpubw.
COMPUTE Estpubv = 1.9 * (Time - 7.667) + 19.933.
COMPUTE Respubv = Pubs - Estpubv.
FORMAT Estpubw Respubw Estpubv Respubv (F8.2).
EXECUTE.

*This create absolute value variables for residuals.
COMPUTE Absrest = ABS (Respubs).
COMPUTE Absresw = ABS (Respubw).
COMPUTE Absresv = ABS (Respubv).
FORMAT Absrest Absresw Absresv  (F8.2).
EXECUTE.

SUMMARIZE
  /TABLES=Time Pubs estpubs respubs zpubs ztime estzpubs reszpubs 
  /FORMAT=VALIDLIST NOCASENUM TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=COUNT .

DESCRIPTIVES
  VARIABLES=time pubs estpubs respubs estzpubs,
   reszpubs  estpubw respubw estpubv respubv Absrest absresw absresv 
  /STATISTICS=MEAN SUM STDDEV VARIANCE .
COMPUTE Respubs = pubs  -  estpubs .
EXECUTE .
