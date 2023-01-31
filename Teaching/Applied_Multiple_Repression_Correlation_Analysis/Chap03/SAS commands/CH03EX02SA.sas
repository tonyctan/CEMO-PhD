/* Chapter 3:  TWO OR MORE INDEPEDENT VARIABLES */
/* Table 3.5.1  Data on 62 Faculty Members */

title 'Chapter 3:  TWO OR MORE INDEPEDENT VARIABLES -- Table 3.5.1 ';
proc import datafile='c:\ccwa\chap03\data\c0302dt.txt' out=c0302 dbms=tab replace;
getnames=yes;
run;
data cc0302;
set c0302;
estsal=857.01*time+92.75*pubs-917.77*female+201.93*cits+39587.35;
output;
proc corr data=cc0302;
var time pubs female cits estsal;
run;
proc reg data=cc0302;
model salary=time pubs female cits;
run;
proc print data=cc0302;
run;

