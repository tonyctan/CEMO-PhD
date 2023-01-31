*Chapter 10 code by Oi-man Kwok and Steve West.     *
*Psychology department, Arizona State University    *
*This uses SAS version 8.1. Later version of SAS may*
*incorporate additional features.                   *;

Title 'Figure 10.2.1 to Figure 10.3.6';

*These are standard SAS options to produce easy to read output*; 

options ovp nocenter linesize=80 pagesize=44;

*(A) Original Data Set (N=15)                       *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *;

Data p1021a; infile 'c:\ccwa\ChAP10\CH10EX01\C10e01dt1.txt';
input caseno 1-3 year 4-6 pub 7-9;

label  caseno='Case Number'
       year='Years Since Ph.D.' 
       pub='Number of Publications';

**************************************************
*To get the regression model and diagnostics for *
*the Original Data Set                           *
**************************************************;

*10.2.1 (p.392)*;
*Model statement regresses pub on year. stb requests      *
*the standardized regression coefficients. r requests     *
*R square. influence requests the diagnostic statistics.  *
*partial requests the partial regression residual plots   *
*(added variable plots). Diagnostics are saved for use    *
*in making graphs to be presented later. id command allows*
*identification of case statistics by variable caseno     *;

proc reg data=p1021a;
id caseno;
model pub=year/stb r influence partial;
output out=tp1021a
residual=resid
student=sresid
H=leverage
dffits=dffits;
title2;
title3 'Regression Model & Diagnostics of Figure 10.2.1(A)';
title4 '(a)Original Data Set (N=15)';
run;

*This produces a scatterplot with a overlayed regression line*
*of publication against years for the original data (Figure  *
*10.2.1a).  vaxis controls the range of the y-axis. haxis    *
*controls the range of the x-axis. The "by" command sets the *
*intervals plotted on the scale for the x- and y-axes. The   *
*range of the axes is constant across figure 10.2.1(a), (b)  *
*and (c).                                                    *;

proc gplot data=tp1021a;
plot pub*year / vaxis=0 to 60 by 20 haxis=0 to 60 by 15;
symbol1 v=star i=rl c=blue;
title2;
title3 'Fig 10.2.1 Plot of Years Since Ph.D. vs Number of Publications';
title4 '(A) Original Data Set (N=15)';
run;


*(B)Data Set Containing Outlier for Case 6 (N=15)   *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *;

Data p1021b; infile 'c:\ccwa\ChAP10\CH10EX01\C10e01dt2.txt';
input caseno 1-3 year 4-6 pub 7-9;

label  caseno='Case Number'
       year='Years Since Ph.D.' 
       pub='Number of Publications';

**************************************************
*To get the regression model and diagnostics for *
*the Data Set Containing Outlier for Case 6      *
**************************************************;

proc reg data=p1021b;
id caseno;
model pub=year/stb r influence partial;
output out=tp1021b
residual=resid
student=sresid
H=leverage
dffits=dffits;
title2;
title3 'Regression Model & Diagnostics of Figure 10.2.1(B)';
title4 '(B)Data Set Containing Outlier for Case 6 (N=15)';
run;

proc gplot data=tp1021b;
plot pub*year / vaxis=0 to 60 by 20 haxis=0 to 60 by 15;
symbol1 v=star i=rl c=blue;
title2;
title3 'Fig 10.2.1 Plot of Years Since Ph.D. vs Number of Publications';
title4 '(B) Data Set Containing Outlier for Case 6 (N=15)';
run;


*(C) Data Set Deleting Case 6 (N=14)                *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *;

Data p1021c; infile 'c:\ccwa\ChAP10\CH10EX01\C10e01dt3.txt';
input caseno 1-3 year 4-6 pub 7-9;

label  caseno='Case Number'
       year='Years Since Ph.D.' 
       pub='Number of Publications';

**************************************************
*To get the regression model and diagnostics for *
*the Data Set Deleting Case 6 (N=14)             *
**************************************************;

proc reg data=p1021c;
id caseno;
model pub=year/stb r influence partial;
output out=tp1021c
residual=resid
student=sresid
H=leverage
dffits=dffits;
title2;
title3 'Regression Model & Diagnostics of Figure 10.2.1(C)';
title4 '(C)Data Set Deleting Case 6 (N=14)';
run;

proc gplot data=tp1021c;
plot pub*year / vaxis=0 to 60 by 20 haxis=0 to 60 by 15;
symbol1 v=star i=rl c=blue;
title2;
title3 'Fig 10.2.1 Plot of Years Since Ph.D. vs Number of Publications';
title4 '(C) Data Set Deleting Case 6 (N=14)';
run;


