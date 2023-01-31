
********************************
* SPSS CODE FILE: C13E01SP.SPS
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
*   SPSS syntax by Leona S. Aiken
*   Slight discrepancies are observed between SPSS and SAS, since
*   logistic regression is an iterative procedure
********************************

****************************************
* TABLE 13.2.2, section I, page 495
****************************************

data list file='c:\ccwa\chap13\ch13ex01\c13e01dt.txt' fixed records=1
  /case 1-5 physrec 6-10 comply 11-15 knowledg (f8.2) benefits (f8.0)
  barriers (f8.0).
execute.

LOGISTIC REGRESSION comply
  /METHOD=ENTER physrec knowledg benefits barriers
  /print default ci(95).


*****************************************************************
* compute confidence intervals on the regression coefficients and
* on the corresponding odds ratios
* Numerical values given below are taken from the above
* logistic regression analysis, for example
         physb  =  estimated regression coefficient for PHYSREC
         physse =  estimated standared error of regression 
                   coefficient for PHYSREC
         physodd = odds ratio for PSYSREC             
* Note SPSS 10.07 gives confidence intervals on odds ratios
* but not on regression coefficients; syntax given here
* provides confidence intervals on both regression coefficients
* and odds ratios;
* alternative to computations given below is simply to take the
* natural log of each limit of an odds ratio to find the limits of
* the corresponding regression coefficient;
*****************************************************************

compute physb = 1.8422.
compute physse = .4884.
compute physodd = 6.3105.
compute knowb = -.0794.
compute knowse = 1.0735.
compute knowodd = .9237.
compute beneb = .5435.
compute benese = .2426.
compute beneodd = 1.7220.
compute barrb = -.5812.
compute barrse = .1660.
compute barrodd = .5592.
compute constb = -.30509.
compute constse = 1.3689.

compute z = 1.96.

*physician recommendation

compute allow = z*physse.
compute lower = physb - allow.
compute upper = physb + allow.
compute oddlower = exp(lower).
compute oddupper = exp(upper).
temporary.
select if (case eq 205).
list variables = physse physb lower upper physodd oddlower oddupper.


*knowledge.

compute allow = z*knowse.
compute lower = knowb - allow.
compute upper = knowb + allow.
compute oddlower = exp(lower).
compute oddupper = exp(upper).
temporary.
select if (case eq 205).
list variables = knowse knowb lower upper knowodd oddlower oddupper.


*benefits

compute allow = z*benese.
compute lower = beneb - allow.
compute upper = beneb + allow.
compute oddlower = exp(lower).
compute oddupper = exp(upper).
temporary.
select if (case eq 205).
list variables = benese beneb lower upper beneodd oddlower oddupper.

*barriers

compute allow = z*barrse.
compute lower = barrb - allow.
compute upper = barrb + allow.
compute oddlower = exp(lower).
compute oddupper = exp(upper).
temporary.
select if (case eq 205).
list variables =barrse barrb lower upper barrodd oddlower oddupper.


********************************************************
* Discriminant function analysis, Table 13.2.2, Section II, page 495
* The significant tests for the discriminant function coefficients are 
*  found in the table "Variables in the Analysis", 
*  for t-tests, use F to remove and take square roots of these F values 
*  to obtain t values in Table 13.2.2, Section II B;
*  Coefficients are "canonical discriminant function coefficients"
********************************************************

discriminant
   /groups=comply(0 1)
   /variables = physrec knowledg benefits barriers
   /analysis all
   /method=wilks
   /fin = .005
   /fout = .0005
   /priors size
   /statistics mean stddev univf coef raw fpair.

********************************************************
* Logistic regression in two steps to generate values required
* for likelihood ratio chi square test of contribution of
* barriers, above and beyond physrec, knowledge, and benefits
* for text, page 507, "likelihood ratio tests". The chi square
* value at step 1 with 1 df is the chi square
* value we seek, (e.g., for barriers, below, chi square = 13.77,
* which corresponds to chi square = 13.36 from SAS.
********************************************************

LOGISTIC REGRESSION comply
  /METHOD=ENTER physrec knowledg benefits
  /method=enter barriers.

********************************************************
* Logistic regressions in two steps to generate values required
* for likelihood ratio chi square test of unique contribution
* of each predictor above the other three predictors;
* logistic regression for barriers given just above
* for text, page 507, "likelihood ratio tests".
********************************************************

LOGISTIC REGRESSION comply
  /METHOD=ENTER physrec  benefits  barriers
  /method=enter knowledg.

LOGISTIC REGRESSION comply
  /METHOD=ENTER knowledg benefits  barriers
  /method=enter physrec.

LOGISTIC REGRESSION comply
  /METHOD=ENTER physrec knowledg  barriers  
  /method=enter benefits .

******************************************************************
*Study the effects of predictor scaling
*Create a benefits scale that has a one-unit range, BENEF1
*Create a physician recommendation scale that ranges from -1 to +1
*Logistic regressions for Table 13.2.4A, B, C, respectively (page 510)
******************************************************************

COMPUTE BENEF1 = BENEFITS/5.

RECODE PHYSREC (1=1)(0=-1) INTO physrc1.

LOGISTIC REGRESSION comply
  /METHOD=ENTER physrec  benefits.

LOGISTIC REGRESSION comply
  /METHOD=ENTER physrc1  benefits.

LOGISTIC REGRESSION comply
  /METHOD=ENTER physrec benef1.



************************************************************************
*descriptives to generate standardized (z) scores for Table 13.2.4D (page 510)
************************************************************************

descriptives variables = comply physrec benefits 
   /save.

*************************************************************************
*COMPLY     ZCOMPLY    Zscore(COMPLY)                                 164
*PHYSREC    ZPHYSREC   Zscore(PHYSREC)                                164
*BENEFITS   ZBENEFIT   Zscore(BENEFITS)                               164
*************************************************************************

LOGISTIC REGRESSION comply
  /METHOD=ENTER zphysrec zbenefit.


************************************************************************
*logistic regressions to generate classification tables in Table 13.2.5
* (page 517)
************************************************************************

LOGISTIC REGRESSION comply
  /METHOD=ENTER physrec knowledg benefits barriers
  /criteria= cut (.2).

LOGISTIC REGRESSION comply
  /METHOD=ENTER physrec knowledg benefits barriers
  /criteria= cut (.5).

LOGISTIC REGRESSION comply
  /METHOD=ENTER physrec knowledg benefits barriers
  /criteria= cut (.8).


