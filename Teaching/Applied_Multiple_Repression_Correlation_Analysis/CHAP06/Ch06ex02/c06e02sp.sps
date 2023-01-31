******************************************
*   SPSS CODE FILE:C06E02SP.SPS
*   Reads data file  C06E02DT.TXT
*   ICON CH06EX02, page 207
*   Chapter 6, Example 2
*   This example is of balanced data (n=6 per cell) treated with
*      natural and orthogonal polynomials
*      Figure 6.2.1, Table 6.2.3 for natural polynomials
*      Table 6.3.2, 6.3.3 for orthogonal polynomials
*   SPSS syntax by Leona S. Aiken
******************************************
    
data list file='c:\ccwa\chap06\ch06ex02\c06e02dt.txt'free records=1
   /1 case x y.
execute.

*******************************************
* I.  NATURAL POLYNOMIALS
*******************************************

*************************************
*  find the mean of x to center x.
*************************************

descriptives variables = x.

*****************************
*center x.
*computer higher order terms.
****************************

compute xc = x - 2.50.
compute xc2 = xc**2.
compute xc3 = xc**3.

****************************************
*  The following analysis generates the
*  linear equation predicted scores for
*  Figure 6.2.1, (page 197); X is centered
****************************************

REGRESSION
   /descriptives mean stddev corr sig n
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA ci
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER xc
    /save= pred(pred1c) resid(res1c).

**********************************************************
*  The following analysis generates Table 6.2.3 (page 208),
*  and the cubic equation predicted scores for
*  Figure 6.2.1; X is centered; the analysis
*  is done in 'build-up' steps  for the 
*  hierarchical model portion of Table 6.2.3
**********************************************************

REGRESSION
   /descriptives mean stddev corr sig n
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHA CI
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER xc
  /method=enter xc2
  /method=enter xc3
  /save pred(pred3c) resid(res3c).



***************************************
*  This is a one-way ANOVA to get the Y means
*  at each value of X, to plot the conditional
*  cell means in Figure 6.2.1. (PAGE 197)
*  The "if" statements are based on means generated 
*  by the "oneway" procedure
******************************************

 oneway y by x
    /statistics=descriptives.

if (x eq 0) ymean = 47.5000.
if (x eq 1) ymean = 36.6667.
if (x eq 2) ymean = 45.0000.
if (x eq 3) ymean = 66.1667.
if (x eq 4) ymean = 63.8333.
if (x eq 5) ymean = 57.3333.


**********************************************************
*  This generates Figure 6.2.3 (PAGE 203)
*  Note that Figure 6.2.3 was enhanced from SPSS output
*  by connecting the points of the linear and cubic equations
**********************************************************

GRAPH
  /SCATTERPLOT(OVERLAY)=xc xc xc xc WITH y pred3c pred1c ymean(PAIR)
  /MISSING=LISTWISE .


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
/scatterplot (bivar)= xc with y
/missing=listwise
/title= 'Scatterplot of y as a function of xc'.
execute.

************************************************************

*******************************************
* II.  ORTHOGONAL POLYNOMIALS
*******************************************


*****************************************
*  defining values of orthogonal polynomials.
*  values for orthogonal polynomials are taken from 
*  Table 6.3.1, u = 6 for the linear, quadratic, and cubic terms,
*  and from Draper and Smith (1998, p.466) for the quartic and 
*  quintic terms.
*****************************************

if (x eq 0) quin =   -1.
if (x eq 1) quin =    5.
if (x eq 2) quin =  -10.
if (x eq 3) quin =   10.
if (x eq 4) quin =   -5.
if (x eq 5) quin =    1.

if (x eq 0) quar =  1.
if (x eq 1) quar = -3.
if (x eq 2) quar =  2.
if (x eq 3) quar =  2.
if (x eq 4) quar = -3.
if (x eq 5) quar =  1.

if (x eq 0) cub = -5.
if (x eq 1) cub =  7.
if (x eq 2) cub =  4.
if (x eq 3) cub = -4.
if (x eq 4) cub = -7.
if (x eq 5) cub =  5.

if (x eq 0) quad = 5.
if (x eq 1) quad = -1.
if (x eq 2) quad = -4.
if (x eq 3) quad = -4.
if (x eq 4) quad = -1.
if (x eq 5) quad = 5.

if (x eq 0) lin = -5.
if (x eq 1) lin = -3.
if (x eq 2) lin = -1.
if (x eq 3) lin =  1.
if (x eq 4) lin =  3.
if (x eq 5) lin =  5.


*****************************************
* Regression analysis to generate linear,
* quadratic, and cubic equations of Table 6.3.2 (page 217)
* and Table 6.3.3, part (2) (page 218).
******************************************

REGRESSION
   /descriptives mean stddev corr sig n
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA cha ci
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER lin
  /method=enter quad
  /method=enter cub.

*****************************************
* Regression analysis to generate predictable
* and residual sums of squares if all five
* orthogonal polynomials are employed
* for analyses involving quintic terms in 
* Tables 6.3.2. (page 217) 
* and in Table 6.3.3 part (3) (page 218).
******************************************

REGRESSION
   /descriptives mean stddev corr sig n
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA ci
  /NOORIGIN
  /DEPENDENT y
  /METHOD=ENTER lin quad cub quar quin.

*********************************
* anova for polynomial regression
* given in Table 6.3.2  (page 217).
*********************************.

oneway y by x
   /polynomial=5
   /statistics=descriptives.

   

