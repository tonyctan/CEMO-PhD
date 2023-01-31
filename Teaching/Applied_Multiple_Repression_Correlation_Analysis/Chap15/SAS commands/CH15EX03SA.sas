/* CHAPTER 15: EXAMPLE 3 AND TABLE 15.3.3 OF REPEATED TRIALS TO TEST "STEELING" HYPOTHESIS */

title 'Chapter 15, Example 3'; 
proc import datafile='c:\ccwa\chap15\data\c1503dt.txt' out=c1503 dbms=tab replace;
getnames=yes;
run;
proc glm data=c1503;
class group;
model y1 y2 y3= group /nouni;
repeated time 3 (1 2 3) polynomial / summary;
means group;
run;
