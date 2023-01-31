***********************************************
*SAS CODE FILE: C14E01SA.SAS\
*Reads data file C14E01DT.TXT
*ICON PAGE 542
*Multilevel data set of pounds lost as a function of
*motivation to lose weight and treatment
*Disaggregated analysis (Table 14.2.1a) plus
*Disaggregated analysis with group structure controlled 
*     (Table 14.2.1c)
* SAS syntax by Jonathan E. Butner, University of Utah
*   to mirror C14E01S.SPS by Leona S. Aiken
************************************************;
options nocenter;

data c14e1;
  infile 'c:\ccwa\Chap14\Ch14ex01\C14e01dt.txt';
  input group 1-2 caseingr 3-5 treat 6-7 treatc 8-16 motivat 17-18
   motivatc 19-27 pounds 28-30;
run;

***************************************************
* Disaggregated regression analysis of individual cases
* ignoring group structure for
* Table 14.2.1A  (page 542)
***************************************************;

proc reg simple data = c14e1;
  model pounds = motivatc/stb;
run;

*************************************************
* group codes, for dummy variables
* representing the groups, for analysis in Table 14.2.1c  (page 542)
* (aggregated analysis of Table 14.2.1B given in CH14EX02)
*************************************************;

data c14e1du;
  set c14e1;
gr1=0;
gr2=0;
gr3=0;
gr4=0;
gr5=0;
gr6=0;
gr7=0;
gr8=0;
gr9=0;
gr10=0;
gr11=0;
gr12=0;
gr13=0;
gr14=0;
gr15=0;
gr16=0;
gr17=0;
gr18=0;
gr19=0;
gr20=0;
gr21=0;
gr22=0;
gr23=0;
gr24=0;
gr25=0;
gr26=0;
gr27=0;
gr28=0;
gr29=0;
gr30=0;
gr31=0;
gr32=0;
gr33=0;
gr34=0;
gr35=0;
gr36=0;
gr37=0;
gr38=0;
gr39=0;

if (group eq 1) then gr1=1;
if (group eq 2) then gr2=1;
if (group eq 3) then gr3=1;
if (group eq 4) then gr4=1;
if (group eq 5) then gr5=1;
if (group eq 6) then gr6=1;
if (group eq 7) then gr7=1;
if (group eq 8) then gr8=1;
if (group eq 9) then gr9=1;
if (group eq 10) then gr10=1;
if (group eq 11) then gr11=1;
if (group eq 12) then gr12=1;
if (group eq 13) then gr13=1;
if (group eq 14) then gr14=1;
if (group eq 15) then gr15=1;
if (group eq 16) then gr16=1;
if (group eq 17) then gr17=1;
if (group eq 18) then gr18=1;
if (group eq 19) then gr19=1;
if (group eq 20) then gr20=1;
if (group eq 21) then gr21=1;
if (group eq 22) then gr22=1;
if (group eq 23) then gr23=1;
if (group eq 24) then gr24=1;
if (group eq 25) then gr25=1;
if (group eq 26) then gr26=1;
if (group eq 27) then gr27=1;
if (group eq 28) then gr28=1;
if (group eq 29) then gr29=1;
if (group eq 30) then gr30=1;
if (group eq 31) then gr31=1;
if (group eq 32) then gr32=1;
if (group eq 33) then gr33=1;
if (group eq 34) then gr34=1;
if (group eq 35) then gr35=1;
if (group eq 36) then gr36=1;
if (group eq 37) then gr37=1;
if (group eq 38) then gr38=1;
if (group eq 39) then gr39=1;
run;

**********************************************
* Regression analysis of individual cases controlling
* for group structure with a set of dummy codes
* for Table 14.2.1C. (page 542)
**********************************************;

proc reg simple data = c14e1du;
  model pounds =gr1 gr2 gr3 gr4 gr5 gr6 gr7 gr8 gr9 gr10
                gr11 gr12 gr13 gr14 gr15 gr16 gr17 gr18 gr19 gr20
                gr21 gr22 gr23 gr24 gr25 gr26 gr27 gr28 gr29 gr30
                gr31 gr32 gr33 gr34 gr35 gr36 gr37 gr38 gr39/stb;
  model pounds =gr1 gr2 gr3 gr4 gr5 gr6 gr7 gr8 gr9 gr10
                gr11 gr12 gr13 gr14 gr15 gr16 gr17 gr18 gr19 gr20
                gr21 gr22 gr23 gr24 gr25 gr26 gr27 gr28 gr29 gr30
                gr31 gr32 gr33 gr34 gr35 gr36 gr37 gr38 gr39
                motivatc/stb;
  test motivatc;
run;
quit;
