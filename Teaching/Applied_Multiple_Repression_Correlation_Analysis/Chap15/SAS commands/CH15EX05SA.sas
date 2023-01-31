/* CHAPTER 15, EXAMPLE 5, TABLE 15.4.2 OF MULTILEVEL MODELS OF YG */

title 'Chapter 15, Example 5, Table 15.4.2';
proc import datafile='c:\ccwa\chap15\data\c1505dt.txt' out=c1505 dbms=tab replace;
getnames=yes;
run;
/* Empirical Bayes Estimates */
proc mixed data=c1505 method=ml  noclprint covtest noitprint;
class id;
model yg = time   / solution ddfm=bw notest;
random intercept time / type=un subject=id solution;
run;
/* OLS Estimates */
proc reg data=c1505;
model yg=time;
by id;
run;
