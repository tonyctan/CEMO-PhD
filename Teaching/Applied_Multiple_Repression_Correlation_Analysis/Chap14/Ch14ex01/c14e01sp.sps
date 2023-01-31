***********************************************
* SPSS CODE FILE: C14E0SP.SPS
* Reads data file C14E01DT.TXT
* ICON PAGE 541
* Multilevel data set of pounds lost as a function of
* motivation to lose weight and treatment
* disaggregated analysis (Table 14.2.1a) plus
*Disaggregated analysis with group structure controlled 
*     (Table 14.2.1c)
* SPSS syntax by Leona S. Aiken
************************************************

data list file='c:\ccwa\chap14\ch14ex01\c14e01dt.txt' fixed records=1
  /group 1-2 caseingr 3-5 treat 6-7 treatc (f9.5) motivat 17-18
   motivatc (f9.5) pounds 28-30.
execute.


***************************************************
* Disaggregated regression analysis of individual cases
* ignoring group structure for
* Table 14.2.1A (page 542)
***************************************************

REGRESSION
  /variables=pounds motivatc
  /MISSING LISTWISE
  /descriptives=mean stddev
  /STATISTICS COEFF OUTS R ANOVA
  /DEPENDENT pounds
  /METHOD=ENTER motivatc.

*************************************************
* Compute group codes, for dummy variables
* representing the groups, for analysis in Table 14.2.1c; (page 542)
* (aggregated analysis of Table 14.2.1B given in CH14EX02)
*************************************************

compute gr1=0.
compute gr2=0.
compute gr3=0.
compute gr4=0.
compute gr5=0.
compute gr6=0.
compute gr7=0.
compute gr8=0.
compute gr9=0.
compute gr10=0.
compute gr11=0.
compute gr12=0.
compute gr13=0.
compute gr14=0.
compute gr15=0.
compute gr16=0.
compute gr17=0.
compute gr18=0.
compute gr19=0.
compute gr20=0.
compute gr21=0.
compute gr22=0.
compute gr23=0.
compute gr24=0.
compute gr25=0.
compute gr26=0.
compute gr27=0.
compute gr28=0.
compute gr29=0.
compute gr30=0.
compute gr31=0.
compute gr32=0.
compute gr33=0.
compute gr34=0.
compute gr35=0.
compute gr36=0.
compute gr37=0.
compute gr38=0.
compute gr39=0.

if (group eq 1) gr1=1.
if (group eq 2) gr2=1.
if (group eq 3) gr3=1.
if (group eq 4) gr4=1.
if (group eq 5) gr5=1.
if (group eq 6) gr6=1.
if (group eq 7) gr7=1.
if (group eq 8) gr8=1.
if (group eq 9) gr9=1.
if (group eq 10) gr10=1.
if (group eq 11) gr11=1.
if (group eq 12) gr12=1.
if (group eq 13) gr13=1.
if (group eq 14) gr14=1.
if (group eq 15) gr15=1.
if (group eq 16) gr16=1.
if (group eq 17) gr17=1.
if (group eq 18) gr18=1.
if (group eq 19) gr19=1.
if (group eq 20) gr20=1.
if (group eq 21) gr21=1.
if (group eq 22) gr22=1.
if (group eq 23) gr23=1.
if (group eq 24) gr24=1.
if (group eq 25) gr25=1.
if (group eq 26) gr26=1.
if (group eq 27) gr27=1.
if (group eq 28) gr28=1.
if (group eq 29) gr29=1.
if (group eq 30) gr30=1.
if (group eq 31) gr31=1.
if (group eq 32) gr32=1.
if (group eq 33) gr33=1.
if (group eq 34) gr34=1.
if (group eq 35) gr35=1.
if (group eq 36) gr36=1.
if (group eq 37) gr37=1.
if (group eq 38) gr38=1.
if (group eq 39) gr39=1.

**********************************************
* Regression analysis of individual cases controlling
* for group structure with a set of dummy codes
* for Table 14.2.1C. (page 542)
**********************************************

REGRESSION
  /variables= gr1 gr2 gr3 gr4 gr5 gr6 gr7 gr8 gr9 gr10
              gr11 gr12 gr13 gr14 gr15 gr16 gr17 gr18 gr19 gr20
              gr21 gr22 gr23 gr24 gr25 gr26 gr27 gr28 gr29 gr30
              gr31 gr32 gr33 gr34 gr35 gr36 gr37 gr38 gr39 motivatc pounds
  /MISSING LISTWISE
  /descriptives=mean stddev
  /STATISTICS COEFF OUTS R ANOVA
  /NOORIGIN
  /DEPENDENT pounds
  /METHOD=ENTER gr1 gr2 gr3 gr4 gr5 gr6 gr7 gr8 gr9 gr10
                gr11 gr12 gr13 gr14 gr15 gr16 gr17 gr18 gr19 gr20
                gr21 gr22 gr23 gr24 gr25 gr26 gr27 gr28 gr29 gr30
                gr31 gr32 gr33 gr34 gr35 gr36 gr37 gr38 gr39
  /method=enter motivatc  .

