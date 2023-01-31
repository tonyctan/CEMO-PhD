**********************************************
* SAS CODE FILE: C06E03SA.SAS
*Reads data file C06E03DT.TXT
*Chapter 7, Example 3
*ICON PAGE 212
*This is the example of a rectangularly distributed X variable
*     and a second order polynomial, to show that a single outlier
*     at the end has no effect when there are many cases at the
*     end of the distribution. 
*     Data illustrated in Figure 6.2.4.
*   SAS syntax by Jonathan E. Butner, University of Utah
*     to mirror C06E03SP.SPS by Leona S. Aiken
**************************************************;
options nocenter;

data c6e3;
  infile 'c:\ccwa\chap06\ch06ex03\c06e03dt.txt';
  input case xold ybr;
run;

***************************************
*find mean of xold and center xold.
*then compute quadratic and cubic terms.
***************************************;

proc means;
  var xold;
run;

data c6e3c;
  set c6e3;
x1c = xold - 8.97;
x12c = x1c**2;
x13c = x1c**3;
run;

*********************************
* regression of Y on centered x
* to generate linear predicted score
* for Figure 6.2.4 (page 213)
*********************************;

proc reg simple corr data = c6e3c;
  model ybr = x1c/stb clb;
  output out=c6e3p p=prdrlin1;
run;

**************************
* regression of Y on centered x and x2
* to generate quadratic predicted score
* for Figure 6.2.4 (page 213)
**************************;

proc reg simple corr data=c6e3c;
  model ybr = x1c x12c/stb clb;
  test x12c;
  output out=c6e3p2 p=prd2rec2 r=RES2rec2;
  Title1;
  Title2;
run;

data c6e3plot;
  merge c6e3p c6e3p2;

proc gplot data = c6e3plot;
  plot ybr*x1c prdrlin1*x1c prd2rec2*x1c/overlay;
  TITLE1 'Criterion Y, linear predicted Y, curvilinear ';
  TITLE2 'predicted Y against centered X';
run;

*****************************************************
* The following syntax provides an alternative approach to 
* overlaying polynomial functions on scatterplots;
* a scatterplot is generated and the command
* "interpol=rq" superimposes a quadratic function*
* "rl" would superimpose a linear function,
* and "rc", a cubic function
*****************************************************;

proc gplot data = c6e3plot;
  plot ybr*x1c;
  symbol1 v=plus interpol=rq;
  TITLE1 'Criterion Y, linear predicted Y, curvilinear ';
  TITLE2 'predicted Y against centered X';
run;

********************************
* regression with centered variables, 
* to obtain linear, quadratic, cubic increments for text
* "impact of outliers and sampling to increase stability"
* in section 6.2.7 (page 212)
********************************;

proc reg simple corr data=c6e3c;
  model ybr = x1c/stb pcorr2 scorr2 tol vif clb;
  model ybr = x1c x12c/stb pcorr2 scorr2 tol vif clb;
  test x12c;
  model ybr = x1c x12c x13c/stb pcorr2 scorr2 tol vif clb;
  test x13c;
  output out=c6e3inf rstudent=sdrec dffits=sdfic;
  Title1;
  Title2;
run;


****************************
* work on the impact of outliers in the normally distributed data set
* Identify the case with the highest Y score for X = 17.
****************************;

data c6e3v17;
  set c6e3c;
  if xold eq 17;
proc print;
  var case xold ybr;
run;

********************************
*SAS output showing cases with xold=17
*
*Obs    case    xold      ybr
*
* 1       95     17     28.4463
* 2       96     17     26.0158
* 3       97     17     26.6765
* 4       98     17     30.9300
* 5       99     17     30.3200
* 6      100     17     27.7245
*******************************;

*  In the normal distributed example, changed ybr from 23.3791 to 30,
*   a change of 6.6209 points.
*   Here I will change the highest score on Y, i.e. case 98, with ybr
*   of 30.93, the same number of points, 6.6209, so that ybr =
*    30.93 + 6.6209 = 37.5509.
*********************************;

data c6e3c2;
  set c6e3c;
  if (case eq 98) then ybr = 37.5509;

proc reg simple corr data=c6e3c2;
  model ybr = x1c/stb pcorr2 scorr2 tol vif clb;
  model ybr = x1c x12c/stb pcorr2 scorr2 tol vif clb;
  test x12c;
  model ybr = x1c x12c x13c/stb pcorr2 scorr2 tol vif clb;
  test x13c;
  output out=c6e3inf2 rstudent=sdreo dffits=sdfio;
run;

******************************************************
* examine the impact of case 98 on linear, quadratic, and cubic
* regression coefficients, after the value of ybr for case 98 is
* modified
******************************************************;

data c6e3cinf3;
  merge c6e3inf c6e3inf2;
  if case = 98;
proc print;
  var case xold sdreo sdfio ;
run;
  quit;

