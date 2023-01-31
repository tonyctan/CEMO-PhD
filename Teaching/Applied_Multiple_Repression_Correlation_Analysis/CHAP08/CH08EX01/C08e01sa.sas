*Chapter 8 code by Oi-man Kwok and Steve West.      *
*Psychology department, Arizona State University    *
*This uses SAS version 8.0.1. Later version of SAS  * 
*may incorporate additional features.               *;

***************************************************
*Demonstration of Different Coding Scheme         *
***************************************************;

Title 'Chapter 8 sections 8.2.4 to 8.5.3';

*These are standard SAS options that produce easy to read output;

options ovp nocenter linesize=80 pagesize=44;

*Read in the data file named c08e01dt.txt from c:\ccwa\ drive* 
*directory. There are three variables in the dataset:   *
*caseno, group (string) and ATA                         *;

Data ch8a; infile 'c:\ccwa\CHAP08\CH08EX01\c08e01dt.txt';
input caseno 1-3 group $ 4-5 ATA 6-9;

********************************************************
*Create dummy coding for the "Group" variable          *
*Three Dummy codes are created: C1, C2 & C3            *
*Protestant is the reference group                     *
*See Table 8.2.1 (B) (p.304) and Table 8.2.3 (p.306)   *
********************************************************;

Data Table821; set ch8a;
*C1 is equal to 1 for the "Catholic" group;
IF group = 'c' then c1 = 1 ;
*C1 is equal to 0 for the "Jewish", "Other", and "Protestant" groups;
else c1 = 0;
*Label the new created C1 variable as "Dummy coding of the Catholic group";
label c1 = 'Dummy coding of the Catholic group';

*C2 is equal to 1 for the "Jewish" group;
IF group = 'j' then c2 = 1;	
*C2 is equal to 0 for the "Catholic", "Other", and "Protestant" groups;
else c2 = 0;	
*Label the new created C2 variable as "Dummy coding of the Jewish group";
label c2 = 'Dummy coding of the Jewish group';

*C3 is equal to 1 for the "Other" group;
IF group = 'o' then c3 = 1;	
*C3 is equal to 0 for the "Jewish", "Catholic", and "Protestant" groups;
else c3 = 0;	
*Label the new created C3 variable as "Dummy coding of the Other group";
label c3 = 'Dummy coding of the Other group';

proc print; 
title2;
title3 'Table 8.2.3:Illustrative Data for Dummy-Variable Coding';
run;

*Table 8.2.4. Correlations, Means, and Standard Deviations of the*
*Illustrative data for Dummy-Coding (C1, C2 & C3) and ATA        *
*Note: This produces the correlations, means and SDs (p.307)     *;

proc corr;
var ata c1 c2 c3;
title2;
title3 'Table 8.2.4. Correlations, Means and Standard Deviations of the';
title4 'Illustrative data for Dummy-Coding Variables and ATA';
run;

*Table 8.2.4 & 8.2.5 Analysis of Illustrative data (p.307)    *
*Table 8.2.4: R-square, Adjusted R-square, & F-test result    *
*Table 8.2.5: Partial, Semipartial and Regression Coefficients*
*proc reg does multiple regression on data table821.          * 
*The model statement predicts ata from c1, c2 and c3.  stb    *
*requests the standardized coefficients.  pcorr2 requests the *
*squared partial correlation.  scorr2 requests the squared    *
*semi-partial correlation                                     *;

proc reg simple data=table821;
model ata = c1 c2 c3/stb pcorr2 scorr2;
title2;
title3 'Table 8.2.4: R-square, Adjusted R-square, & F-test result';
title4 'Table 8.2.5: Partial, Semipartial and Regression Coefficients';
run;  

*Table 8.2.6: ANOVA of the attitudes toward abortion data*
*proc anova does one way analysis of variance using group*
*as the factor.  means requests the group means (p.318)  *;

proc anova;
class group;
model ata = group;
means group; 
title2;
title3 'Table 8.2.6: ANOVA of the Attitudes Toward Abortion Data';
run;


*Figure 8.2.1 Results of Regression Analysis* 
*for Religious Groups and ATA (p.314)       *; 

