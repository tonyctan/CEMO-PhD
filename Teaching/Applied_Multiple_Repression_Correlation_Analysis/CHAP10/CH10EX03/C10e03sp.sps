*Chapter 10 code by Oi-man Kwok and Steve West.     *
*Psychology department, Arizona State University    *
*This uses SPSS version 10.0.7. Later version of    *
*SPSS may incorporate additional features.          *.

Title 'Chapter 10 Figure 10.4.1 Scatterplot of Huber (1981) Example'.

Set Width=80.

*There are four variables in the dataset:                       *
*caseno, X, Y, and No_Outlr (for identify the outlier (caseno=6)*.              

*Huber example (p.414)*.

Data list file='c:\ccwa\CHAP10\CH10EX03\C10e03dt.txt'
/1 caseno 1 X 2-9 Y 10-17 No_outlr 18-25.

EXECUTE.

***************************************
*Figure 10.4.1 (A) Fit of Linear Model*
***************************************.

*Regression Model & Diagnostics 10.4.1 (A)*.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA
  /DEPENDENT Y
  /METHOD=ENTER X 
  /residuals=id (caseno)
  /casewise all COOK LEVER SDRESID SDBETA SDFIT .

EXECUTE.

*Figure 10.4.1 (A)*.

Graph
/Scatterplot(BIVAR)=X with Y
/Missing=Listwise
/Title='Figure 10.4.1 (A) Fit of Linear Model'.

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



******************************************
*Figure 10.4.1 (B) Fit of Quadratic Model*
******************************************.

*Regression Model & Diagnostics 10.4.1 (B)*.

*Create the Quadratic term X-Square*.
Compute X2=X*X.

Execute.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA
  /DEPENDENT Y
  /METHOD=ENTER X X2
  /residuals=id (caseno)
  /casewise all COOK LEVER SDRESID SDBETA SDFIT .


EXECUTE.

*Figure 10.4.1 (A)*.

Graph
/Scatterplot(BIVAR)=X with Y
/Missing=Listwise
/Title='Figure 10.4.1 (B) Fit of Linear Model'.

EXECUTE.

****************************************************************
*To insert the Quadratic regression line, you have to          *
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
*(4) Click the "Quadratic Regression" option and the frame of  *
*    the box will turn black.  Click "Continuous" and get back *
*    to the "Scatterplot Options: Fit Line" dialog box         *
*(5) Click "OK" on the "Scatterplot Option" dialog box then you*
*    will see the fitted OLS regression line in the            *
*    "SPSS Chart Editor"                                       *
*(6) To change the Y-Axis Range, double left-click on the      *
*    Y-Axis and the "Y Scale Axis" dialog box will come up.    *
*    At the center of the box, there is a part named "Range"   *
*    with minimum displayed value = -2 and maximum displayed   *
*    value = 3.  Change the minimum displayed value to -4 and  *
*    click "OK" to close the dialog box                        *      
*(7) Close the "SPSS Chart Editor" (by clicking the "X" on the *
*    Top-Right corner of window) and you will see the fitted   *
*    Quadratic regression line shown in the output file        *
****************************************************************.


************************************************************
*Figure 10.4.1 (C) Fit of Linear Model With Outlier Deleted*
************************************************************.

*Regression Model & Diagnostics 10.4.1 (C)*.

Select if (caseno ~= 6).

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA
  /DEPENDENT Y
  /METHOD=ENTER X 
  /residuals=id (caseno)
  /casewise all COOK LEVER SDRESID SDBETA SDFIT .


EXECUTE.

*Figure 10.4.1 (C)*.

Graph
/Scatterplot(BIVAR)=X with Y
/Missing=Listwise
/Title='Figure 10.4.1 (C) Fit of Linear Model With Outlier Deleted'.

EXECUTE.

****************************************************************
*To insert the OLS regression line, follow the instruction from*
*the previous section (Figure 10.4.1 (A))                      *
****************************************************************.
