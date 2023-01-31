/* CHAPTER 15, EXAMPLE 6, TABLE 15.4.3 OF MULTILEVEL MODELS OF YE AND YF */

title 'Chapter 15, Example 6, Table 15.4.3';
proc import datafile='c:\ccwa\chap15\data\c1506dt.txt' out=c1506 dbms=tab replace;
getnames=yes;
run;
/* YE Model 0 */
proc mixed data=c1506 method=ml noclprint covtest noitprint;
class id;
model ye =   / solution ddfm=bw notest;
run;
/* YE Model 1 */
proc mixed data=c1506 method=ml noclprint covtest noitprint;
class id;
model ye =    / solution ddfm=bw notest;
random intercept time / type=un subject=id;
run;
/* YE Model 2 */
proc mixed data=c1506 method=ml noclprint covtest noitprint;
class id;
model ye =time  / solution ddfm=bw notest;
random intercept time / type=un subject=id;
run;
/* YE Model 3 */
proc mixed data=c1506 method=ml noclprint covtest noitprint;
class id;
model ye =time lag1ye  / solution ddfm=bw notest;
random intercept time / type=un subject=id;
run;
/* YF Model 0 */
proc mixed data=c1506 method=ml noclprint covtest noitprint;
class id;
model yf =   / solution ddfm=bw notest;
run;
/* YF Model 1 */
proc mixed data=c1506 method=ml noclprint covtest noitprint;
class id;
model yf =    / solution ddfm=bw notest;
random intercept time / type=un subject=id;
run;
/* YF Model 2 */
proc mixed data=c1506 method=ml noclprint covtest noitprint;
class id wave;
model yf =  / solution ddfm=bw notest;
random intercept time / type=un subject=id;
repeated wave / type=ar(1) subject=id;
run;
/* YF Model 3 */
proc mixed data=c1506 method=ml noclprint covtest noitprint;
class id wave;
model yf = time group time*group  / solution ddfm=bw notest;
random intercept time / type=un subject=id;
repeated wave / type=ar(1) subject=id;
run;
