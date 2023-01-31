/* CHAPTER 11: EXAMPLE 1 AND TABLE 11.2.1 OF 90 CASES SOME WITH MISSING DATA */

title 'Chapter 11, Example 1, Table 11.2.1'; 
proc import datafile='c:\ccwa\chap11\data\c1101dt.txt' out=c1101 dbms=tab replace;
getnames=yes;
run;
data cc1101;
set c1101;
xmiss=1;
if x>-1 then xmiss=0;
xzero=x;
if xzero=. then xzero=0;
xmean=x;
if xmean=. then xmean=0.625;
xest=x;
if x=. then xest=0.545+0.255*y;
output;
proc reg data=cc1101;
model x=y;
run;
proc corr data=cc1101;
var y x xmiss xzero xmean xest;
run;
