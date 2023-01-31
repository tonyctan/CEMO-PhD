/* Chapter 9: Example 7 and Table 9.3.7 of Academic salary in three departments */

title 'Chapter 9, Example 7, Table 9.3.7'; 
proc import datafile='c:\ccwa\chap09\data\c0907dt.txt' out=c0907 dbms=tab replace;
getnames=yes;
run;
data cc0907;
set c0907;
timec=time-8.09;
timec2=timec*timec;
d1=0;
if depart=2 then d1=1;
d2=0;
if depart=3 then d2=1;
timed1=timec*d1;
timed2=timec*d2;
time2d1=timec2*d1;
time2d2=timec2*d2;
output;
proc reg data=cc0907;
model salaryx=timec timec2;
by depart;
run;
proc reg data=cc0907;
model salaryx=d1 d2 timec;
run;
proc reg data=cc0907;
model salaryx=d1 d2 timec timec2;
run;
proc reg data=cc0907;
model salaryx=d1 d2 timec timec2 timed1 timed2 time2d1 time2d2;
run;
