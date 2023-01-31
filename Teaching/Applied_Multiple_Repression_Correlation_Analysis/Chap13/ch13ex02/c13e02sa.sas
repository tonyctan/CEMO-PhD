*****************************************
*   SAS CODE FILE: C13E02SA.SAS
*   Reads data file C13E02DT.TXT
*   Chapter 13, Example 2
*   Data are modified from Aiken, West, Woodward, Reno, & Reynolds 
*      (1994), Health Psychology, 13, 526-538.
*   This example is of regression models for a polytomous dependent variable
*   with 4 ordered categories, Table 13.3.1.
*   Continuation category analysis: Table 13.3.1A,B,C.
*   Ordinal logistic regression: Table 13.3.1D (see SAS C13E02SA.SAS)
*   OLS regression, Table 13.3.1E
*   The dependent variable is a series of steps to compliance with 
*   mammography screening, STEPS4
*         1=Do nothing
*         2=some contact or discussion with health care provider
*         3=make appointment for mammogram
*         4=obtain mammogram
*   SAS syntax by Jonathan E. Butner, University of Utah 
*      to mirror C13E02SP.SPS by Leona S. Aiken
 *************************************************************;
options nocenter;

data c13e2;
  infile  'c:\ccwa\chap13\ch13ex02\c13e02dt.txt'missover;
  input case 1-5 steps4 6-10  TREATMNT 11-15;
run;

*********************************************
* Create the dependent variables for continuation category analysis
* in Table 13.3.1A, B, C (PAGE 521)
*********************************************;
data c13e2cc;
  set c13e2;
if steps4 >= 1 and steps4 <= 3 then s123v4 = 0;
if steps4 = 4 then s123v4 = 1;

proc freq;
  tables steps4*s123v4;
run;

data c13e2cc2;
  set c13e2cc;
if steps4 >= 1 and steps4 <= 2 then s12v3 = 0;
if steps4 = 3 then s12v3 = 1;
if steps4 = 4 then s12v3 = 4;

proc freq;
  tables steps4*s12v3;
run;

data c13e2cc3;
  set c13e2cc2;
if steps4 = 1 then s1v2 = 0;
if steps4 = 2 then s1v2 = 1;
if steps4 = 3 then s1v2 = 3;
if steps4 = 4 then s1v2 = 4;

proc freq;
  tables steps4*s1v2;
run;

***************************************
* Table 13.3.1A., obtain mammogram versus all lower steps
***************************************;

proc logistic descending simple data = c13e2cc3;
  model s123v4 = TREATMNT/ctable pprob=(.5) rsquare;
run;

***************************************
* Table 13.3.1B., make appointment versus all lower steps;
* eliminate the mammogram category (4), and compare
* category 3 versus 1 and 2   (PAGE 521)
*********************************************;

data c13e2v3;
  set c13e2cc3;
if (s12v3 lt 4);

proc logistic descending simple data = c13e2v3;
  model s12v3 = TREATMNT/ctable pprob=(.5) rsquare;
run;

***************************************
* Table 13.3.1C., speak to health professional versus do nothing
* eliminate the mammogram category (4), the appointment category (3)
* category 2 versus 1 
*********************************************;

data c13e2v2;
  set c13e2cc3;
if (s1v2 lt 3);

proc logistic descending simple data = c13e2v2;
  model s1v2 = TREATMNT/ctable pprob=(.5) rsquare;
run;

********************************************
* Table 13.3.1D, ordinal logistic regression,
* see SAS example C13E02SA.SAS
* predict steps to compliance as an ordinal variable
* with four ordered categories:

********************************************;
proc logistic descending simple data=c13e2cc3;
 model steps4=TREATMNT
     /sw printi rsquare;
run;
********************************************
* Table 13.3.1E, OLS regression
********************************************;

proc reg data = c13e2cc3;
  model steps4 = TREATMNT/stb;
run;
quit;
