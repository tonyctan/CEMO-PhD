/* Chapter 9: Example 5 and Table 9.3.5 of Academic salary in three departments */

title 'Chapter 9, Example 5, Table 9.3.5'; 
proc import datafile='c:\ccwa\chap09\data\c0904dt.txt' out=c0905 dbms=tab replace;
getnames=yes;
run;
data cc0905;
set c0905;
pubd=pub-15.5;
d1=0;
if depart=2 then d1=1;
d2=0;
if depart=3 then d2=1;
sd1=0;
if depart=1 then sd1=pubd;
sd2=0;
if depart=2 then sd2=pubd;
sd3=0;
if depart=3 then sd3=pubd;
output;
proc reg data=cc0905;
model salary=pubd d1 d2;
run;
proc reg data=cc0905;
model salary=d1 d2 sd1 sd2 sd3;
run;
