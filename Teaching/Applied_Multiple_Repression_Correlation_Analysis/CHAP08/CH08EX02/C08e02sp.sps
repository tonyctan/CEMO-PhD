*Chapter 8 code by Oi-man Kwok and Steve West.      *
*Psychology department, Arizona State University    *
*This uses SPSS version 10.0.7. Later version of    *
*SPSS may incorporate additional features.          *.

Title 'Chapter 8 Table 8.7.1 to Table 8.7.2'.

********************************************************************************
*Comparing the effect of centered covariate and uncentered covariate           *
*on dummy coded variables                                                      *
********************************************************************************.

Set Width=80.

*Read in the data file named c08e02dt.txt from c:\ccwa\ drive                       * 
*There are eight variables in the dataset:                                     * 
*Town, City and Rural are dummy variables for identifying the type of residence*
*Altruism, SES and Neurot are continuous uncentered variables                  *
*SESC and Neurotc are the centered variables of SES and Neurot respectively    *.

Data list file='c:\ccwa\CHAP08\CH08EX02\C08e02dt.txt'
/1 town 1-8 city 9-16 rural 17-24 altruism 25-32 ses 33-40 
    neurot 41-48 sesc 49-56 neurotc 57-64.

*value labels are used to identify groups by names*;

Value labels town 1 'small town resident' 0 'non-small town resident'.
Value labels city 1 'city resident' 0 'non-city resident'.
Value labels rural 1 'rural resident' 0 'non-rural resident'.

EXECUTE.

Title 'Table 8.7.1'.

*Table 8.7.1. Descriptive analysis of the City and Non-city residents*
*             on Altruism, Neurot and SES                            *.

*T-test performs unneeded t-test. It is used here to produce the mean*
*of each group. (p.345)                                              *.
                                           
T-TEST
  GROUPS=city(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=altruism neurot ses.

EXECUTE.


Title 'Table 8.7.2 (a)'.

*Table 8.7.2. (a) Means score by area on *
*Altruism, Neuroticism, and SES (p.349)  *.

*Rural resident*.
T-TEST
  GROUPS=rural(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=altruism neurot ses.

*City resident*.
T-TEST
  GROUPS=city(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=altruism neurot ses.

*Small-town resident*.
T-TEST
  GROUPS=town(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=altruism neurot ses.


*Total*.
DESCRIPTIVES
  VARIABLES=altruism ses neurot
  /STATISTICS=MEAN STDDEV MIN MAX .

EXECUTE.


Title 'Table 8.7.2 (b)'.

*Table 8.7.2. (b) Correlation matrix including dummy-variable coded*
* area (reference=Rural) (p.349)                                   *.

CORRELATIONS
  /VARIABLES=altruism city rural ses neurot
  /PRINT=TWOTAIL NOSIG
  /MISSING=LISTWISE .

EXECUTE.


Title 'Table 8.7.2 (c)'.

*Table 8.7.2. (c) Regression equation with and without centered *
*covariates (p.349)                                             *.

*Without centered covariates (Alturism predicted from *
*rural and city) (p.349)                              *.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA
  /DEPENDENT altruism
  /METHOD=ENTER rural city  .

*Adding centered covariates (p.349 Table 8.7.2(D))*.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA
  /DEPENDENT altruism
  /METHOD=ENTER rural city sesc neurotc .

EXECUTE.


Title 'Table 8.7.2 (d)'.

*Table 8.7.2. (d) Regression equation with uncentered* 
*covariates (p.349 Table 8.7.2(E))                   *.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA
  /DEPENDENT altruism
  /METHOD=ENTER rural city ses neurot .

EXECUTE.


Title 'Figure 8.7.1 (a)'.

*Figure 8.7.1 Scatterplot of Altruism versus Neuroticism*.
*Point and click instructions to overlay regression lines*
*are presented in box below. (p.347)                     *.

*(a) Uncentered Neuroticism (p.347).

Graph
/Scatterplot(BIVAR)=neurot with altruism by city
/Missing=Listwise
/Title='Figure 8.7.1(a) Scatterplot of Altruism versus '+
 'Uncentered Neuroticism'.


Title 'Figure 8.7.1 (b)'.

*(b) Centered Neuroticism (p.347).

Graph
/Scatterplot(BIVAR)=neurotc with altruism by city
/Missing=Listwise
/Title='Figure 8.7.1(b) Scatterplot of Altruism versus '+
 'Centered Neuroticism'.

EXECUTE.

****************************************************************
*To insert the OLS regression line, you have to                *
*(1) Double left-click the graph from the output file to get   *
*    into the edit mode, which will open up a new window (SPSS *
*    Chart Editor)                                             *
*(2) In the new opened window, go to the menus bar and         *
*    click "Chart" then  "Option", which will open a new       *
*    dialog box (Scatterplot Options)                          *
*(3) From the new dialog box, go to the "Fit Line" part and    *
*    Check the "subgroup" option (which will create the        *
*    regression line for each group).  Then go to click the    *
*    "Fit Options", which will open another new dialog box     *
*    (Scatterplot Options: Fit Line)                           *
*(4) Click the "Linear Regression" option and the frame of the *
*    box will turn black.  Click "Continuous" and get back to  *
*    the "Scatterplot Options: Fit Line" dialog box            *
*(5) Click "OK" on the "Scatterplot Option" dialog box then you*
*    will see the fitted OLS regression line to separate groups*
*    in the "SPSS Chart Editor".                               *
*(6) Close the "SPSS Chart Editor" (by clicking the "X" on the *
*    Top-Right corner of window) and you will see the fitted   *
*    OLS regression line shown in the output file              *
****************************************************************.
