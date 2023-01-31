
*************************************************************
Chapter 2: BIVARIATE CORRELATION AND REGRESSION
*************************************************************
Table 2.3.2  Fourfold Frequencies for Candidate Prefernce and Homeowning Status
*************************************************************

GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP02\DATA\C0204DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 HOMEOWNE F1.2
 CANDIDAT F1.2
 .

DESCRIPTIVES
  VARIABLES=homeowne candidat
  /STATISTICS=MEAN STDDEV MIN MAX .

CROSSTABS
  /TABLES= homeowne  BY candidat
  /FORMAT= AVALUE TABLES
  /STATISTIC=PHI CORR
  /CELLS= COUNT .
