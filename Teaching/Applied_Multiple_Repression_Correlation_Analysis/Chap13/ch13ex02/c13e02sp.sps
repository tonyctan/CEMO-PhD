*****************************************
*   SPSS CODE FILE: C13E02SP.SPS
*   Reads data file C13E02DT.TXT
*   ICON PAGE 520
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
*   SPSS syntax by Leona S. Aiken
 *************************************************************

data list file=  'c:\ccwa\chap13\ch13ex02\c13e02dt.txt' records=1
     /1 case 1-5 steps4 6-10  TREATMNT 11-15.
execute.



*********************************************
* Create the dependent variables for continuation category analysis
* in Table 13.3.1A, B, C (page 521)
*********************************************

recode steps4 (1,2,3=0)(4=1) into s123v4.
crosstabs tables=steps4 by s123v4.

recode steps4 (1,2=0)(3=1)(4=4) into s12v3.
crosstabs tables=steps4 by s12v3.

recode steps4 (1=0)(2=1)(3=3)(4=4) into s1v2.
crosstabs tables=steps4 by s1v2.

***************************************
* Table 13.3.1A., obtain mammogram versus all lower steps {page 521)
***************************************

LOGISTIC REGRESSION s123v4
  /METHOD=ENTER TREATMNT .

***************************************
* Table 13.3.1B., make appointment versus all lower steps;
* eliminate the mammogram category (4), and compare
* category 3 versus 1 and 2  (page 521)
*********************************************

temporary.
select if (s12v3 lt 4).
LOGISTIC REGRESSION s12v3
  /METHOD=ENTER treatmnt.

***************************************
* Table 13.3.1C., speak to health professional versus do nothing
* eliminate the mammogram category (4), the appointment category (3)
* category 2 versus 1 (page 521)
*********************************************

temporary.
select if (s1v2 lt 3).
LOGISTIC REGRESSION s1v2
  /METHOD=ENTER treatmnt.

********************************************
* Table 13.3.1D, ordinal logistic regression,
* see SAS example C13E02SA.SAS   (page 521)
********************************************

********************************************
* Table 13.3.1E, OLS regression   (page 521)
********************************************

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT steps4
  /METHOD=ENTER TREATMNT  .


