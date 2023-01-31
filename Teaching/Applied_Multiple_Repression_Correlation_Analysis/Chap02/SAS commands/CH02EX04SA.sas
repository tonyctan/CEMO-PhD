/* Chapter 2: BIVARIATE CORRELATION AND REGRESSION */
/* Table 2.3.2  Fourfold Frequencies for Candidate Preference and Homenowning Status */

title 'Chapter 2: BIVARIATE CORRELATION AND REGRESSION -- Table 2.3.2';
proc import datafile='c:\ccwa\chap02\data\c0204dt.txt' out=c0204 dbms=tab replace;
getnames=yes;
run;
proc corr data=c0204;
var homeown candidat;
run;
proc freq data=c0204;
tables homeown*candidat/chisq;
run;

