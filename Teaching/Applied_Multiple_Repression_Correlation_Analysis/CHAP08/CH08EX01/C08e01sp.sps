*Chapter 8 code by Oi-man Kwok and Steve West.      *
*Psychology department, Arizona State University    *
*This uses SPSS version 10.0.7. Later version of    *
*SPSS may incorporate additional features.          *.

Title 'Chapter 8 sections 8.2.4 to 8.5.3'.

***************************************************
*Demonstration of Different Coding Scheme         *
***************************************************.

*This is standard SPSS option to produce easy to read output.

Set Width=80.

*Read in the data file named c08e01dt.txt from c:\ccwa\ drive                 *
*There are three variables in the dataset: caseno, group (string) and ATA*.
Data list file='c:\ccwa\CHAP08\CH08EX01\c08e01dt.txt'
/1 caseno 1-3 group 4-5 (a) ATA 6-9.

EXECUTE.

Title 'Table 8.2.1B'.

********************************************************
*Create dummy coding for the "Group" variable          *
*Three Dummy codes are created: C1, C2 & C3            *
*Protestant is the reference group                     *
*See Table 8.2.1 (B) (p.304) and Table 8.2.3 (p.306)   *
********************************************************.

*C1 is equal to 1 for the "Catholic" group.
IF (group = 'c') c1 = 1 .
*C1 is equal to 0 for the "Jewish", "Other", and "Protestant" groups.
IF (group ~= 'c') c1 = 0 .	
*Label the new created C1 variable as "Dummy coding of the Catholic group".
variable label c1 Dummy coding of the Catholic group.

*C2 is equal to 1 for the "Jewish" group.
IF (group = 'j') c2 = 1 .	
*C2 is equal to 0 for the "Catholic", "Other", and "Protestant" groups.
IF (group ~= 'j') c2 = 0 .	
*Label the new created C2 variable as "Dummy coding of the Jewish group".
variable label c2 Dummy coding of the Jewish group.

*C3 is equal to 1 for the "Other" group.
IF (group = 'o') c3 = 1 .	
*C3 is equal to 0 for the "Jewish", "Catholic", and "Protestant" groups.
IF (group ~= 'o') c3 = 0 .	
*Label the new created C3 variable as "Dummy coding of the Other group".
variable label c3 Dummy coding of the Other group.

EXECUTE .

Title 'Table 8.2.4'.

*Table 8.2.4. Correlations, Means, and Standard Deviations of the*
*Illustrative data for Dummy-Coding (C1, C2 & C3) and ATA        *.
*Note: This produces the correlations, means and SDs. (p.307)    *.

CORRELATIONS
  /VARIABLES=ATA c1 c2 c3
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=LISTWISE .

EXECUTE.

Title 'Table 8.2.5 and Figure 8.2.1(c) '.

*Table 8.2.5 Analysis of Illustrative data  (p.307)*
*(Partial, Semipartial and Regression Coefficients)*
*Statistics command gives regression coefficients, *
*R square, ANOVA result, and zero order,           *
*partial, part (semi-partial) correlations.        *
*Scatterplot of the residuals vs. predicted values *
*is produced.                                      *
*Residuals are saved as a variable named resid.    *
*Figure 8.2.1(c) Scatterplot of Residual vs. Fit   *
*Values (p.314)                                    *
*Note: Only Figure 8.2.1(C) and (D) appear         *  
*immediately below.  Figure 8.2.1(A) and (B) are   *
*produced later                                    *.                           

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA ZPP
  /DEPENDENT ATA
  /METHOD=ENTER c1 c2 c3
  /Scatterplot=(*Resid,*Pred)
  /Save Resid (resid).

EXECUTE.

