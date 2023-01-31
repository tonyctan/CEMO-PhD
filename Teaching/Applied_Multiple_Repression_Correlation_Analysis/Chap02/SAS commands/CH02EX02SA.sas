/* Chapter 2: BIVARIATE CORRELATION AND REGRESSION */
/* Table 2.2.2  z Scores, z Score Differences, and z Score Products on Data Example */

title 'Chapter 2: BIVARIATE CORRELATION AND REGRESSION -- Table 2.2.2';
proc import datafile='c:\ccwa\chap02\data\c0202dt.txt' out=c0202 dbms=tab replace;
getnames=yes;
run;
data cc0202;
set c0202;
zx=time;
zy=pubs;
output;
proc standard data=cc0202 mean=0 std=1 out=ccc0202;
var zx zy;
run;
data cccc0202;
set ccc0202;
zx_zy=zx-zy;
zxzy=zx*zy;
output;
proc print data=cccc0202;
run;
proc means data=cccc0202;
run;
