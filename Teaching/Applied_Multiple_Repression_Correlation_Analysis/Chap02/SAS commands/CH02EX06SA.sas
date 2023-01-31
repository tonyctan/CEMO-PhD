/* Chapter 2: BIVARIATE CORRELATION AND REGRESSION */
/* Table 2.6.1  Estimated and Residual Scores for Academic Example */

title 'Chapter 2: BIVARIATE CORRELATION AND REGRESSION -- Table 2.6.1';
proc import datafile='c:\ccwa\chap02\data\c0206dt.txt' out=c0206 dbms=tab replace;
getnames=yes;
run;
data cc0206;
set c0206;
zpubs=pubs;
ztime=time;
output;
proc standard data=cc0206 mean=0 std=1 out=ccc0206;
var zpubs ztime;
run;
data cccc0206;
set ccc0206;
estpubs=4.731+1.983*time;
respubs=pubs-estpubs;
estzpubs=0.657*ztime;
reszpubs=zpubs-estzpubs;
estpubw=2.0*(time-7.667)+19.933;
respubw=pubs-estpubw;
estpubv=1.9*(time-7.667)+19.933;
respubv=pubs-estpubv;
absrest=abs(respubs);
absresw=abs(respubw);
absresv=abs(respubv);
output;
proc corr data=cccc0206;
var time pubs;
run;
proc reg data=cccc0206;
model pubs=time;
run;
proc means data=cccc0206;
run;
proc print data=cccc0206;
run;