***************************************************************
*Figure 10.3.1(A) Index Plot of Leverage vs Case Number(p.395)*
*
***************************************************************;

proc gplot data=tp1021a;
plot leverage*caseno/ vref=0 vaxis=0 to 1 by .2 haxis=0 to 15 by 1;
symbol1 v=star i=none c=blue;
title2;
title3 'Fig 10.3.1 Index Plot of Leverage vs. Case Number';
title4 '(A) Original Data Set (N=15)';
run;


********************************************************
*Figure 10.3.1(B) Index Plot of Leverage vs Case Number*
********************************************************;

proc gplot data=tp1021b;
plot leverage*caseno/ vref=0 vaxis=0 to 1 by .2 haxis=0 to 15 by 1;
symbol1 v=star i=none c=blue;
title2;
title3 'Fig 10.3.1 Index Plot of Leverage vs. Case Number';
title4 '(B) Data Set Containing Outlier for Case 6 (N=15)';
run;


***********************************************
*Figure 10.3.2 Scatterplot of Time Since Ph.D.*
*vs Number of Publications (p.397)            *
***********************************************;

*The same data set as 10.2.1(A), with an additional *
*data point (Centroid, Caseno=16)                   *
*There are four variables in the dataset:           *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *
*pub15: Number of Publication (without the Centroid)* 
*The overlay command is used to add the "X" for the *
*centroid. We trick SAS by overlaying 16 data points*
*over 15 data points. The 16th data point is the    *
*centroid. So it is unique and stands out. footnote *
*produces figure note                               *;

Data p1032; infile 'c:\ccwa\ChAP10\CH10EX01\C10e01dt4.txt';
input caseno 1-3 year 4-8 pub16 9-13 pub 14-15;

label  caseno='Case Number'
       year='Years Since Ph.D.' 
       pub='Number of Publications'
       pub15='Number of Publications';

proc gplot data=p1032;
plot 
pub16*year =1
pub*year= 2
/overlay;
symbol1 v=X i=none c=red;
symbol2 v=O i=none c=blue;
footnote1 j=l h=.3 cm c=red f=titalic 'X -- Centroid';
footnote2 j=l h=.3 cm c=blue f=titalic 'O+X -- The original 15 Obs';
title2;
title3 'Figure 10.3.2 Scatterplot of Years Since Ph.D.';
title4 'vs Number of Publications:With Centroid (Caseno=16)';
run;


*****************************************************************
*Figure 10.3.3(A) Index Plot of Residuals vs Case Number (p.399)*
*****************************************************************;

*vref requests the y=0 line. footnote1 and footnote2 are used*
*to cancel the previous footnotes used in figure 10.3.2.     *
*Otherwise SAS will continue to print the same footnotes.    *;

proc gplot data=tp1021a;
plot resid*caseno/ vref=0 vaxis=-20 to 40 by 10 haxis=0 to 15 by 5;
symbol1 v=star i=none c=blue;
footnote1;
footnote2;
title2;
title3 'Figure 10.3.3 Index Plot of Residuals vs Case Number';
title4 '(A) Original Data Set';
run;

*********************************************************
*Figure 10.3.3(B) Index Plot of Residuals vs Case Number*
*********************************************************;

proc gplot data=tp1021b;
plot resid*caseno/ vref=0 vaxis=-20 to 40 by 10 haxis=0 to 15 by 5;
symbol1 v=star i=none c=blue;
title2;
title3 'Figure 10.3.3 Index Plot of Residuals vs Case Number';
title4 '(B) Data Set Containing Outlier for Case 6';
run;


*********************************************************
*Figure 10.3.4(A) Index Plot of Externally Studentized  *
*Residuals (ti) vs. Case Number (p.401)                 *
*********************************************************;

proc gplot data=tp1021a;
plot sresid*caseno/ vref=0 vaxis=-4 to 4 by 2 haxis=0 to 15 by 5;
symbol1 v=star i=none c=blue;
title2;
title3 'Figure 10.3.4 Index Plot of Externally Studentized'; 
title4 'Residuals vs Case Number: (A) Original Data Set';
run;


*********************************************************
*Figure 10.3.4(B) Index Plot of Externally Studentized  *
*                 Residuals (ti) vs. Case Number        *
*********************************************************;