*Figure 8.2.1(a) Scatterplot of Raw Data*
*The plot command puts ata on the Y-axis* 
*and group number on the x-axis         *;
 
proc gplot;
plot ata*group;
Title2;
Title3 'Figure 8.2.1(a) Scatterplot of Raw Data';
run;

*Figure 8.2.1(b) Scatterplot of Predicted ATA vs. Group*
*proc sort sorts the data by group.  proc means        *
*calculates the ata means by group, and the means are  *
*saved in file named plot821b for plotting Figure      * 
*8.2.1 (B).                                            *;

proc sort; by group;
proc means noprint;
by group;
var ata;
output out=plot821b
    mean=predATA;
run;

proc gplot data=plot821b;
plot predATA*group;
title2;
title3 'Figure 8.2.1(b) Scatterplot of Predicted ATA vs. Group';
title4 'C=Catholic, P=Protestant, J=Jewish, O=Other';
run;

*Figure 8.2.1(c) and Figure 8.2.1(d)              * 
*The regression is rerun to produce the residuals * 
*(residual=resid) and predicted values (predicted=*
*pred). These values are saved in file named      *
*plot81cd.                                        *;
                    
proc reg simple data=table821;
model ata = c1 c2 c3/stb pcorr2 scorr2;
title2;
title3 'Table 8.2.4: R-square, Adjusted R-square, & F-test result';
title4 'Table 8.2.5: Partial, Semipartial and Regression Coefficients';
output out=plot81cd
     predicted=pred
	 residual=resid;

plot residual. * predicted.;
title2;
title3 'Figure 8.2.1(c) Scatterplot of Residuals vs. Fit-values';
run;  

*Normal Q-Q plot                           *
*proc univariate produces the means and SDs*
*probplot specifies a Q-Q plot against the *
*normal distribution.  Mean and SDs are    *
*estimated from the data                   *;

proc univariate data=plot81cd noprint;
var resid;
probplot /normal (mu=est sigma=est);
title2;
title3 'Figure 8.1(d) Q-Q Plot of Residuals Against Normal';
run;


***********************************************************************
*Table 8.3.1-2: Create Unweighted Effects coding of the Group variable*
*Three Unweighted Effects codes are created: UWC1, UWC2 & UWC3        *
*Protestant is used as the base group.  See table 8.3.1(B)            *                                 
*The logic is the same as for dummy coding, except that the base group*
*is assigned a value -1                                               *
*The computer codes for all analyses below parallel those presented   *
*above for dummy codes. (p.323)                                       *
***********************************************************************;

Data Table831; set ch8a;
*UWC1 is equal to 1 for the "Catholic" group;
IF group = 'c' then uwc1 = 1;
*UWC1 is equal to 0 for the "Jewish", and "Other" groups;
IF group = 'j' | group = 'o' then uwc1 = 0;	
*UWC1 is equal to -1 for the "Protestant" groups";
IF group = 'p' then uwc1 = -1;	
*Label the new created UWC1 variable as      *
*"Unweighted Effect coding of Catholic group"*;
label uwc1 = 'Unweighted Effect coding of Catholic group';

*UWC2 is equal to 1 for the "Jewish" group;
IF group = 'j' then uwc2 = 1;
*UWC2 is equal to 0 for the "Catholic", and "Other" groups;
IF group = 'c' | group = 'o' then uwc2 = 0; 	
*UWC2 is equal to -1 for the "Protestant" groups;
IF group = 'p' then uwc2 = -1;	
*Label the new created UWC2 variable as    *
*"Unweighted Effect coding of Jewish group"*;
label uwc2 = 'Unweighted Effect coding of Jewish group';

*UWC3 is equal to 1 for the "Other" group;
IF group = 'o' then uwc3 = 1;
*UWC3 is equal to 0 for the "Catholic", and "Jewish" groups;
IF group = 'c' | group = 'j' then uwc3 = 0;	
*UWC3 is equal to -1 for the "Protestant" groups;
IF group = 'p' then uwc3 = -1;	
*Label the new created UWC3 variable as   *
*"Unweighted Effect coding of Other group"*;
label uwc3 = 'Unweighted Effect coding of Other group';

