/* CHAPTER 11: EXAMPLE 3 AND TABLE 11.3.2 OF 87 ACADEMIC CASES SOME WITH MISSING DATA */

title 'Chapter 11, Example 3'; 
proc import datafile='c:\ccwa\chap11\data\c1103dt.txt' out=c1103 dbms=tab replace;
getnames=yes;
run;
data cc1103;
set c1103;
/* we change the missing values from '999' to '.' */
if time=999 then time=.;
if pub=999 then pub=.;
if cit=999 then cit=.;
if cita=999 then cita=.;
/* The means used vary slightly from those used in the book and return different values */
timemean=time;
if time=. then timemean=6.772;
pubmean=pub;
if pub=. then pubmean=17.753;
citmean=cit;
if cit=. then citmean=38.614;
timemiss=0;
if time=. then timemiss=1;
pubmiss=0;
if pub=. then pubmiss=1;
citmiss=0;
if cit=. then citmiss=1;
output;
proc means data=cc1103;
run;

/* The first is listwise regression */
proc reg data=cc1103;
model salary=time pub cit sex;
run;

/* The second uses plugged means */
proc reg data=cc1103;
model salary=timemean pubmean citmean sex;
run;

/* The third uses plugged means and missing data dichotomies */
proc reg data=cc1103;
model salary=timemean pubmean citmean sex timemiss pubmiss citmiss;
run;

/* The fourth uses a pairwise covariance matrix */
proc reg data=cc1103;
model salary=timea puba citb sex;
run;

/* The fifth method uses an EM algorithm for the data with missing values */
/* by using SAS MI procedure with 1 imputation */
proc mi data=cc1103 nimpute=1 seed=88888 minimum=1 1 1 0 37939
        maximum=21 69 90 1 84071 round=1 out=ccc1103;
var time pub cit sex salary;
run;
data cccc1103;
set ccc1103;
keep time pub cit sex salary;
drop timemean timemiss pubmean pubmiss citmean citmiss cita citb timea puba;
output;
proc print data=cccc1103;
run;
proc reg data=cccc1103;
model salary=time pub sex cit;
run;

/* The final method uses an EM algorithm for the data with missing values */
/* by using SAS MI procedure with 5 imputations */
/* by using MIANALYZE procedure combines the results of the analyses of 5 imputations */
proc mi data=cc1103 nimpute=5 seed=88888 minimum=1 1 1 0 37939
        maximum=21 69 90 1 84071 round=1 out=ccccc1103;
var time pub cit sex salary;
run;
proc reg data=ccccc1103 outest=outreg covout;
model salary=time pub sex cit;
by _imputation_;
run;
proc mianalyze data=outreg;
var intercept time pub sex cit;
run;





