********************************
* SAS CODE FILE: C13E01SA.SAS
* Reads data file C13E01DT.TXT
* ICON PAGE 496
* Chapter 13, Example 1
* Logistic regression. Contains 164 cases, all complete.
* Example in Table 13.2.2 (overall analysis)
*            Table 13.2.3 (fit indices)
             Table 13.2.4 (effects of predictor scaling)
             Table 13.2.5 (classification)
*   Data are sampled from Aiken, West, Woodward, and Reno (1994), 
*   Health Psychology, 13(2), 122-129.
*   SAS syntax by Jonathan E. Butner, University of Utah and Leona S. Aiken
*   Slight discrepancies are observed between SPSS and SAS, since logistic 
*         regression is an iterative procedure;
********************************;
options nocenter;

data c13e1;
  infile 'c:\ccwa\chap13\ch13ex01\c13e01dt.txt';
  input case 1-5 physrec 6-10 comply 11-15 knowledg 16-23 benefits 24-31
  barriers 32-39;
run;

****************************************
*  TABLE 13.2.2, section I, page 495
****************************************;

proc logistic data = c13e1 descending simple;
  model comply = physrec knowledg benefits barriers/ctable pprob=(.5) rsquare;
run;

*****************************************************************
* compute confidence intervals on the regression coefficients and
* on the corresponding odds ratios
* Numerical values given below are taken from the above
* logistic regression analysis, for example
         physb  =  estimated regression coefficient for PHYSREC
         physse =  estimated standared error of regression 
                   coefficient for PHYSREC
         physodd = odds ratio for PSYSREC             
* Note SAS gives confidence intervals on odds ratios (labeled
* "Wald confidence limits" in output). SAS does not give
* confidence intervals on the regression coefficients.
* The syntax given here provides confidence intervals on both 
* regression coefficients and odds ratios;
* alternative to computations given below is simply to take the
* natural log of each limit of an odds ratio to find the limits of
* the corresponding regression coefficient;
*****************************************************************;

data c13e1ci;
  set c13e1;
physb = 1.8422;
physse = .4884;
physodd = 6.3105;
knowb = -.0794;
knowse = 1.0735;
knowodd = .9237;
beneb = .5435;
benese = .2426;
beneodd = 1.7220;
barrb = -.5812;
barrse = .1660;
barrodd = .5592;
constb = -.30509;
constse = 1.3689;

z = 1.96;
run;

*physician recommendation;

data c13e1pr;
  set c13e1ci;
allow = z*physse;
lower = physb - allow;
upper = physb + allow;
oddlower = exp(lower);
oddupper = exp(upper);
run;

data c13e1pr2;
  set c13e1pr;
  if (case eq 205);
proc print;
  var physse physb lower upper physodd oddlower oddupper;
run;

*knowledge;

data c13e1kn;
  set c13e1ci;
allow = z*knowse;
lower = knowb - allow;
upper = knowb + allow;
oddlower = exp(lower);
oddupper = exp(upper);
run;

data c13e1kn2;
  set c13e1kn;
  if (case eq 205);
proc print;
  var knowse knowb lower upper knowodd oddlower oddupper;
run;

*benefits;

data c13e1be;
  set c13e1ci;
allow = z*benese;
lower = beneb - allow;
upper = beneb + allow;
oddlower = exp(lower);
oddupper = exp(upper);
run;

data c13e1be2;
  set c13e1be;
if(case eq 205);
proc print;
  var benese beneb lower upper beneodd oddlower oddupper;
run;

*barriers;

data c13e1ba;
  set c13e1ci;
allow = z*barrse;
lower = barrb - allow;
upper = barrb + allow;
oddlower = exp(lower);
oddupper = exp(upper);
run;

data c13e1ba2;
  set c13e1ba;
if(case eq 205);
proc print;
var barrse barrb lower upper barrodd oddlower oddupper;
run;

**********************************************************
*Discriminant function analysis, Table 13.2.2, Section II (page 495)
*We use two different SAS procedures to generate the discriminant 
*function coefficients and the t-tests for these coefficients: 
*We use "proc discrim" to generate discriminant function coefficients
*and "proc reg" to generate significance tests for discriminant
*function coefficients. Note that the OLS regression coefficients
*predicting the binary dependent variable "comply" from the set of
*predictors are linearly related to the discriminant function 
*coefficients. The t-tests for the two sets of coefficients
*(regression, discriminant) are identical. 
********************************************************;

