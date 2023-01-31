*Chapter 10 code by Oi-man Kwok and Steve West.     *
*Psychology department, Arizona State University    *
*This uses SAS version 8.0.1. Later version of SAS  * 
*may incorporate additional features.               *;

Title 'Figure 10.4.2 Illustration of a Clump of Outliers';

options ovp nocenter linesize=80 pagesize=44;

*There are four variables in the dataset:           *
*caseno, year, pub, and pub65                       *
*year: Years Since PhD                              *
*pub: Number of Publication (N=65)                  *
*pub62: Number of Publication (N=62, not include the*
*       clump of outliers                           *;

Data p1042; infile 'c:\ccwa\ChAP10\CH10EX04\C10e04dt.txt';
input caseno 1-2 year 3-10 pub62 11-18 pub 19-26;

************************************************************
*To get the regression model and diagnostics for the group *
*without the clump of outliers (Caseno = 63 64 and 65 are  *
*deleted). Pub62 has missing values for these cases and SAS*
*does listwise deletion. See Chapter 11 on missing data.   *
************************************************************;

*Figure 10.4.2 (p.416)*;

proc reg;
id caseno;
model pub62 = year/stb r influence partial;
title2;
title3 'Regression Model and Diagnostics';
title4 'Without the Clump of Outliers (N=62)';
run;

************************************************************
*To get the regression model and diagnostics of the clump  *
*of outliers (Caseno = 63 64 and 65)                       *
************************************************************;
proc reg;
id caseno;
model pub = year/stb r influence partial;
title2;
title3 'Regression Model and Diagnostics';
title4 'With the Clump of Outliers (N=65)';
run;

******************************************************************* 
*Figure 10.4.2 Illustration of a Clump of Outliers                *
*       Scatterplot of Years Since Ph.D. vs Number of Publications* 
*******************************************************************;

proc gplot data=p1042;
plot pub*year =1
     pub62*year = 2
     /overlay;
symbol1 v=X i=rl c=blue;
symbol2 v=O i=rl c=red;
footnote1 j=l h=.3 cm c=blue f=titalic 'X -- With All Obs (N=65)';
footnote2 j=l h=.3 cm c=red f=titalic 'O+X -- Without Outliers (N=62)';
title2;
title3 'Scatterplot of Years Since Ph.D. vs Number of Publications';
run;

footnote1;
footnote2;
run;
