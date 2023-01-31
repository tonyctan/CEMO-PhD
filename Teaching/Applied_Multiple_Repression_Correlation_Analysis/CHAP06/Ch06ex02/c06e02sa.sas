******************************************
*   SAS CODE FILE:C06E02SA.SAS
*   Reads data file  C06E02DT.TXT
*   Chapter 6, Example 2
*   ICON CH06EX02, page 207
*   This example is of balanced data (n=6 per cell) treated with
*      natural and orthogonal polynomials
*      Figure 6.2.1, Table 6.2.3 for natural polynomials
*      Table 6.3.2, 6.3.3 for orthogonal polynomials
*   SAS syntax by Jonathan E. Butner, University of Utah
*      to mirror C06E02SP.SPS by Leona S. Aiken
******************************************;
options nocenter;

data c6e2;    
  infile 'c:\ccwa\chap06\ch06ex02\c06e02dt.txt';
  input case x y;
run;

*******************************************
* I.  NATURAL POLYNOMIALS
*******************************************

*************************************
*  find the mean of x to center x.
*************************************;

proc means;
  var x;
run;

*****************************
*center x.
*computer higher order terms.
****************************;

data c6e2c;
  set c6e2;
xc = x - 2.50;
xc2 = xc**2;
xc3 = xc**3;
run;

*****************************************
*  The following analysis generates the
*  linear equation predicted scores for
*  Figure 6.2.1 (page 197). X is centered
****************************************;

proc reg simple corr data=c6e2c;
  model y = xc/clb;
  output out=c6e2cp p=pred1c r=res1c;
run;

********************************************************
*  The following analysis generates Table 6.2.3(page 208),
*  and the cubic equation predicted scores for
*  Figure 6.2.1, X is centered. the analysis
*  is done in 'build-up' steps  for the 
*  hierarchical model portion of Table 6.2.3
********************************************************;

proc reg simple corr data=c6e2c;
  model y = xc/stb clb;
  model y = xc xc2/stb clb;
  test xc2;
  model y = xc xc2 xc3/stb clb;
  test xc3;
  output out =c6e2cp2 p=pred3c r=res3c;
run;

***************************************
*  This is a one-way ANOVA to get the Y means
*  at each value of X, to plot the conditional
*  cell means in Figure 6.2.1 (page 197).
*  The "if" statements are based on means generated 
*  by the "oneway" procedure
******************************************;

proc glm data = c6e2c;
  class x;
  model y = x;
  means x;
run;

data c6e2c2;
  set c6e2c;
if (x eq 0) then ymean = 47.5000;
if (x eq 1) then ymean = 36.6667;
if (x eq 2) then ymean = 45.0000;
if (x eq 3) then ymean = 66.1667;
if (x eq 4) then ymean = 63.8333;
if (x eq 5) then ymean = 57.3333;
run;

**********************************************************
*  This generates the analog of Figure 6.2.3 (page 203)
*  Note that Figure 6.2.3 on page 203 was not generated in SAS
**********************************************************;
data c6e2plot;
  merge c6e2c2 c6e2cp c6e2cp2;

proc gplot data=c6e2plot;
  plot y*xc pred3c*xc pred1c*xc ymean*xc/overlay;
run;

*****************************************************
* The following syntax provides an alternative approach to 
* overlaying polynomial functions on scatterplots;
* a scatterplot is generated and the command
* "interpol=rq" superimposes a quadratic function*
* "rl" would superimpose a linear function,
* and "rc", a cubic function
*****************************************************;
proc gplot data=c6e2plot;
  plot y*xc;
  symbol1 v=plus interpol=rc; 
run;


*******************************************
* II.  ORTHOGONAL POLYNOMIALS
*******************************************


*****************************************
*  defining values of orthogonal polynomials.
*  values for orthogonal polynomials are taken from 
*  Table 6.3.1, u = 6 for the linear, quadratic, and cubic terms,
*  and from Draper and Smith (1998, p.466) for the quartic and 
*  quintic terms.
*****************************************;

data c6e2q;
  set c6e2c;
if (x eq 0) then quin =   -1;
if (x eq 1) then quin =    5;
if (x eq 2) then quin =  -10;
if (x eq 3) then quin =   10;
if (x eq 4) then quin =   -5;
if (x eq 5) then quin =    1;

if (x eq 0) then quar =  1;
if (x eq 1) then quar = -3;
if (x eq 2) then quar =  2;
if (x eq 3) then quar =  2;
if (x eq 4) then quar = -3;
if (x eq 5) then quar =  1;

if (x eq 0) then cub = -5;
if (x eq 1) then cub =  7;
if (x eq 2) then cub =  4;
if (x eq 3) then cub = -4;
if (x eq 4) then cub = -7;
if (x eq 5) then cub =  5;

if (x eq 0) then quad = 5;
if (x eq 1) then quad = -1;
if (x eq 2) then quad = -4;
if (x eq 3) then quad = -4;
if (x eq 4) then quad = -1;
if (x eq 5) then quad = 5;

if (x eq 0) then lin = -5;
if (x eq 1) then lin = -3;
if (x eq 2) then lin = -1;
if (x eq 3) then lin =  1;
if (x eq 4) then lin =  3;
if (x eq 5) then lin =  5;
run;

*****************************************
* Regression analysis to generate linear,
* quadratic, and cubic equations of Table 6.3.2 (page 217)
* and Table 6.3.3, part (2) (page 218).
******************************************;

proc reg simple corr data=c6e2q;
  model y = lin/stb clb;
  model y = lin quad/stb clb;
  test quad;
  model y = lin quad cub/stb clb;
  test cub;
run;

*****************************************
* Regression analysis to generate predictable
* and residual sums of squares if all five
* orthogonal polynomials are employed
* for analyses involving quintic terms in 
* Tables 6.3.2. (page 217) 
* and in Table 6.3.3 part (3) (page 218).
******************************************;

proc reg simple corr data=c6e2q;
  model y = lin quad cub quar quin/clb;
run;

*********************************
* anova for polynomial regression
* given in Table 6.3.2 (page 217)
*********************************;

proc glm data=c6e2q;
  model y = lin quad cub quar quin;
run;
  quit;
