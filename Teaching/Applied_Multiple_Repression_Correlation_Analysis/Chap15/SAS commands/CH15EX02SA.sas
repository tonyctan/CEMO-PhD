/* CHAPTER 15: EXAMPLE 2 AND FIGURE 15.3.1 OF REPEATED ROLE PERFORMANCE FOR SUBJECTS IN TWO GROUPS */

title 'Chapter 15, Example 2'; 
proc import datafile='c:\ccwa\chap15\data\c1502dt.txt' out=c1502 dbms=tab replace;
getnames=yes;
run;
proc glm data=c1502;
class group;
model rperf1-rperf4= group /nouni;
repeated time 4 (1 2 3 4) polynomial / summary;
means group;
run;