****************************************************************
*To insert the OLS regression line into the figure, you have to*
*(1) Double left-click the graph from the output file to get   *
*    into the edit mode, which will open up a new window (SPSS *
*    Chart Editor)                                             *
*(2) In the new opened window, go to the menus bar and         *
*    click "Chart" then  "Option", which will open a new       *
*    dialog box (Scatterplot Options)                          *
*(3) From the new dialog box, go to the "Fit Line" part and    *
*    Check the "Total" option (which will create the           *
*    regression line for the whole data).  Then go to click the*
*    "Fit Options", which will open another new dialog box     *
*    (Scatterplot Options: Fit Line)                           *
*(4) Click the "Linear Regression" option and the frame of the *
*    box will turn black.  Click "Continuous" and get back to  *
*    the "Scatterplot Options: Fit Line" dialog box            *
*(5) Click "OK" on the "Scatterplot Option" dialog box then you*
*    will see the fitted OLS regression line in the            *
*    "SPSS Chart Editor"                                       *
*(6) Close the "SPSS Chart Editor" (by clicking the "X" on the *
*    Top-Right corner of window) and you will see the fitted   *
*    OLS regression line shown in the output file              *
****************************************************************.

Title 'Figure 8.2.1(d)'.

*Figure 8.2.1(d) Q-Q Plot of Residuals Against Normal*
*Distribution                                        *.

PPLOT
/Variables = resid
/Type = Q-Q
/Dist = normal
/Plot = normal.

EXECUTE.

*NOTE: The Axes of the Q-Q PLOT reversed from the usual* 
*presentation described in Chapter 4                   *.


*Figures 8.2.1(A) and (B) are produced below (p.314)*.
Title 'Figure 8.1 (a)'.

*Create a new numerical variable (grouping) for groups*.
IF (group = 'c') grouping = 1 .
IF (group = 'p') grouping = 2 .
IF (group = 'j') grouping = 3 .
IF (group = 'o') grouping = 4 .

EXECUTE.

Save outfile='C:\Temp\ch8a.sav'.

EXECUTE.

GRAPH
  /SCATTERPLOT(BIVAR)=grouping WITH ata
  /MISSING=LISTWISE
  /TITLE= 'Figure 8.2.1 Result of Regression Analysis for Religious Group and'+
 ' ATA' '(a) Scatterplot of Raw Data'.

EXECUTE.


*Title 'Table 8.2.6'.

*Table 8.2.6 ANOVA of the attitudes toward abortion data (p.318)*.
ANOVA
/variables = ata by grouping (1,4).

Means
Tables = ata by group
/Cells mean count stddev.

EXECUTE.


Title 'Figure 8.2.1 (b)'.

*Figure 8.2.1(b) Scatterplot of Predicted ATA vs. Group      *
*Aggregate command is used to get the ata means of the groups*
*and save out to file fig81b.  The ata means on y-axis are   *
*then plotted against the group number on x-axis             *.

Aggregate
/outfile='C:\Temp\fig81b.sav'
/break=grouping
/predata=mean(ata).

EXECUTE.

Get file='C:\Temp\fig81b.sav'.
GRAPH
  /SCATTERPLOT(BIVAR)=grouping WITH predata
  /MISSING=LISTWISE
  /TITLE= 'Figure 8.2.1 Result of Regression Analysis for Religious Group and'+
 ' ATA' '(b) Scatterplot of Predicted ATA vs. Group'.

EXECUTE.

*Grouping: 1=Catholic, 2=Protestant, 3=Jewish, 4=Other*.

Get file='C:\Temp\ch8a.sav'.


Title 'Table 8.3.1 (B)'.

**************************************************************************
*Table 8.3.1b (B): Create Unweighted Effects coding of the "Group"       *
*variables. Three Unweighted Effects codes are created: UWC1, UWC2 & UWC3*
*Protestant is used as the base group. See table 8.3.1 (B). The logic is *
*the same as for dummy variables, except that the base group is assigned *
*a value -1. The computer codes for all analyeses below parallel those   *
*presented above for dummy codes. (p.323)                                *
**************************************************************************.

*UWC1 is equal to 1 for the "Catholic" group.
IF (group = 'c') uwc1 = 1 .
*UWC1 is equal to 0 for the "Jewish", and "Other" groups.
IF (group = 'j' | group = 'o') uwc1 = 0 .	
*UWC1 is equal to -1 for the "Protestant" groups.
IF (group = 'p') uwc1 = -1 .	
*Label the new created UWC1 variable as "Unweighted Effect coding of Catholic group".
variable label uwc1 Unweighted Effect coding of Catholic group.

