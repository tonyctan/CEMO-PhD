*Chapter 8 code by Oi-man Kwok and Steve West.      *
*Psychology department, Arizona State University    *
*This uses SAS version 8.0.1. Later version of SAS  * 
*may incorporate additional features.               *;

*********************************************************************
*Comparing the effect of centered covariate and uncentered covariate*
*dummy coded variables                                              *
*********************************************************************;

options ovp nocenter linesize=80 pagesize=44;

*Read in the data file named c08e02dt.txt from c:\ccwa\ drive.          * 
*There are eight variables in the dataset:                         * 
*Town, City and Rural are dummy variables for identifying the type *
*of residence                                                      *
*Altruism, SES and Neurot are continuous uncentered variables      *
*SESC and Neurotc are the centered variables of SES and Neuroticism* 
*respectively                                                      *;

Title 'Chapter 8 Table 8.7.1 to Table 8.7.2';

Data ch8b; infile 'c:\ccwa\CHAP08\CH08EX02\C08e02dt.txt';
input town 1-8 city 9-16 rural 17-24 altruism 25-32 ses 33-40 
      neurot 41-48 sesc 49-56 neurotc 57-64;


*proc format creates value labels for the groups*;

proc format;
value rural 1='1-rural resident' 0='0-non-rural resident';
value town 1='1-small town resident' 0='0-non-small town resident';
value city 1='1-city resident' 0='0-non-city resident';
run;

*Table 8.7.1. Descriptive analysis of the City and Non-city*
*residents on Altruism, Neuroticism and SES                *;

*proc ttest performs unneeded t-test. It is used here to *
*produce the mean of each group (p.345)                  *;
 
proc ttest;
class city;
format city city.;
var altruism neurot;
title2;
title3 'Table 8.7.1. Descriptive analysis of the City and Non-city';
title4 ' residents on Altruism, Neuroticism and SES'; 
run;


*Table 8.7.2. (a) Means score by area on *
*Altruism, Neuroticism, and SES (p.349)  *;

*Rural residents (N=56);
*format statement transfers the value label for the group*;
 
proc sort; by rural;
proc means;
by rural;
format rural rural.;
var altruism neurot ses;
title2;
title3 'Table 8.7.2. (a) Means score by area on Altruism, Neuroticism,';
title4 'and SES: Rural residents (N=56)';
run;

*Small town residents (N=39);

proc sort; by town;
proc means;
by town;
format town town.;
var altruism neurot ses;
title2;
title3 'Table 8.7.2. (a) Means score by area on Altruism, Neuroticism,';
title4 'and SES: Small town residents (N=39)';
run;

*City residents (N=55);

proc sort; by city;
proc means;
by city;
format city city.;
var altruism neurot ses;
title2;
title3 'Table 8.7.2. (a) Means score by area on Altruism, Neuroticism,';
title4 'and SES: Small town residents (N=39)';
run;

*ALL residents (N=150);
proc means;
var altruism neurot ses;
title2;
title3 'Table 8.7.2. (a) Means score by area on Altruism, Neuroticism,';
title4 'and SES: ALL residents (N=150)';
run;


*Table 8.7.2. (b) Correlation matrix including dummy-variable coded*
* area (reference=Rural) (p.349)                                   *;

proc corr;
var altruism city rural ses neurot;
title2;
title3 'Table 8.7.2. (b) Correlation matrix including dummy-variable';
title4 'coded area (reference=Rural)';
run;

*Table 8.7.2. (c) Regression equation with and without centered*
*covariates (p.349)                                            *;

*Without centered covariates (Altruism predicted from rural and city)*;
*stb requests standardized regression coefficients (p.349)*;

proc reg;
model altruism = rural city/stb;
title2;
title3 'Table 8.7.2. (c) Regression equation without centered covariates';
run;
  
*Adding centered covariates (p.349 Table 8.7.2(D))*;
proc reg;
model altruism = rural city sesc neurotc/stb;
title2;
title3 'Table 8.7.2. (c) Regression equation with centered covariates';
run;

*Table 8.7.2. (d) Regression equation with uncentered*
*covariates (p.349 Table 8.7.2(E))                   *;

proc reg;
model altruism = rural city ses neurot/stb;
title2;
title3 'Table 8.7.2. (d) Regression equation with uncentered covariates';
run;

*Figure 8.7.1 Scatterplot of Altruism versus Neuroticism;
*New variables are created for overlay plots to identify*
*city and noncity residents (p.347)                     *;

data plot871; set ch8b;
if (city=1) then do;
 neucity=neurot;
 cneucity=neurotc;
end;

if (city=0) then do;
 neunonc=neurot;
 cneunonc=neurotc;
end;

*(a) Uncentered Neuroticism (p.347);
*the first command line under the plot statement of proc gplot*
*is the scatterplot of altruism against neurot.  The second   *
*command line is to plot the regression line for the city     *
*residents.  The third command line is to plot the regression *
*line for the noncity residents and to overlay the regression *
*lines. The symbol commands apply different symbols and colors*
*to distingish the regression lines and the points by group.   *;

proc gplot data=plot871;
plot altruism*neurot =1
     altruism*neucity = 2
     altruism*neunonc = 3/overlay;
symbol1 v=star c=w;
symbol2 v=C i=rl c=red;
symbol3 v=N i=rl c=blue;
title2;
title3 'Figure 8.7.1 Scatterplot of Altruism versus Neuroticism';
title4 '(a) Uncentered Neuroticism';
title5 'C (red line) City resident; N (blue line) Non-city resident';
run;

*(b) Centered Neuroticism (p.347);

proc gplot data=plot871;
plot altruism*neurotc =1
     altruism*cneucity = 2
     altruism*cneunonc = 3/overlay;
symbol1 v=star c=w;
symbol2 v=C i=rl c=red;
symbol3 v=N i=rl c=blue;
title2;
title3 'Figure 8.7.1 Scatterplot of Altruism versus Neuroticism';
title4 '(b) Centered Neuroticism';
title5 'C (red line) City resident; N (blue line) Non-city resident';
run;
