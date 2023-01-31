
***********************************************************
*SAS CODE FILE: C14E03SA.SAS
*Reads data file C14E01DT.TXT (same data as for CH14EX01)
*Multilevel data set of pounds lost as a function of
*motivation to lose weight and treatment
*Multilevel model, mixed model regressions
*Data simulation and analysis by Jennifer L. Krull, 
*             Univ. of Missouri-Columbia
*Table 14.5.1A. Random coefficient regression for 
*                computation of Intraclass correlation
*Table 14.5.1B. Random coefficient regression, prediction
*               from level one MOTIVATC predictor
*Table 14.9.1A. Multilevel model, prediction from level one
                MOTIVATC predictor and level two TREATMENT 
***********************************************************;

data a;
infile 'c:\ccwa\chap14\ch14ex03\c14e01dt.txt';
input group 1-2 member 4-5 treat 7 treatc 9-16 motivate 18 motivatc 20-27 pounds 29-30;

*********************************************************
*Data description, variable means and standard deviations
*Number of cases per group
*********************************************************;

proc means data=a;

proc freq;
tables GROUP;

*****************************************************
* proc mixed run for computing intraclass correlation
*  (ICC) for POUNDS lost, Table 14.5.1A (page 551)
* Random intercept only model
*****************************************************;

proc mixed covtest asycov  data=a;
class GROUP;
model POUNDS=/s ddfm=bw covb;
random int/type=un sub=GROUP;


*****************************************************
* proc mixed run for computing intraclass correlation
*    (ICC) for MOTIVATC (not tabled)
* Random intercept only model
******************************************************;

proc mixed covtest asycov  data=a;
class GROUP;
model MOTIVATC=/s ddfm=bw covb;
random int/type=un sub=GROUP;


**************************************************
*Random intercept plus level 1 predictor (MOTIVATC)
*Prediction of pounds lost from MOTIVATC at outset
*   of diet program, Table 14.5.1B  (page 551)
**************************************************;


proc mixed covtest asycov  data=a;
class GROUP;
model POUNDS=MOTIVATC/s ddfm=bw covb;
random int MOTIVATC/type=un sub=GROUP;


***********************************************************
*Multilevel analysis, prediction of pounds lost from
*motivation (level 1), treatment (level 2), and cross-level
*interaction between motivation and treatment
* Table 14.9.1A (page 557)
***********************************************************;

proc mixed covtest asycov  data=a;
class GROUP;
model POUNDS=TREATC MOTIVATC TREATC*MOTIVATC/s ddfm=bw covb;
random int MOTIVATC/type=un sub=GROUP;


*************************************************
*Estimation of fixed regression model in proc glm,
*Not in text
*************************************************;

proc glm data=a;
model POUNDS=TREATC MOTIVATC TREATC*MOTIVATC;

**************************************************
*Estimation of fixed regression model in proc reg
*Table 14.9.1B (page 557)
**************************************************;

data b; set a;
INTERACT=TREATC*MOTIVATC;

proc reg;
model POUNDS=TREATC MOTIVATC INTERACT;


run;

quit;
