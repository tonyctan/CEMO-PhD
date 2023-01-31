/* CHAPTER 15, EXAMPLE 4, TABLE 15.4.1 OF MULTILEVEL MODELS OF YA AND YB */

title 'Chapter 15, Example 4, Table 15.4.1';
proc import datafile='c:\ccwa\chap15\data\c1504dt.txt' out=c1504 dbms=tab replace;
getnames=yes;
run;
/* YA Model 0 */
proc mixed data=c1504 method=ml noclprint covtest noitprint;
class id;
model ya =   / solution ddfm=bw notest;
run;
/* YA Model 1 */
proc mixed data=c1504 method=ml noclprint covtest noitprint;
class id;
model ya =    / solution ddfm=bw notest;
random intercept / type=un subject=id;
run;
/* YA Model 2 */
proc mixed data=c1504 method=ml noclprint covtest noitprint;
class id;
model ya =    / solution ddfm=bw notest;
random intercept time / type=un subject=id;
run;
/* YA Model 3 */
proc mixed data=c1504 method=ml noclprint covtest noitprint;
class id;
model ya = time / solution ddfm=bw notest;
random intercept time / type=un subject=id;
run;
/* YB Model 0 */
proc mixed data=c1504 method=ml noclprint covtest noitprint;
class id;
model yb =   / solution ddfm=bw notest;
run;
/* YB Model 1 */
proc mixed data=c1504 method=ml noclprint covtest noitprint;
class id;
model yb =    / solution ddfm=bw notest;
random intercept / type=un subject=id;
run;
/* YB Model 2 */
proc mixed data=c1504 method=ml noclprint covtest noitprint;
class id;
model yb =    / solution ddfm=bw notest;
random intercept time / type=un subject=id;
run;
/* YB Model 3 */
proc mixed data=c1504 method=ml noclprint covtest noitprint;
class id;
model yb = time / solution ddfm=bw notest;
random intercept time / type=un subject=id;
run;
/* YB Model 4 */
proc mixed data=c1504 method=ml noclprint covtest noitprint;
class id;
model yb = time group / solution ddfm=bw notest;
random intercept time / type=un subject=id;
run;
/* YB Model 5 */
proc mixed data=c1504 method=ml noclprint covtest noitprint;
class id;
model yb = time group time*group / solution ddfm=bw notest;
random intercept time / type=un subject=id;
run;
