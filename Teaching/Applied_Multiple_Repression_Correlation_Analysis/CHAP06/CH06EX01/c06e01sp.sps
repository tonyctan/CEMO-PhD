
*******************************************
* SPSS CODE FILE:C06E01SP.SPS
* Reads data file:  C06E01DT.TXT
* ICON CH06EX01, page 202
* Chapter 6, Example 1
* This example is of 100 cases, X normally distributed, generated
*   as a second order polynomial equation
*   Figure 6.1.1, 6.2.2a, 6.2.2b, Table 6.2.1 for uncentered data
*   Figure 6.2.3, Table 6.2.2 for centered data
* SPSS syntax by Leona S. Aiken
*******************************************
            
data list file='c:\ccwa\chap06\ch06ex01\c06e01dt.txt'fixed records=1
    /1  case (f4.0)  x1 (f8.0)  ybr (f10.4).
execute.

*************************************
*  find the mean of x1 to center x1.
*************************************

descriptives variables = x1.

*********************************************
* center x1.
* create x1c2, the square of x1 centered.
* create x1c3, the cube of x1 centered.
* create x12, the square of x1 uncentered.
* create x13, the cube of x1 uncentered.
*********************************************

compute x1c = x1 - 8.17.
compute x1c2 = x1c**2.
compute x1c3 = x1c**3.
compute x12  = x1**2.
compute x13  = x1**3.

****************************************************************
* regression with uncentered variables
* to generate Figure 6.1.1 (page 194), and Table 6.2.1 (page 200)
* linear equation,
* quadratic equation, cubic equation.
* save predicted scores from  uncentered linear, quadratic equations.
****************************************************************

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CI
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT ybr
  /METHOD=ENTER x1
  /SAVE pre_1(PREDulin).

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CI
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT ybr
  /METHOD=ENTER x1 x12
  /SAVE pre_1(PREDuqua).

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHA CI
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT ybr
  /METHOD=ENTER x1
  /method=enter x12
  /method=enter x13.

GRAPH
  /SCATTERPLOT(OVERLAY)=x1 x1 x1  WITH ybr predulin preduqua (PAIR)
  /MISSING=LISTWISE
  /TITLE= 'Figure 6.1.1, uncentered'.

*******************************************************************************************
* Alternative approach to viewing data with a linear or quadratic function imposed:
* create a scatterplot of ybr against x1; then, by editing the graph, superimpose a
* linear or quadratic function, using the following steps:
* (1) Double click the graph to get into edit mode (this will open a new window);
* (2) In pulldown menus, go to "Chart, Options (this will open a new window of Statterplot options;
* (3) In the Fit LIne section, check the box for "Total" 
* (4) Click on Fit Options (this will open Scatterplot Fit Line Options)
* (5) Pick Fit Method Linear Regression for the OLS linear regression line, click continue, or
* (6) Pick Fit Method Quadratic for the second order polynomial regression, click continue, or
* (7) Pick Fit Method Cubic for the third order polynomial regression, click continue, 
* (7) Pick Fit Method "Lowess" for the nonparametric lowess function (see Chapter 4)
*        that displays the shape of the data , click continue
*(8)  Click OK  
*************************************************************

graph
/scatterplot (bivar)= x1 with ybr
/missing=listwise
/title= 'Scatterplot of ybr as a function of x1'.
execute.

************************************************************

***************************************************************
* regression with centered variables
* to generate Figure 6.2.3 (page 203), and Table 6.2.2 (page 202)
* linear, quadratic, cubic equation generated in steps
****************************************************************

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CI cha
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT ybr
  /METHOD=ENTER x1c
  /method=enter x1c2
  /method=enter x1c3.
 
*************************************************
* * example in section 6.2.7, "Impact of outliers 
* * and sampling to increase stability" (page 212)
*************************************************

*********************************************************************
* work on the impact of outliers in the normally distributed data set
* Identify the case with the highest X score
*********************************************************************

frequencies variables= x1.
temporary.
select if x1 eq 17.
list variables=case x1

*********************************
* The highest raw score is 17.
********************************
*      X1       YBR
*     17    23.3791 The case with highest X has criterion =23.3791
*
*     Change the criterion of this case to 30
*********************************

if (x1 eq 17) ybr = 30.00.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA cha zpp ci tol
    /NOORIGIN
  /DEPENDENT ybr
  /method=ENTER x1c
  /method=enter x1c2
  /method=enter x1c3.
 


