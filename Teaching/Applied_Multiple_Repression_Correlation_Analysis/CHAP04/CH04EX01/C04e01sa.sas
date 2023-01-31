*Chapter 4 code by Oi-man Kwok and Steve West.      *
*Psychology department, Arizona State University    *
*This uses SAS version 8.0.1. Later version of SAS  * 
*may incorporate additional features.               *;

Title 'Figure 4.2.1 to Figure 4.4.7';

*This generates most of the figures in section 4.2 through 4.4*;

*These are standard SAS options that produce easy to read output;

options ovp nocenter linesize=80 pagesize=44;

*There are seven variables in the dataset:          *
*caseno, caseno2, year, pub, male, cite, salary     *
*We will only use year, pub, male and salary here   *
*year: Years Since PhD                              *
*pub: Number of Publication                         *
*male: 1=male, 0=female								*;

*This reads the data for Chapter 4 into a file named p421*;
Data p421; infile 'c:\ccwa\CHAP04\CH04EX01\C04e01dt1.txt';
input caseno 1-3 caseno2 4-6 year 7-9 pub 10-12
      male 13-15 cite 16-18 salary 19-24;

label  caseno='Case number'
       year='Years since Ph.D.' 
       pub='Number of publications'
       cite='Number of citations'
       male='gender: 1=Male 0=Female';

*4.2.1 (p.104): The next two plots create figure 4.2.1 (a)     * 
* and (b). The midpoints are used to control the number of bins*;

proc univariate data=p421;
histogram year/midpoints = 2.505 7.505 12.505 15.505 22.505;
title2 'Figure 4.2.1 Histogram of years since Ph.D. (A) Five bins';
run;

proc univariate data=p421;
histogram year/midpoints = 
1.630 2.880 4.130 5.380 6.630 7.880 9.130 10.380 11.630
12.880 14.130 15.380 16.630 17.880 19.130 20.380 21.630
22.880 24.130 25.380;
title2 'Figure 4.2.1 Histogram of years since Ph.D. (B) Twenty bins';
run;