proc print;
title2;
title3 'Table 8.3.2:Illustrative Data for Unweighted Effects Coding';
run;

*Table 8.3.3. Correlations, Means, and Standard Deviations of the*
*Illustrative data for Unweighted Effects Coding (C1, C2 & C3)   *;

proc corr;
var ata uwc1 uwc2 uwc3;
title2;
title3 'Table 8.3.3. Correlations, Means and Standard Deviations of the';
title4 'Illustrative Data for Unweighted Effects Coding and ATA';
run;

*Table 8.3.3 & 8.3.4 Analysis of Illustrative data (p.324)    *
*Table 8.3.3: R-square, Adjusted R-square, & F-test result    *
*Table 8.3.4: Partial, Semipartial and Regression Coefficients*;

proc reg;
model ata = uwc1 uwc2 uwc3/stb pcorr2 scorr2;
title2;
title3 'Table 8.3.3: R-square, Adjusted R-square, & F-test Result';
title4 'Table 8.3.4: Partial, Semipartial and Regression Coefficients';
run;  


**************************************************************************
*Table 8.4.1 (b): Create Weighted Effects coding of the "Group" variable *
*Three Weighted Effects codes are created: WC1, WC2 & WC3                *
*Protestant is used as the base group. The logic is the same as for dummy*
*coding, except that the base group is assigned a value corresponding to *
*the ratio of the number of subjects. In the two groups, see table 8.4.1.* 
*The computer codes for all analyses below parallel those presented      *
*above for dummy codes. (p.329 Table 8.4.1(B))                           *
**************************************************************************;

Data Table841; set ch8a;
*WC1 is equal to 1 for the "Catholic" group;
IF group = 'c' then wc1 = 1;
*WC1 is equal to 0 for the "Jewish", and "Other" groups;
IF group = 'j' | group = 'o' then wc1 = 0;	
*WC1 is equal to -9/13 for the "Protestant" groups;
IF group = 'p' then wc1 = -9/13;	
*Label the new created WC1 variable as     *
*"Weighted Effect coding of Catholic group"*;
label wc1 = 'Weighted Effect coding of Catholic group';

*WC2 is equal to 1 for the "Jewish" group;
IF group = 'j' then wc2 = 1;
*WC2 is equal to 0 for the "Catholic", and "Other" groups;
IF group = 'c' | group = 'o' then wc2 = 0;	
*WC2 is equal to -6/13 for the "Protestant" groups;
IF group = 'p' then wc2 = -6/13;	
*Label the new created WC2 variable as   *
*"Weighted Effect coding of Jewish group"*;
label wc2 = 'Weighted Effect coding of Jewish group';

*WC3 is equal to 1 for the "Other" group;
IF group = 'o' then wc3 = 1;
*WC3 is equal to 0 for the "Catholic", and "Jewish" groups;
IF group = 'c' | group = 'j' then wc3 = 0;	
*WC3 is equal to -8/13 for the "Protestant" groups;
IF group = 'p' then wc3 = -8/13;	
*Label the new created WC3 variable as  * 
*"Weighted Effect coding of Other group"*;
label wc3 = 'Weighted Effect coding of Other group';

proc print;
title2;
title3 'Table 8.4.1(b):Illustrative Data for Weighted Effects Coding';
run;

*Table 8.4.2 Analysis of Illustrative data (p.330) *
*(Partial, Semipartial and Regression Coefficients)*;

proc reg;
model ata = wc1 wc2 wc3/stb pcorr2 scorr2;
title2;
title3 'Table 8.4.2 Partial, Semipartial and Regression Coefficients';
run;  


*************************************************************
*Table 8.5.1 (a): Create Contrast coding A                  *       
*(Minority vs. Majority Religions) of the "Group" variable  *
*Three contrast codes are created: CCA1, CCA2 & CCA3        *
*Contrast codes represent the reseacher's hypotheses and are*
*based on the three rules presented on p.333.               *
*The computer codes for all analyses below parallel those   * 
*presented above for dummy coding (p.336 Table 8.5.1(A))    *
*************************************************************;

