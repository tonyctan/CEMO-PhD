/* CHAPTER 15: EXAMPLE 1 AND FIGURE 15.2.1 OF MODELS OF SYMPTOMS, ROLE PERFORMANCE, AND EXPERIENCES */

title 'Chapter 15, Example 1'; 
proc import datafile='c:\ccwa\chap15\data\c1501dt.txt' out=c1501 dbms=tab replace;
getnames=yes;
run;
proc reg data=c1501;
model rperf2=sympt1;
run;
proc reg data=c1501;
model rperf2=sympt1 rperf1;
run;
proc reg data=c1501;
model rperf2=sympt1 rperf1 sympt2;
run;
proc reg data=c1501;
model rperf2=sympt1 rperf1 exper1;
run;
proc reg data=c1501;
model rperf2=sympt1 rperf1 exper2;
run;
proc reg data=c1501;
model rperf2=sympt1 rperf1 exper1_5;
run;