*UWC2 is equal to 1 for the "Jewish" group.
IF (group = 'j') uwc2 = 1 .
*UWC2 is equal to 0 for the "Catholic", and "Other" groups.
IF (group = 'c' | group = 'o') uwc2 = 0 .	
*UWC2 is equal to -1 for the "Protestant" groups.
IF (group = 'p') uwc2 = -1 .	
*Label the new created UWC2 variable as "Unweighted Effect coding of Jewish group".
variable label uwc2 Unweighted Effect coding of Jewish group.

*UWC3 is equal to 1 for the "Other" group.
IF (group = 'o') uwc3 = 1 .
*UWC3 is equal to 0 for the "Catholic", and "Jewish" groups.
IF (group = 'c' | group = 'j') uwc3 = 0 .	
*UWC3 is equal to -1 for the "Protestant" groups.
IF (group = 'p') uwc3 = -1 .	
*Label the new created UWC3 variable as "Unweighted Effect coding of Other group".
variable label uwc3 Unweighted Effect coding of Other group.

EXECUTE.

*Table 8.3.3 & 8.3.4 Analysis of Illustrative data (p.324)    *.

Title 'Table 8.3.3'.

*Table 8.3.3. Correlations, Means, and Standard Deviations of the        *
*Illustrative data for Unweighted Effects Coding (UWC1, UWC2 & UWC3)     *.

CORRELATIONS
  /VARIABLES=ATA uwc1 uwc2 uwc3
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=LISTWISE .

EXECUTE.

Title 'Table 8.3.4'.

*Table 8.3.4 Analysis of Illustrative data (Partial, Semipartial and* 
*Regression Coefficients)                                           *.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA ZPP
  /DEPENDENT ATA
  /METHOD=ENTER uwc1 uwc2 uwc3  .

EXECUTE.


Title 'Table 8.4.1 (b)'.

*************************************************************************
*Table 8.4.1 (b): Create Weighted Effects coding of the "Group" variable*
*Three Weighted Effects codes are created: WC1, WC2 & WC3.  Protestant  *
*is used as the base group.  The logic is the same as for dummy coding, *
*except that the base group is assigned a value corresponding to the    *
*of the number of subjects in the two groups, see table 8.4.1. The      *
*computer codes for all analyses below parallel those presented above   *
*for dummy codes. (p.329 Table 8.4.1(B))                                *
*************************************************************************.

*WC1 is equal to 1 for the "Catholic" group.
IF (group = 'c') wc1 = 1 .
*WC1 is equal to 0 for the "Jewish", and "Other" groups.
IF (group = 'j' | group = 'o') wc1 = 0 .	
*WC1 is equal to -9/13 for the "Protestant" groups.
IF (group = 'p') wc1 = -9/13 .	
*Label the new created WC1 variable as "Weighted Effect coding of Catholic group".
variable label wc1 Weighted Effect coding of Catholic group.

*WC2 is equal to 1 for the "Jewish" group.
IF (group = 'j') wc2 = 1 .
*WC2 is equal to 0 for the "Catholic", and "Other" groups.
IF (group = 'c' | group = 'o') wc2 = 0 .	
*WC2 is equal to -6/13 for the "Protestant" groups.
IF (group = 'p') wc2 = -6/13 .	
*Label the new created WC2 variable as "Weighted Effect coding of Jewish group".
variable label wc2 Weighted Effect coding of Jewish group.

*WC3 is equal to 1 for the "Other" group.
IF (group = 'o') wc3 = 1 .
*WC3 is equal to 0 for the "Catholic", and "Jewish" groups.
IF (group = 'c' | group = 'j') wc3 = 0 .	
*WC3 is equal to -8/13 for the "Protestant" groups.
IF (group = 'p') wc3 = -8/13 .	
*Label the new created WC3 variable as "Weighted Effect coding of Other group".
variable label wc3 Weighted Effect coding of Other group.

EXECUTE.


Title 'Table 8.4.2'.

*Table 8.4.2 Analysis of Illustrative data  (p.330)*
*(Partial, Semipartial and Regression Coefficients)*.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA ZPP
  /DEPENDENT ATA
  /METHOD=ENTER wc1 wc2 wc3  .

EXECUTE.


Title 'Table 8.5.1 (a)'.

*************************************************************
*Table 8.5.1 (a): Create Contrast coding A                  *       
*(Minority vs. Majority Religions) of the "Group" variable  *
*Three Weighted Effects codes are created: CCA1, CCA2 & CCA3*
*Contrast codes represent the researcher's hypotheses and   *
*based on the three rules presented on p.333                *
*The computer codes for all analyses below parallel those   *
*presented above for dummy coding (p.336 Table 8.5.1(A))    *
*************************************************************.