Data Table851a; set ch8a;
*CCA1 is equal to .5 for the "Catholic" and "Protestant" group;
IF group = 'c' | group = 'p' then cca1 = .5;
*CCA1 is equal to -.5 for the "Jewish" and "Other" group;
IF group = 'j' | group = 'o' then cca1 = -.5;
*Label the new created CCA1 variable as "Constract coding*
*A1: Catholic & Protestant vs Jewish & Other"            *;
label cca1='Constract coding A1: Catholic & Protestant vs Jewish & Other';

*CCA2 is equal to .5 for the "Catholic" group;
IF group = 'c' then cca2 = .5;
*CCA2 is equal to -.5 for the "Protestant" group;
IF group = 'p' then cca2 = -.5;
*CCA2 is equal to 0 for the "Jewish" and "Other" group;
IF group = 'j' | group = 'o' then cca2 = 0;
*Label the new created CCA2 variable as "Constract coding*
A2: Catholic vs. Protestant"                             *;
label cca2 = 'Constract coding A2: Catholic vs Protestant';

*CCA3 is equal to .5 for the "Jewish" group;
IF group = 'j' then cca3 = .5;
*CCA3 is equal to -.5 for the "Other" group;
IF group = 'o' then cca3 = -.5;
*CCA3 is equal to 0 for the "Catholic" and "Protestant" group;
IF group = 'c' | group = 'p' then cca3 = 0;
*Label the new created CCA3 variable as "Constract coding*
*A3: Jewish vs. Other"                                   *;
label cca3 = 'Constract coding A3: Jewish vs Other';

proc print;
title2;
title3 'Table 8.5.1 (a):Illustrative Data for Constrast Coding A';
run;

*Table 8.5.2 Analysis of Illustrative data         *
*(Partial, Semipartial and Regression Coefficients)*;

proc reg;
model ata = cca1 cca2 cca3/stb pcorr2 scorr2;
title2;
title3 'Table 8.5.2 Partial, Semipartial and Regression Coefficients';
run;  


*********************************************************************
*Table 8.5.1 (b): Create Contrast coding B (Value on women's rights)*
*of the "Group" variable                                            *
*Three Weighted Effects codes are created: CCB1, CCB2 & CCB3 (p.336)*
*********************************************************************;

Data Table851b; set ch8a;
*CCB1 is equal to .5 for the "Jewish" and "Protestant" group;
IF group = 'j' | group = 'p' then ccb1 = .5;
*CCB1 is equal to -.5 for the "Catholic" and "Other" group;
IF group = 'c' | group = 'o' then ccb1 = -.5;
*Label the new created CCB1 variable as "Constract coding B1: Jewish*
*& Protestant vs Catholic & Other"                                  *;
label ccb1 = 'Constract coding B1: Jewish & Protestant vs 
Catholic & Other';

*CCB2 is equal to .5 for the "Jewish" group;
IF group = 'j' then ccb2 = .5;
*CCB2 is equal to -.5 for the "Protestant" group;
IF group = 'p' then ccb2 = -.5;
*CCB2 is equal to 0 for the "Catholic" and "Other" group;
IF group = 'c' | group = 'o' then ccb2 = 0;
*Label the new created CCB2 variable as "Constract coding*
*B2: Jewish vs. Protestant"                              *;
label ccb2 = 'Constract coding B2: Jewish vs Protestant';

*CCB3 is equal to .5 for the "Other" group;
IF group = 'o' then ccb3 = .5;
*CCB3 is equal to -.5 for the "Catholic" group;
IF group = 'c' then ccb3 = -.5;
*CCB3 is equal to 0 for the "Jewish" and "Protestant" group;
IF group = 'j' | group = 'p' then ccb3 = 0;
*Label the new created CCB3 variable as "Constract coding*
*B3: Other vs. Jewish"                                   *;
label ccb3 = 'Constract coding B3: Other vs Jewish';

proc print;
title2;
title3 'Table 8.5.1 (b):Illustrative Data for Constrast Coding B';
run;

*Table 8.5.3 Analysis of Illustrative data (p.338) *
*(Partial, Semipartial and Regression Coefficients)*;

proc reg;
model ata = ccb1 ccb2 ccb3/stb pcorr2 scorr2;
title2;
title3 'Table 8.5.3 Partial, Semipartial and Regression Coefficients';
run;
