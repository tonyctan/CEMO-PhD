/* Chapter 2: BIVARIATE CORRELATION AND REGRESSION */
/* Table 2.2.1  Income and Major Household Appliances in Original Unites, */
/* Deviation Unites, and z Scores */

title 'Chapter 2: BIVARIATE CORRELATION AND REGRESSION -- Table 2.2.1';
data c0201;
input income applianc;
keep income applianc incc applc inc2 applc2 zincome zapplian;
incc=income-mean(24000,27000,29000,30000);
applc=applianc-mean(3,4,7,5);
inc2=incc*incc;
applc2=applc*applc;
zincome=income;
zapplian=applianc;
cards;
24000 3
27000 4
29000 7
30000 5
;
proc standard data=c0201 mean=0 std=1 out=cc0201;
var zincome zapplian;
run;
data ccc0201;
set cc0201;
zinc2=zincome*zincome;
zappl2=zapplian*zapplian;
output;
proc means data=ccc0201;
run;
proc print data=ccc0201;
run;
proc gplot;
plot applianc*income;
run;
proc gplot;
plot zapplian*zincome;
run;