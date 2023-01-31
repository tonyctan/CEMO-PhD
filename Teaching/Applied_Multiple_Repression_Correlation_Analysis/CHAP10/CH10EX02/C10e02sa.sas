*Chapter 10 code by Oi-man Kwok and Steve West.     *
*Psychology department, Arizona State University    *
*This uses SAS version 8.0.1. Later version of SAS  * 
*may incorporate additional features.               *;

Title 'Figure 10.3.7 Effect of Adding a Single Data Point';

*Adding the Extra Point: (p.407-408)                *
*(A) At the Mean of X, Mean of Y                    *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *;

data p1037a; infile 'c:\ccwa\ChAP10\CH10EX02\C10e02dt1.txt';
input caseno 1-3 year 4-9 pub 10-15;

label caseno='Case Number'
      year='Years Since Ph.D.' 
      pub='Number of Publications';

**************************************************
*To get the regression model and diagnostics for *
*the (A)At the Mean of X, Mean of Y dataset      *
**************************************************;

proc reg data=p1037a;
id caseno;
model pub=year/stb r influence partial;
title2;
title3 'Regression Model & Diagnostics of Figure 10.3.7(A)';
title4 '(a)At the Mean of X, Mean of Y';
run;

proc gplot data=p1037a;
plot pub*year / vaxis=0 to 150 by 50 haxis=0 to 60 by 15;
symbol1 v=star i=rl c=blue;
title2;
title3 'Figure 10.3.7 Effect of Adding a Single Data Point';
title4 'at Various Locations: (A) At the Mean of X, Mean of Y';
run;


*Adding the Extra Point:                            *
*(B) At Extreme X, Extreme Y (On Original Reg Line) *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *;

data p1037b; infile 'c:\ccwa\ChAP10\CH10EX02\C10e02dt2.txt';
input caseno 1-3 year 4-9 pub 10-15;

label caseno='Case Number'
      year='Years Since Ph.D.' 
      pub='Number of Publications';


*******************************************************
*To get the regression model and diagnostics for      *
*the (B)At Extreme X, Extreme Y (On Original Reg Line)*
*******************************************************;

proc reg data=p1037b;
id caseno;
model pub=year/stb r influence partial;
title2;
title3 'Regression Model & Diagnostics of Figure 10.3.7(B)';
title4 '(B)At Extreme X, Extreme Y (On Original Reg Line)';
run;

proc gplot data=p1037b;
plot pub*year / vaxis=0 to 150 by 50 haxis=0 to 60 by 15;
symbol1 v=star i=rl c=blue;
title2;
title3 'Figure 10.3.7 Effect of Adding a Single Data Point at Various';
title4 'Locations: (B) At Extreme X,Extreme Y (On Original Reg Line)';
run;


*Adding the Extra Point:                            *
*(C) At the Mean of X, Extreme Value of Y           *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *;

data p1037c; infile 'c:\ccwa\ChAP10\CH10EX02\C10e02dt3.txt';
input caseno 1-3 year 4-9 pub 10-15;

label caseno='Case Number'
      year='Years Since Ph.D.' 
      pub='Number of Publications';


*******************************************************
*To get the regression model and diagnostics for      *
*the (C)At the Mean of X, Extreme Value of Y          *
*******************************************************;

proc reg data=p1037c;
id caseno;
model pub=year/stb r influence partial;
title2;
title3 'Regression Model & Diagnostics of Figure 10.3.7(C)';
title4 '(C)At the Mean of X, Extreme Value of Y ';
run;

proc gplot data=p1037c;
plot pub*year / vaxis=0 to 150 by 50 haxis=0 to 60 by 15;
symbol1 v=star i=rl c=blue;
title2;
title3 'Figure 10.3.7 Effect of Adding a Single Data Point at Various';
title4 'Locations: (C)At the Mean of X, Extreme Value of Y ';
run;


*Adding the Extra Point:                               *
*(D) At Extreme X, Extreme Y (Not on Original Reg Line)*
*There are three variables in the dataset:             *
*caseno, year, pub                                     *
*year: Years Since PhD                                 *
*pub: Number of Publication                            *;

data p1037d; infile 'c:\ccwa\ChAP10\CH10EX02\C10e02dt4.txt';
input caseno 1-3 year 4-9 pub 10-15;

label caseno='Case Number'
      year='Years Since Ph.D.' 
      pub='Number of Publications';


***********************************************************
*To get the regression model and diagnostics for          *
*the (D)At Extreme X, Extreme Y (Not on Original Reg Line)*
***********************************************************;

proc reg data=p1037d;
id caseno;
model pub=year/stb r influence partial;
title2;
title3 'Regression Model & Diagnostics of Figure 10.3.7(D)';
title4 '(D)At Extreme X, Extreme Y (Not on Original Reg Line)';
run;

proc gplot data=p1037d;
plot pub*year / vaxis=0 to 150 by 50 haxis=0 to 60 by 15;
symbol1 v=star i=rl c=blue;
title2;
title3 'Figure 10.3.7 Effect of Adding a Single Data Point at Various';
title4 'Locations: (D)At Extreme X, Extreme Y (Not on Original Reg Line)';
run;
