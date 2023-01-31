/* Chapter 12: Example 1 of 62 academic cases originally from chapter 3 */

title 'Chapter 12, Example 1'; 
proc import datafile='c:\ccwa\chap12\data\c1201dt.txt' out=c1201 dbms=tab replace;
getnames=yes;
run;
proc reg data=c1201;
model time=sex;
run;
proc reg data=c1201;
model pub=sex time;
run;
proc reg data=c1201;
model cit=sex time pub;
run;
proc reg data=c1201;
model salary=sex;
run;
proc reg data=c1201;
model salary=sex time;
run;
proc reg data=c1201;
model salary=sex time pub;
run;
proc reg data=c1201;
model salary=sex time pub cit;
run;
