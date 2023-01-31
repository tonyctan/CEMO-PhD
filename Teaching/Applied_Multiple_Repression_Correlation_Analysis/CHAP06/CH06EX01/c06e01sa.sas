*******************************************
* SAS CODE FILE:C06E01SA.SAS
* Reads data file:  C06E01DT.TXT
* ICON CH06EX01, page 202
* Chapter 6, Example 1
* This example is of 100 cases, X normally distributed, generated
*   as a second order polynomial equation
*   Figure 6.1.1, 6.2.2a, 6.2.2b, Table 6.2.1 for uncentered data
*   Figure 6.2.3, Table 6.2.2 for centered data
*   SAS syntax by Jonathan E. Butner, University of Utah
*      to mirror C06E01SP.SPS by Leona S. Aiken
*******************************************;
OPTIONS NOCENTER ls=80 ps=44;



data c6e1;
  infile 'c:\ccwa\Chap06\Ch06ex01\C06E01DT.TXT';
  input case 1-4  x1 5-12  ybr 13-22;
run;

*************************************
*  find the mean of x1 to center x1.
*************************************;

proc means;
  var x1;
run;  

*********************************************
* center x1.
* create x1c2, the square of x1 centered.
* create x1c3, the cube of x1 centered.
* create x12, the square of x1 uncentered.
* create x13, the cube of x1 uncentered.
*********************************************;

data c6e1c;
  set c6e1;

x1c = x1 - 8.17;
x1c2 = x1c**2;
x1c3 = x1c**3;
x12  = x1**2;
x13  = x1**3;
run;
******************************************************************
* regression with uncentered variables
* to generate Figure 6.1.1 (page 194), and Table 6.2.1 (page 200)
* linear equation,
* quadratic equation, cubic equation.
* save predicted scores from  uncentered linear, quadratic equations.
*****************************************************************;

proc reg simple corr data=c6e1c;
  model ybr = x1/stb clb;
  output out=c6e1cp p=PREDulin;
run;

proc reg simple corr data=c6e1c;
  model ybr = x1 x12/stb clb;
  output out=c6e1cp2 p=PREDuqua;
run;
proc reg simple corr data=c6e1c;
  model ybr = x1/stb clb;
  model ybr = x1 x12/stb clb;
  test x12;
  model ybr = x1 x12 x13/stb clb;
  test x13;
  Title ;
run;
data c6e1cp3;
  merge c6e1cp c6e1cp2;
proc gplot data=c6e1cp3;
  plot ybr*x1 predulin*x1 preduqua*x1/overlay;
  Title 'Figure 6.1.1, uncentered';
run;

*****************************************************
* The following syntax provides an alternative approach to 
* overlaying polynomial functions on scatterplots;
* a scatterplot is generated and the command
* "interpol=rq" superimposes a quadratic function*
* "rl" would superimpose a linear function,
* and "rc", a cubic function
*****************************************************;

proc gplot data=c6e1cp3;
  plot ybr*x1 ;
  symbol1 v=plus interpol=rq;
  Title 'Figure 6.1.1, uncentered';
run;

****************************************************************
* regression with centered variables
* to generate Figure 6.2.3 (page 203), and Table 6.2.2 (page 202)
* linear, quadratic, cubic equation generated in steps
****************************************************************;

proc reg simple corr data=c6e1c;
  model ybr = x1c/stb clb;
  model ybr = x1c x1c2/stb clb;
  test x1c2;
  model ybr = x1c x1c2 x1c3/stb clb;
  test x1c3;
  Title ;
run;
 
***********************************************
* * example in section 6.2.7, "Impact of outliers 
* * and sampling to increase stability" (page 212)
***********************************************

****************************
* work on the impact of outliers in the normally distributed data set
* Identify the case with the highest X score
****************************;

proc freq;
  tables x1;
run;

data c6e1no17;
  set c6e1c;
  if x1 eq 17;
proc print; 
  var case x1 ybr;
run;

*********************************
* Information from proc print above:
* The ybr score corresponding to the 
*         highest raw x1 score of 17.
*********************************
*      X1       YBR
*     17    23.3791 The case with highest X has criterion =23.3791
*
*     Change the criterion of this case to 30
*********************************;
data c6e1f17;
  set c6e1c;
  if (x1 eq 17) then ybr = 30.00;

proc reg simple corr data=c6e1f17;
  model ybr = x1c/stb pcorr2 scorr2 vif tol clb;
  model ybr = x1c x1c2/stb pcorr2 scorr2 vif tol clb;
  test x1c2;
  model ybr = x1c x1c2 x1c3/stb pcorr2 scorr2 vif tol clb;
  test x1c3;
run;
quit;
