/* CHAPTER 15: EXAMPLE 10 AND TABLE 15.7.1 OF SURVIVAL ANALYSIS OF TIME TO ROLE FAILURE */ 

title 'Chapter 15, Example 10'; 
proc import datafile='c:\ccwa\chap15\data\c1510dt.txt' out=c1510 dbms=tab replace;
getnames=yes;
run;
data cc1510;
set c1510;
censor=1;
if timeo=10 then censor=0;
output;
proc lifetest data=cc1510 plots=(s);
time timeo*censor(0);
strata group;
run;
proc phreg data=cc1510;
model timeo*censor(0)=group /rl;
run;
