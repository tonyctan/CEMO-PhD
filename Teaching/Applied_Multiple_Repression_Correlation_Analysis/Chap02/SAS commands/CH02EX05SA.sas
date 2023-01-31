/* Chapter 2: BIVARIATE CORRELATION AND REGRESSION */
/* Table 2.3.3  Correlation Between Two Sets of Ranks */

title 'Chapter 2: BIVARIATE CORRELATION AND REGRESSION -- Table 2.3.3';
data c0205;
input X_ Y_ @@;
keep X_ Y_ x xx y yy xy d dd;
x=X_-mean(4,2,3,5,1);
y=Y_-mean(2,1,4,3,5);
xx=x*x;
yy=y*y;
xy=x*y;
d=(X_-Y_);
dd=d*d;
cards;
4 2 2 1 3 4 5 3 1 5
;
proc corr;
var X_ Y_;
run;
proc print;
run;