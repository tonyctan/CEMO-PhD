/* Chapter 3:  TWO OR MORE INDEPEDENT VARIABLES */
/* Table 3.2.1  Senority, Publication, and Salary Data on 15 Faculty Members */

title 'Chapter 3:  TWO OR MORE INDEPEDENT VARIABLES -- Table 3.2.1';
proc import datafile='c:\ccwa\chap03\data\c0301dt.txt' out=c0301 dbms=tab replace;
getnames=yes;
run;
data cc0301;
set c0301;
estsal=983*time+122*pubs+43082;
ressal=salary-estsal;
output;
proc corr data=cc0301;
var time pubs salary;
run;
proc corr data=cc0301;
var salary estsal ressal;
run;
proc reg data=cc0301;
model salary=pubs;
run;
proc reg data=cc0301;
model salary=time;
run;
proc reg data=cc0301;
model salary=time pubs;
run;
proc print data=cc0301;
run;

