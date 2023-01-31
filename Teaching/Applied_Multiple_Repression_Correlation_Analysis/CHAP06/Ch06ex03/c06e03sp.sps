**********************************************
* SPSS CODE FILE: C06E03SP.SPS
*Reads data file C06E03DT.TXT
*ICON PAGE 212
*Chapter 7, Example 3
*This is the example of a rectangularly distributed X variable
*     and a second order polynomial, to show that a single outlier
*     at the end has no effect when there are many cases at the
*     end of the distribution. 
*     Data illustrated in Figure 6.2.4.
*SPSS syntax by Leona S. Aiken
**************************************************

data list file='c:\ccwa\chap06\ch06ex03\c06e03dt.txt' free records = 1
      /1 case xold ybr.
execute.

***************************************
*find mean of xold and center xold.
*then compute quadratic and cubic terms.
***************************************

descriptives variables = xold
    /statistics = mean stddev.

compute x1c = xold - 8.97.

compute x12c = x1c**2.
compute x13c = x1c**3.

*********************************
* regression of Y on centered x
* to generate linear predicted score
* for Figure 6.2.4 (page 213)
*********************************

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA cha ci 
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT ybr
  /METHOD=ENTER x1c
  /SAVE pre_1(prdrlin1).


**************************
* regression of Y on centered x and x2
* to generate quadratic predicted score
* for Figure 6.2.4 (page 213)
**************************

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA cha ci 
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT ybr
  /METHOD=ENTER x1c x12c
  /SAVE pre_2(prd2rec2) res_6(RES2rec2).

GRAPH
  /SCATTERPLOT(OVERLAY)=x1c x1c x1c  WITH ybr prdrlin1 prd2rec2 (PAIR)
  /MISSING=LISTWISE
  /TITLE= 'Criterion Y, linear predicted Y, curvilinear ' 'predicted Y'+
 ' against centered X'.


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
/scatterplot (bivar)= x1c with ybr
/missing=listwise
/title= 'Scatterplot of ybr as a function of x1c'.
execute.



********************************
* regression with centered variables, 
* to obtain linear, quadratic, cubic increments for text
* "impact of outliers and sampling to increase stability"
* in section 6.2.7  (page 212)
********************************

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA cha zpp ci tol
    /NOORIGIN
  /DEPENDENT ybr
  /method=ENTER x1c
  /METHOD=ENTER x12c
  /METHOD=ENTER x13c
  /save sdresid(sdrec) sdfit(sdfic) sdbeta(sdbec).


****************************
* work on the impact of outliers in the normally distributed data set
* Identify the case with the highest Y score for X = 17.
****************************


temporary.
select if xold eq 17.
list variables=case xold ybr.

****************************
*    CASE     XOLD      YBR
*
*   95.00    17.00    28.45
*   96.00    17.00    26.02
*   97.00    17.00    26.68
*   98.00    17.00    30.93
*   99.00    17.00    30.32
*  100.00    17.00    27.72
****************************

*  In the normal distributed example, changed ybr from 23.3791 to 30,
*   a change of 6.6209 points.
*   Here I will change the highest score on Y, i.e. case 98, with ybr
*   of 30.93, the same number of points, 6.6209, so that ybr =
*    30.93 + 6.6209 = 37.5509.
*********************************

if (case eq 98) ybr = 37.5509.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA cha zpp ci tol
    /NOORIGIN
  /DEPENDENT ybr
  /method=ENTER x1c
  /method=enter x12c
  /method=enter x13c
  /SAVE sdresid(sdreo) sdfit(sdfio) sdbeta(sdbeo).

******************************************************
* examine the impact of case 98 on linear, quadratic, and cubic
* regression coefficients, after the value of ybr for case 98 is
* modified
******************************************************

temporary.
select if case eq 98.
list variables = case xold sdreo sdfio sdbeo0 sdbeo1 sdbeo2 sdbeo3.
execute.