*4.2.2 (p.105): This will create the stem and leaf display*;
*plotsize is to control the range of the stem (number of  *
*the rows.                                                *;

proc univariate data=p421 plot plotsize=5;
var year;
title2 'Figure 4.2.2 Stem and leaf display of years since Ph.D.';
run;

*4.2.3 (p.109): Kernel density estimates;
*k=n means a normal kernel was used, a bisquare was used in the text*
*c represents the smoothing parameter which is on a different scale * 
*than the one used in the text                                      *;

proc univariate data=p421;
histogram year/kernel (k=n color=red c=5);
title2 'Figure 4.2.3 Kernel density estimation: years since Ph.D.';
title3 '(A) Width=5: too much smoothing';
run;

*Figure 4.2.3 (B);

proc univariate data=p421;
histogram year/kernel (k=n color=red c=.30);
title2 'Figure 4.2.3 Kernel density estimation: years since Ph.D.';
title3 '(B) Width=.30: too little smoothing';
run;

*Figure 4.2.3 (C) & (D);

proc univariate data=p421;
histogram year/kernel (k=n color=red c=.70);
title2 'Figure 4.2.3 Kernel density estimation: years since Ph.D.';
title3 '(C) & (D) Width=.7: appropriate smoothing';
run;

*4.2.4 (p.110): Boxplot;
*A new variable named "boxplot" is created to form a* 
*single boxplot rather than side by side boxplots   *;

data p424; set p421;
Boxplot=1;

proc boxplot data=p424;
plot year*boxplot;
title2'Figure 4.2.4 Boxplot of years since Ph.D.';
run;

*4.2.5 (p.112): Scatterplots and enhanced scatterplots;
*Basic scatterplot (A): plot identifies the y and x variables,*
*vaxis and haxis control the range of the y- and x-axes       *;

proc gplot data=p421;
plot salary*year / vaxis=0 to 100000 by 20000 haxis=0 to 25 by 5;
symbol1 v=star i=none c=red;
title2;
title3 'Fig 4.2.5 Scatterplots and enhanced scatterplot';
title4 '(A) Basic scatterplot: Salary vs. Years since Ph.D.';
run;

*Figure 4.2.5 (B);

proc gplot data=p421;
plot year*male / vaxis=0 to 25 by 5 haxis=-.5 to 1.5 by .5;
symbol1 v=star i=none c=red;
title2;
title3 'Fig 4.2.5 Scatterplots and enhanced scatterplot';
title4 '(B) Basic scatterplot: Salary vs. Years since Ph.D.';
run;

*Figure 4.2.5 (C): Jittering is not presently available;

*Figure 4.2.5 (D);
*i=rl superimposes the regression line;

proc gplot data=p421;
plot salary*year / vaxis=0 to 100000 by 20000 haxis=0 to 25 by 5;
symbol1 v=star i=rl c=red;
title2;
title3 'Fig 4.2.5 Scatterplots and enhanced scatterplot';
title4 '(D) Superimposed Regression Line: Salary vs. Years since Ph.D.';
run;

*4.2.5.(p.113): Superimposing a loess line;
*model statement identifies y and x variables, smoothing parameter  *
*and 95% confidence interval (1-alpha) and produces the loess values*
*The loess values are saved in fig425e.                             *;

*Note: In SAS, the smoothing parameter is smooth, not alpha      *;
*Note: Figure F, G and H were created by varying smooth parameter*
*with another dataset (see Chapter 6)                            *;

proc loess data=p421;
ods output outputstatistics=fig425e;
model salary=year/smooth=.60 alpha=.05 all details;
run;

proc sort data=fig425e;
 by year;
 run;

symbol1 v=dot c=black;
symbol2 v=none i=join c=black;

*This produces the scatterplot and overlays the loess curve;

proc gplot data=fig425e;
plot 
depvar*year=1
pred*year=2
/overlay;
title2 'Figure 4.2.5.(E) Superimposed Lowess fit';
title3 'Salary vs. Years since Ph.D.: Loess Fit Alpha=.60';
run;

*4.2.6 (p.116): Scatterplot matrix: SAS does not  *
*directly produce a scatterplot matrix. Below each*
*individual scatterplot is produced .             *;

proc plot data=p421;
  plot (year pub male cite salary) * (year pub male cite salary);
title2 'Figure 4.2.6 Faculty salary example: Scatterplots'; 
title3 '';
run;

*4.4.1 (p.126): proc reg creates the residuals (r=yresid)*
*and the predicted values (ypred).                       *;

*The same procedure is used to produce the loess plot as*
*in Figure 4.2.5                                        *;

proc reg data=p421;
      model salary=year pub male cite;
      output out=p441
         r=yresid p=ypred;
   run;

proc loess data=p441;
ods output outputstatistics=fig441a;
model yresid=year/smooth=.50 alpha=.05 all details;
label  yresid='Residuals';
run;

proc sort data=fig441a;
 by year;
 run;

data fig441a1; set fig441a;
zero=0;

symbol1 v=dot c=black;
symbol2 v=none i=join c=black;
symbol3 v=none i=join c=red;

proc gplot data=fig441a1;
plot 
depvar*year=1
pred*year=2
zero*year=3
/overlay vaxis=-20000 to 30000 by 10000 haxis=0 to 25 by 5;
label  depvar='Residuals';
title2 'Figure 4.4.1. Scatter plot of salary data';
title3 '(A)Residuals vs. Years since Ph.D.';
title4 'Loess fit alpha=.50';
run;

proc loess data=p441;
ods output outputstatistics=fig441b;
model yresid=ypred/smooth=.50 alpha=.05 all details;
run;

proc sort data=fig441b;
 by ypred;
 run;

data fig441b1; set fig441b;
zero=0;

symbol4 v=dot i=none c=black;
symbol5 v=none i=join c=black;
symbol6 v=none i=join c=red;

proc gplot data=fig441b1;
plot 
depvar*ypred=4
pred*ypred=5
zero*ypred=6
/overlay vaxis=-20000 to 30000 by 10000 
haxis=40000 to 80000 by 10000;
label  depvar='Residuals';
title2 'Figure 4.4.1. Scatter plot of salary data';
title3 '(B)Residuals vs. Predicted values';
title4 'Loess fit alpha=.50';
run;

*4.4.3 (p.129): model statement identifies two separate regression*
*equations with salary and cites respectively as the DVs          *;

*The residuals from each equation are saved separately*;
*The same loess procedure is applied as in 4.2.5      *;

proc reg data=p421;
      model salary cite=year pub male;
      output out=p443
         r=sresid cresid;
   run;

proc loess data=p443;
ods output outputstatistics=fig443;
model sresid=cresid/smooth=.50 alpha=.05 all details;
run;

proc sort data=fig443;
 by cresid;
 run;

symbol1 v=dot i=rl c=black;
symbol2 v=none i=join c=red;

proc gplot data=fig443;
plot 
depvar*cresid=1
pred*cresid=2
/overlay vaxis=-20000 to 30000 by 10000 
haxis=-40 to 60 by 20;
label  depvar='Residuals of salary';
label  cresid='Residuals of citations';
title2 'Figure 4.4.3. Add variable plot';
title3 'Loess fit alpha=.50';
title4 '';
run;

*4.4.4 (p.131): plots of residuals*;
*The residuals were created from Figure 4.4.1*;
*A variable named "zero" is created to produce the y=0 line*;

data p444; set p441;
zero=0;
run;

symbol1 v=dot c=black;
symbol2 v=none i=join c=black;

*Figure 4.4.4 (A);

proc gplot data=p444;
plot 
yresid*year=1
zero*year=2
/overlay vaxis=-20000 to 30000 by 10000 haxis=0 to 25 by 5;
title2 'Figure 4.4.4. Plot of residuals';
title3 '(A)Residuals vs. years since Ph.D.';
title4 '';
run;

*Figure 4.4.4 (B);

proc gplot data=p444;
plot 
yresid*ypred=1
zero*ypred=2
/overlay vaxis=-20000 to 30000 by 10000 
haxis=40000 to 80000 by 10000;
title2 'Figure 4.4.4. Plot of residuals';
title3 '(B)Residuals vs. predicted value';
title4 '';
run;

*Figure 4.4.4 (C) adding loess line 1 SD above and below*;
*Alpha=.3414 represents 1 SD*;

proc loess data=p441;
ods output outputstatistics=fig444c;
model yresid=year/smooth=.60 alpha=.3172 all details;
run;

proc sort data=fig444c;
 by year;
 run;

symbol1 v=dot c=black;
symbol2 v=none i=join c=black;
symbol3 v=none i=join c=green;
symbol4 v=none i=join c=green;

proc gplot data=fig444c;
plot 
depvar*year=1
pred*year=2
lowercl*year=3
uppercl*year=4
/overlay vaxis=-20000 to 30000 by 10000 haxis=0 to 25 by 5;
label  depvar='Residuals';
title2 'Figure 4.4.4. Scatter plot of salary data';
title3 '(C)Residuals vs. Years since Ph.D. (Loess fit added)';
title4 'Loess fit alpha=.60';
run;

*Figure 4.4.5 used the same procedure as in *
*Figure 4.4.4 (C) with other datasets       *;

*4.4.6 (p.135): Three different datasets are created for* 
*Figure (A), (B and C) and (D)                          *;

Data p446; infile 'c:\ccwa\CHAP04\CH04EX01\C04e01dt2.txt';
input caseno 1-3 cluster 4-6 resid_a 7-14 resid_bc 15-22
      resid_d 23-30;

label  caseno='Case Number'
       resid_a='Residual' 
       resid_bc='Residual' 
       resid_d='Residual';

*Figure 4.4.6 (A);

data p446a; set p446;
zero=0;
run;

symbol1 v=dot i=none c=black;
symbol2 v=none i=join c=black;

proc gplot data=p446a;
plot 
resid_a*caseno=1
zero*caseno=2
/overlay vaxis=-6 to 6 by 2 haxis=0 to 100 by 20;
title2 'Figure 4.4.6. Index plots of residuals';
title3 '(A)Independent residuals from a random sample';
title4 '';
run;

*Figure 4.4.6 (B): 10 indicator variables (eg. resid_1) were created*
*to identify the residuals for each cluster, and each cluster is    * 
*assigned for a different plotting symbol                           *;

data p446b; set p446a;
zero=0;
IF cluster = 1 then resid_1 = resid_bc;
IF cluster = 2 then resid_2 = resid_bc;
IF cluster = 3 then resid_3 = resid_bc;
IF cluster = 4 then resid_4 = resid_bc;
IF cluster = 5 then resid_5 = resid_bc;
IF cluster = 6 then resid_6 = resid_bc;
IF cluster = 7 then resid_7 = resid_bc;
IF cluster = 8 then resid_8 = resid_bc;
IF cluster = 9 then resid_9 = resid_bc;
IF cluster = 10 then resid_10 = resid_bc;

*Figure 4.4.6 (B);

symbol1 v=plus i=none c=b;
symbol2 v=x i=none c=c;
symbol3 v=star i=none c=a;
symbol4 v=square i=none c=r;
symbol5 v=diamond i=none c=p;
symbol6 v=triangle i=none c=o;
symbol7 v=hash i=none c=r;
symbol8 v=dot i=none c=g;
symbol9 v=circle i=none c=y;
symbol10 v=$ i=none c=m;
symbol11 v=none i=join c=b;

proc gplot data=p446b;
plot 
resid_1*caseno=1
resid_2*caseno=2
resid_3*caseno=3
resid_4*caseno=4
resid_5*caseno=5
resid_6*caseno=6
resid_7*caseno=7
resid_8*caseno=8
resid_9*caseno=9
resid_10*caseno=10
zero*caseno=11
/overlay vaxis=-8 to 8 by 4 haxis=0 to 100 by 20;
title2 'Figure 4.4.6. Index plots of residuals';
title3 '(B)Residuals from clustered data (10 cases per cluster)';
title4 '';
run;

*Figure 4.4.6 (C): side by side boxplots: the* 
*cluster variable identifies each boxplot    *;

proc boxplot data=p446a;
plot resid_bc*cluster/vaxis=-8 to 8 by 4;
title2 'Figure 4.4.6. Index plots of residuals';
title3 '(C)Side by side boxplots of the 10 clusters';
title4 '';
run;

*Figure 4.4.6 (D): Autocorrelated residuals*;
*i=join joining the points*;

symbol1 v=dot i=join c=black;
symbol2 v=none i=join c=black;

proc gplot data=p446a;
plot 
resid_d*caseno=1
zero*caseno=2
/overlay vaxis=-10 to 10 by 5 haxis=0 to 100 by 20;
title2 'Figure 4.4.6. Index plots of residuals';
title3 '(D)Autocorrelated residuals (rho=.70)';
title4 '';
run;

*4.4.7 (p.148): Normal curve overlay: same procedure as before      *;
*In the histogram statement, normal produce the normal curve overlay*;

proc reg data=p421;
      model salary =year pub male cite;
      output out=p447
         r=yresid;
   run;

proc univariate data=p447;
histogram yresid/normal midpoints = -12500 -10000 -7500 -5000
       			      -2500 0 2500 5000 7500 10000 12500 
					  15000 17500 20000;
title2 'Figure 4.4.7 Plot to assess normality of the residuals';
title3 '(A) Histogram of residuals with normal curve overlay';
run;

*Figure 4.4.7 (B): Q-Q plot with straight line;

*probplot does the Q-Q plot. normal identifies the reference     * 
*distribution, and the mean and SD of the normal distribution are*
*estimated.                                                      *;

proc univariate data=p447;
 var yresid;
 probplot yresid/normal (mu=est sigma=est);
title2 'Figure 4.4.7 Plot to assess normality of the residuals';
title3 '(B)Normal q-q plot of residuals with superimposed straight line';
title4 '';
run;

*Figure 4.4.7 (C) is not presently available in SAS*;