*CCA1 is equal to .5 for the "Catholic" and "Protestant" group.
IF (group = 'c' | group = 'p') cca1 = .5 .
*CCA1 is equal to -.5 for the "Jewish" and "Other" group.
IF (group = 'j' | group = 'o') cca1 = -.5 .
*Label the new created CCA1 variable as "Constract coding A1: Catholic*
*& Protestant vs Jewish & Other"                                      *.
variable label cca1 Constract coding A1: Catholic & Protestant vs Jewish & Other.

*CCA2 is equal to .5 for the "Catholic" group.
IF (group = 'c') cca2 = .5 .
*CCA2 is equal to -.5 for the "Protestant" group.
IF (group = 'p') cca2 = -.5 .
*CCA2 is equal to 0 for the "Jewish" and "Other" group.
IF (group = 'j' | group = 'o') cca2 = 0 .
*Label the new created CCA2 variable as "Constract coding A2: Catholic vs. Protestant".
variable label cca2 Constract coding A2: Catholic vs Protestant.

*CCA3 is equal to .5 for the "Jewish" group.
IF (group = 'j') cca3 = .5 .
*CCA3 is equal to -.5 for the "Other" group.
IF (group = 'o') cca3 = -.5 .
*CCA3 is equal to 0 for the "Catholic" and "Protestant" group.
IF (group = 'c' | group = 'p') cca3 = 0 .
*Label the new created CCA3 variable as "Constract coding A3: Jewish vs. Other".
variable label cca3 Constract coding A3: Jewish vs Other.

EXECUTE.


Title 'Table 8.5.2'.

*Table 8.5.2 Analysis of Illustrative data         *
*(Partial, Semipartial and Regression Coefficients)*.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA ZPP
  /DEPENDENT ATA
  /METHOD=ENTER cca1 cca2 cca3  .

EXECUTE.


Title 'Table 8.5.1 (b)'.

*********************************************************************
*Table 8.5.1 (b): Create Contrast coding B (Value on women's rights)*
* of the "Group" variable                                           *
*Three Weighted Effects codes are created: CCB1, CCB2 & CCB3 (p.336)*
*********************************************************************.

*CCB1 is equal to .5 for the "Jewish" and "Protestant" group.
IF (group = 'j' | group = 'p') ccb1 = .5 .
*CCB1 is equal to -.5 for the "Catholic" and "Other" group.
IF (group = 'c' | group = 'o') ccb1 = -.5 .
*Label the new created CCB1 variable as "Constract coding B1: Jewish*
*& Protestant vs Catholic & Other"                                  *.
variable label ccb1 Constract coding B1: Jewish & Protestant vs Catholic & Other.

*CCB2 is equal to .5 for the "Jewish" group.
IF (group = 'j') ccb2 = .5 .
*CCB2 is equal to -.5 for the "Protestant" group.
IF (group = 'p') ccb2 = -.5 .
*CCB2 is equal to 0 for the "Catholic" and "Other" group.
IF (group = 'c' | group = 'o') ccb2 = 0 .
*Label the new created CCB2 variable as "Constract coding B2: Jewish vs. Protestant".
variable label ccb2 Constract coding B2: Jewish vs Protestant.

*CCB3 is equal to .5 for the "Other" group.
IF (group = 'o') ccb3 = .5 .
*CCB3 is equal to -.5 for the "Catholic" group.
IF (group = 'c') ccb3 = -.5 .
*CCB3 is equal to 0 for the "Jewish" and "Protestant" group.
IF (group = 'j' | group = 'p') ccb3 = 0 .
*Label the new created CCB3 variable as "Constract coding B3: Other vs. Jewish".
variable label ccb3 Constract coding B3: Other vs Jewish.

EXECUTE.


Title 'Table 8.5.3'.

*Table 8.5.3 Analysis of Illustrative data  (p.338)*
*(Partial, Semipartial and Regression Coefficients)*.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA ZPP
  /DEPENDENT ATA
  /METHOD=ENTER ccb1 ccb2 ccb3  .

EXECUTE.

