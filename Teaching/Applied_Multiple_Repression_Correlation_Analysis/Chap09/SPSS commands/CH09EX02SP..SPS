*************************************************************
SPSS CODE FILE C09E02SP.SYC READS DATA FILE C0902DT.TXT
*************************************************************
CHAPTER 9 EXAMPLE 2 OF 4 HOSPITALS AND THREE TREATMENS CODED BY ALTERNATIVE METHODS
*************************************************************.
GET DATA  /TYPE = TXT
 /FILE = 'c:\ccwa\CHAP09\DATA\C0902DT.txt'
 /DELCASE = LINE
 /DELIMITERS = "\t"
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 HOSPITAL F1.0
 TREATMEN F1.0
 Y F16.2
 .
CACHE.
EXECUTE.
 .
*************************************************************
CODING THE 4 HOSPITALS WITH 3 EFFECTS CODES WHERE HOSITAL 4 IS THE OMITTED HOSPITAL. 
*************************************************************
THESE CODES MATCH TABLE 9.1.5  .
*************************************************************.
COMPUTE HOSP1E = 1 .
IF (hospital=2) OR (hospital=3) HOSP1E = 0 .
IF (hospital=4) HOSP1E = -1 .
EXECUTE .

COMPUTE HOSP2E = 1 .
IF (hospital=1) OR (hospital=3) HOSP2E = 0 .
IF (hospital=4) HOSP2E = -1 .
EXECUTE .

COMPUTE HOSP3E = 1 .
IF (hospital=1) OR (hospital=2) HOSP3E = 0 .
IF (hospital=4) HOSP3E = -1 .
EXECUTE .

*************************************************************
CODING THE THREE TREATMENS BY DUMMY CODES WITH CONTROL TREATMEN AS THE REFERENCE
*************************************************************
COMPUTE treat4d = 0 .
EXECUTE .
If (treatmen = 1) treat4D = 1.
EXECUTE.
COMPUTE treat5D = 0.
EXECUTE.
If (treatmen = 2) treat5D = 1.
EXECUTE.

*************************************************************
CODING THE SIX HOSPITAL BY TREATMEN INTERACTIONS AS PRODUCTS OF THE FIRST 5 HOSPITAL AND TREATMEN VARIABLES
*************************************************************

COMPUTE HbyTD6 = hosp1e*treat4d.
COMPUTE HbyTD7 = hosp1e*treat5d.
COMPUTE HbyTD8 = hosp2e*treat4d.
COMPUTE HbyTD9 = hosp2e*treat5d.
COMPUTE HbyTD10 = hosp3e*treat4d.
COMPUTE HbyTD11 = hosp3e*treat5d.

EXECUTE.

*************************************************************
CODING THE TREATMENS AS EFFECTS CODES WITH THE SECOND TREATMEN (#3) AS THE "OMITTED" CATEGORY
*************************************************************

COMPUTE treat4e = 0 .
IF (treatmen = 2) treat4e = 1.
IF (treatmen = 3) treat4e =- 1.
IF (treatmen = 1) treat5e = 1.
IF (treatmen = 2) treat5e = 0.
IF (treatmen = 3) treat5e = -1.

EXECUTE.

*************************************************************
CODING THE INTERACTIONS USING THE TREATMEN EFFECTS CODES
*************************************************************.
COMPUTE HbyTE6 = hosp1e*treat4e.
COMPUTE HbyTE7 = hosp1e*treat5e.
COMPUTE HbyTE8 = hosp2e*treat4e.
COMPUTE HbyTE9 = hosp2e*treat5e.
COMPUTE HbyTE10 = hosp3e*treat4e.
COMPUTE HbyTE11 = hosp3e*treat5e.
EXECUTE.

*************************************************************
THE FOLLOWING ANALYSES ARE THE EQUATIONS NECESSARY TO COMPUTE THE TYPE III EFFECTS WITH UNEQUAL n IN CELLS
*************************************************************
IN THESE ANALYSES WE MUST USE EFFECTS CODES FOR THE TREATMEN VARIABLES
*************************************************************.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER hosp1e hosp2e hosp3e treat4e treat5e hbyte6 hbyte7 hbyte8 hbyte9
  hbyte10 hbyte11  .

******The next analyses estimate the combined treatmen and interaction effects.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER treat4e treat5e hbyte6 hbyte7 hbyte8 hbyte9 hbyte10 hbyte11
  .

*****The next analyses examine the hospital and interactions.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER hosp1e hosp2e hosp3e hbyte6 hbyte7 hbyte8 hbyte9 hbyte10
  hbyte11  .

******The ANOVA estimates are determined by the subtraction method described
****** on page 362, see table 9.1.4.
****** The regression estimates on page 366 are produced in the following analysis.