********************************************************
* from "proc discrim" output, the discriminant function coefficients 
* given in Table 13.2.2, Section II (page 495)
* are listed under "raw canonical coefficients, can1"
********************************************************;

proc discrim data=c13e1 anova manova canonical;
     class comply;
	 var physrec knowledg benefits barriers;
	 run;

******************************************************
* from "proc reg" the t tests for the regression coefficients
* are the same values as the t tests for the discriminant function
* coefficients given in Table 13.2.2, Section II (page 495)
*******************************************************;

proc reg data=c13e1;
   model comply=physrec knowledg benefits barriers;
   run;

********************************************************
* Logistic regression in two steps to generate values required
* for likelihood ratio chi square test of contribution of
* barriers, above and beyond physrec, knowledge, and benefits
* for text, page 507, "likelihood ratio tests". The chi square
* value for the variable added at step 1 is the chi square
* value we seek, (e.g., for barriers, below, chi square = 13.36,
* which corresponds to chi square = 13.77 from SPSS.
********************************************************;

proc logistic data = c13e1 descending simple;
  model comply = physrec knowledg benefits barriers 
  /selection=forward include=3 sle=.9999 ctable pprob=(.5) rsquare;
run;

********************************************************
* Logistic regressions in two steps to generate values required
* for likelihood ratio chi square test of unique contribution
* of each predictor above the other three predictors.
* logistic regression for barriers given just above.
* for text, page 507, "likelihood ratio tests".
********************************************************;

proc logistic data = c13e1 descending simple;
  model comply = physrec benefits barriers knowledg 
  /selection=forward include=3 sle=.9999 ctable pprob=(.5) rsquare;
run;

proc logistic data = c13e1 descending simple;
  model comply = benefits barriers knowledg physrec
  /selection=forward include=3 sle=.9999 ctable pprob=(.5) rsquare;
run;

proc logistic data = c13e1 descending simple;
  model comply = physrec barriers knowledg benefits
  /selection=forward include=3 sle=.9999 ctable pprob=(.5) rsquare;
run;

******************************************************************
*Study the effects of predictor scaling
*Create a benefits scale that has a one-unit range, BENEF1
*Create a physician recommendation scale that ranges from -1 to +1
*Logistic regressions for Table 13.2.4A, B, C, respectively (page 510)
******************************************************************;

data c13e1sc;
  set c13e1;
BENEF1 = BENEFITS/5;
if PHYSREC = 1 then physrc1=1;
if PHYSREC = 0 then physrc1=-1;

proc logistic data = c13e1sc descending simple;
  model comply = physrec benefits/ctable pprob=(.5) rsquare;
run;

proc logistic data = c13e1sc descending simple;
  model comply = physrc1 benefits/ctable pprob=(.5) rsquare;
run;

proc logistic data = c13e1sc descending simple;
  model comply = physrec benef1/ctable pprob=(.5) rsquare;
run;


*******************************************************
* Use proc means to get means and standard deviations for forming z-scores
* for Table  13.2.4 (page 510)
*******************************************************;

proc means data=c13e1;
   var  comply physrec benefits;
   run;

***********************************************************
* Output of proc means copied here for standardizing variables
*
*   The MEANS Procedure
*
*Variable      N            Mean         Std Dev         Minimum         Maximum
*
*comply      164       0.4634146       0.5001870               0       1.0000000
*physrec     164       0.6890244       0.4643106               0       1.0000000
*benefits    164       4.1646341       1.0348376               0       5.0000000
***********************************************************;

data zscores;
set c13e1;
zcomply = (comply-.4634146)/.5001870;
zphysrec = (physrec-.6890244)/.4643106;
zbenefit=(benefits-4.1646341)/1.0348376;
run;

*****************************************************
* experimenting with logistic regression with standardized variables
* Table 13.2.4 (page 510)
*****************************************************;

proc logistic data = zscores descending simple;
  model zcomply = zphysrec zbenefit
  /ctable pprob=(.5) rsquare;
run;


************************************************************************
*logistic regressions to generate classification tables in Table 13.2.5
* (page 517)
************************************************************************;

proc logistic data = c13e1 descending simple;
  model comply = physrec knowledg benefits barriers
  /ctable pprob=(.2 to .8 by .3);
run;
quit;
