*Chapter 10 code by Oi-man Kwok and Steve West.     *
*Psychology department, Arizona State University    *
*This uses SAS version 8.0.1. Later version of SAS  * 
*may incorporate additional features.               *;

Title 'Figure 10.4.1 Scatterplot of Huber (1981) example';

options ovp nocenter linesize=80 pagesize=44;

*cards allows the small dataset to be included in the program     *
*no_outlr: variable to identify the outlier (id=6) with no_outlr=0*;

*Huber example (p.414)*;

data huber;
input caseno x y no_outlr;
cards;
1 -4 2.48 1
2 -3 0.73 1
3 -2 -0.04 1
4 -1 -1.44 1
5 -0 -1.32 1
6 10 0.00 0
;

proc reg data=huber;
id caseno;
model y=x/stb r influence partial;
title2;
title3 'Regression Model & Diagnostics of Figure 10.4.1';
title4 '(a) Fit of Linear Model';
run;

*i=rl fits a linear regression line to the data*;

proc gplot data=huber;
plot y*x / vaxis=-4 to 3 by 1 haxis=-5 to 10 by 5;
symbol1 v=star i=rl c=blue;
title2;
title3 'Figure 10.4.1 (a) Fit of Linear Model';
run;

*Below we create the quadratic term X2*;

data p1041b; set huber;
x2=x*x;

*Y is regressed on X and X square*;
proc reg;
id caseno;
model y=x x2/stb r influence partial;
title2;
title3 'Regression Model & Diagnostics of Figure 10.4.1';
title4 '(b) Fit of Quadratic Model';
run;

*i=rq fits a quadratic regression line to the data*;

proc gplot;
plot y*x / vaxis=-4 to 3 by 1 haxis=-5 to 10 by 5;
symbol1 v=star i=rq c=blue;
title2;
title3 'Figure 10.4.1 (b) Fit of Quadratic Model';
run;

*case 6 is removed as no_outlr not equal to 0*;

data p1041c; set huber;
if no_outlr ne 0; 

proc reg;
id caseno;
model y=x/stb r influence partial;
title2;
title3 'Regression Model & Diagnostics of Figure 10.4.1 (c)';
title4 'Fit of Linear Model with Oultier Deleted';
run;

proc gplot;
plot y*x / vaxis=-4 to 3 by 1 haxis=-5 to 10 by 5;
symbol1 v=star i=rl c=blue;
title2;
title3 'Figure 10.4.1 (c) Fit of Linear Model with Oultier Deleted';
run;

