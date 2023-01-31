/* Chapter 2: BIVARIATE CORRELATION AND REGRESSION */
/* Table 2.10.2  Correlation and Regression of Number of Publications */
/*                on a Restricted Range of Time Since Ph.D. */

title 'Chapter 2: BIVARIATE CORRELATION AND REGRESSION -- Table 2.10.2';
data c0207;
input publicat time @@;
cards;
3 6 17 8 11 9 6 6 48 10 22 5 30 5 21 6 10 7 27 11
;
proc print;
run;
proc corr;
var publicat time;
run;
proc reg;
model publicat=time;
run;