proc gplot data=tp1021b;
plot sresid*caseno/ vref=0 vaxis=-4 to 4 by 2 haxis=0 to 15 by 5;
symbol1 v=star i=none c=blue;
title2;
title3 'Figure 10.3.4 Index Plot of Externally Studentized Residuals'; 
title4 'vs Case Number: (B) Data Set Containing Outlier for Case 6';
run;


*****************************************************************
*Figure 10.3.5(A) Index Plot of (DFFITS) vs. Case Number (p.403)*
*****************************************************************;

proc gplot data=tp1021a;
plot dffits*caseno/ vref=0 vaxis=-15 to 5 by 5 haxis=0 to 15 by 5;
symbol1 v=star i=none c=blue;
title2;
title3 'Figure 10.3.5 Index Plot of (DFFITS) vs Case Number';
title4 '(A) Original Data Set';
run;

*********************************************************
*Figure 10.3.5(B) Index Plot of (DFFITS) vs. Case Number*
*********************************************************;

proc gplot data=tp1021b;
plot dffits*caseno/ vref=0 vaxis=-15 to 5 by 5 haxis=0 to 15 by 5;
symbol1 v=star i=none c=blue;
title2;
title3 'Figure 10.3.5 Index Plot of (DFFITS) vs Case Number';
title4 '(B) Data Set Containing Outlier for Case 6';
run;


*************************************************************
*NOTE: DFBETAS VALUES ARE NOT AVAILABLE IN OUTPUT DATA SET! *
*      SAS does not currently permit users to save DFBetas  *
*      directly to a output file.                           *  
*      THE DATASETS USED FOR THE FOLLOWING TWO PLOTS must be*
*      RECREATED FROM THE SAS OUTPUT FILE.                  *
************************************************************;

******************************************
*Figure 10.3.6(A) Index Plot of (DFBETAS)*
*vs. Case Number:Intercept (p.406)       *
******************************************;

Data p1036a; infile 'c:\ccwa\ChAP10\CH10EX01\C10e01dt11.txt';
input caseno 1-4 dfb_int 5-14 dfb_slp 15-24;

label caseno='Case Number'
      dfb_int='(DFBETAS)_Intercept'
	  dfb_slp='(DFBETAS)_Slope';

proc gplot data=p1036a;
plot dfb_int*caseno/ vref=0 vaxis=-1 to 5 by 1 haxis=0 to 15 by 5;
symbol1 v=star i=none c=blue;
title2;
title3 'Figure 10.3.6 Index Plot of (DFBETAS) vs Case Number:';
title4 'Intercept (A) Original Data Set';
run;


********************************************************************
*Figure 10.3.6(B) Index Plot of (DFBETAS) vs. Case Number:Intercept*
********************************************************************;

Data p1036b; infile 'c:\ccwa\ChAP10\CH10EX01\C10e01dt21.txt';
input caseno 1-4 dfb_int 5-14 dfb_slp 15-24;

label caseno='Case Number'
      dfb_int='(DFBETAS)_Intercept'
	  dfb_slp='(DFBETAS)_Slope';

proc gplot data=p1036b;
plot dfb_int*caseno/ vref=0 vaxis=-1 to 5 by 1 haxis=0 to 15 by 5;
symbol1 v=star i=none c=blue;
title2;
title3 'Figure 10.3.6 Index Plot of (DFBETAS) vs Case Number:';
title4 'Intercept (B) Data Set Containing Outlier for Case 6';
run;


*****************************************************************
*Figure 10.3.6(C) Index Plot of (DFBETAS) vs. Case Number: Slope*
*****************************************************************;

proc gplot data=p1036a;
plot dfb_slp*caseno/ vref=0 vaxis=-10 to 2 by 2 haxis=0 to 15 by 5;
symbol1 v=star i=none c=blue;
footnote1;
footnote2;
title2;
title3 'Figure 10.3.6 Index Plot of (DFBETAS) vs Case Number:';
title4 'Slope (C) Original Data Set';
run;


*****************************************************************
*Figure 10.3.6(D) Index Plot of (DFBETAS) vs. Case Number: Slope*
*****************************************************************;

proc gplot data=p1036b;
plot dfb_slp*caseno/ vref=0 vaxis=-10 to 2 by 2 haxis=0 to 15 by 5;
symbol1 v=star i=none c=blue;
title2;
title3 'Figure 10.3.6 Index Plot of (DFBETAS) vs Case Number:';
title4 'Slope (D) Data Set Containing Outlier for Case 6';
run;
