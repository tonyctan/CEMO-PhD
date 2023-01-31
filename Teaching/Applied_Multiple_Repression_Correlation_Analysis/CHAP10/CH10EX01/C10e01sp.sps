*Chapter 10 code by Oi-man Kwok and Steve West.     *
*Psychology department, Arizona State University    *
*This uses SPSS version 10.0.7. Later version of    *
*SPSS may incorporate additional features.          *.

Title 'Figure 10.2.1 to Figure 10.3.6'.

*This is the standard SPSS options that produces easy*
*to read output                                      *.

Set Width=80.

*(A) Original Data Set (N=15)                       *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *.

*Data list command produces a listing of the data*.

Data list file='c:\ccwa\CHAP10\CH10EX01\C10e01dt1.txt'
/1 caseno 1-3 year 4-6 pub 7-9.

variable label  caseno 'Case Number'
                year 'Years Since Ph.D.' 
                pub 'Number of Publications'.

EXECUTE.

Save outfile = 'C:\Temp\ch10_2_1a.sav'.

EXECUTE.

***************************************************
*To get the regression model and diagnostics for  *
*the original data set                            *
*missing listwise only includes cases with        * 
*complete data (see Chapter 11). Statistics       *
*command: coeff requests regression coefficient;  * 
*r requests multiple R; ANOVOA requests the ANOVA;* 
*collin requests multi-collinearity statistics;   *
*tol requests tolerance; ZPP requests the zero    *
*order, partial, and part (semi-partial)          *
*correlations. Casewise asks for the diagnostics. * 
*SDFIT in casewise command is the DFFITS.  SDBETA *
*in the casewise command is the DFBETAS. All      *
*diagnostics to be used later are saved.          *  
***************************************************.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA COLLIN TOL ZPP
  /DEPENDENT pub
  /METHOD=ENTER year
  /residuals=id (caseno)
  /Casewise all COOK LEVER SDRESID SDBETA SDFIT 
  /Save COOK (cook_D) LEVER (leverage) RESID (Residual) SDRESID (ES_resid)
   SDFIT (DFFITS) SDBETA (DFBETAS).  

EXECUTE.

Save outfile = 'C:\Temp\ch10_2_1a.sav'.

EXECUTE.


************************************************************* 
*Figure 10.2.1(A) Scatterplot of Years Since Ph.D. vs Number*
*of Publications                                            *  
*************************************************************.

*scatterplot (BIVAR) produce the simple scatterplot, with year*
*on y-axis and pub on x-axis. Point and Click instruction of  *
*adding a regression line is shown below                      *.

Graph
/Scatterplot(BIVAR)=year with pub
/Missing=Listwise
/Title='Figure 10.2.1 Plot of Years Since Ph.D. vs '
'Number of Publications (A) Original Data Set (N=15)'.

EXECUTE.

****************************************************************
*To insert the linear regression line, you have to             *
*(1) Double left-click the graph from the output file to get   *
*    into the edit mode, which will open up a new window (SPSS *
*    Chart Editor)                                             *
*(2) In the new opened window, go to the menus bar and         *
*    click "Chart" then  "Option", which will open a new       *
*    dialog box (Scatterplot Options)                          *
*(3) From the new dialog box, go to the "Fit Line" part and    *
*    check the "Total" option (which will create the           *
*    regression line for the whole data).  Then go to click the*
*    "Fit Options", which will open another new dialog box     *
*    (Scatterplot Options: Fit Line)                           *
*(4) Click the "Linear Regression" option and the frame of     *
*    the box will turn black.  Click "Continuous" and get back *
*    to the "Scatterplot Options: Fit Line" dialog box         *
*(5) Click "OK" on the "Scatterplot Option" dialog box then you*
*    will see the fitted OLS regression line in the            *
*    "SPSS Chart Editor"                                       *
*(6) To change the axis, you have to: For example, you want    *
*    to change the Y-Axis Range, double left-click on the      *
*    Y-Axis and the "Y Scale Axis" dialog box will come up.    *
*    At the center of the box, there is a part named "Range"   *
*    with minimum displayed value = 0 and maximum displayed    *
*    value = 50.  Change the maximum displayed value to 60 and *
*    click "OK" to close the dialog box                        *
*(7) Close the "SPSS Chart Editor" (by clicking the "X" on the *
*    Top-Right corner of window) and you will see the fitted   *
*    Quadratic regression line shown in the output file        *
****************************************************************.


*(B) Data Set Containing Outlier for Case 6 (N=15)  *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *.

Data list file='c:\ccwa\CHAP10\CH10EX01\C10e01dt2.txt'
/1 caseno 1-3 year 4-6 pub 7-9.

variable label  caseno 'Case Number'
                year 'Years Since Ph.D.' 
                pub 'Number of Publications'.

EXECUTE.

Save outfile = 'C:\Temp\ch10_2_1b.sav'.

EXECUTE.

**************************************************
*To get the regression model and diagnostics for *
*the Data Set Containing Outlier for Case 6      *
**************************************************.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL ZPP
  /DEPENDENT pub
  /METHOD=ENTER year
  /residuals=id (caseno)
  /Casewise all COOK LEVER SDRESID SDBETA SDFIT 
  /Save COOK (cook_D) LEVER (leverage) RESID (Residual) SDRESID (ES_resid)
   SDFIT (DFFITS) SDBETA (DFBETAS).  

EXECUTE.

Save outfile = 'C:\Temp\ch10_2_1b.sav'.

EXECUTE.


********************************************************************** 
*Figure 10.2.1(B) Plot of Years Since Ph.D. vs Number of Publications* 
**********************************************************************.

Graph
/Scatterplot(BIVAR)=year with pub
/Missing=Listwise
/Title='Figure 10.2.1 Plot of Years Since Ph.D. vs Number of'
'Publications (B) Data Set Containing Outlier for Case 6 (N=15)'.

EXECUTE.

********************************************************* 
*For details of how to insert a linear regression line  *
*in the figure, see the instruction at Figure 10.2.1.(A)*
*********************************************************.


*(C) Data Set Deleting Case 6 (N=14)                *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *.

Data list file='c:\ccwa\CHAP10\CH10EX01\C10e01dt3.txt'
/1 caseno 1-3 year 4-6 pub 7-9.

variable label  caseno 'Case Number'
                year 'Years Since Ph.D.' 
                pub 'Number of Publications'.

EXECUTE.

Save outfile = 'C:\Temp\ch10_2_1c.sav'.

EXECUTE.

**************************************************
*To get the regression model and diagnostics for *
*the Data Set Deleting Case 6                    *
**************************************************.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL ZPP
  /DEPENDENT pub
  /METHOD=ENTER year
  /residuals=id (caseno)
  /Casewise all COOK LEVER SDRESID SDBETA SDFIT 
  /Save COOK (cook_c) LEVER (h_c) RESID (resid_c) SDRESID (sdres_c)
   SDFIT (sdfit_c) SDBETA (sdbe_c).  

EXECUTE.

Save outfile = 'C:\Temp\ch10_2_1c.sav'.

EXECUTE.


********************************************************************** 
*Figure 10.2.1(C) Plot of Years Since Ph.D. vs Number of Publications* 
**********************************************************************.

Graph
/Scatterplot(BIVAR)=year with pub
/Missing=Listwise
/Title='Figure 10.2.1 Plot of Years Since Ph.D. vs Number of'
'Publications (C) Data Set Deleting Case 6 (N=14)'.

EXECUTE.

********************************************************* 
*For details of how to insert a linear regression line  *
*in the figure, see the instruction at Figure 10.2.1.(A)*
*********************************************************.


********************************************************
*Figure 10.3.1(A) Index Plot of Leverage vs Case Number*
********************************************************.

Get file='C:\Temp\Ch10_2_1a.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with leverage
/Missing=Listwise
/Title='Figure 10.3.1 Index Plot of Leverage vs Case Number'
'(A) Original Data Set'.


********************************************************
*Figure 10.3.1(B) Index Plot of Leverage vs Case Number*
********************************************************.

Get file='C:\Temp\Ch10_2_1b.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with leverage
/Missing=Listwise
/Title='Figure 10.3.1 Index Plot of Leverage vs Case Number'
'(B) Data Set Containing Outlier for Case 6'.


***************************************************
*Figure 10.3.2 Scatterplot of Time Since Ph.D. vs *
*Number of Publications (p.397)                   *
***************************************************.

*The same data set as 10.2.1(A), with an additional *
*data point (Centroid, Caseno=16)                   *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *.

Data list file='c:\ccwa\CHAP10\CH10EX01\C10e01dt4.txt'
/1 caseno 1-3 year 4-8 pub 9-13.

variable label  caseno 'Case Number'
                year 'Years Since Ph.D.' 
                pub 'Number of Publications'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=year with pub
/Missing=Listwise
/Title='Figure 10.3.2 Scatterplot of Time Since Ph.D.'
 'vs Number of Publications: With Centroid (Caseno=16)'.

EXECUTE.

****************************************************************
*To insert the Case Number to the data points, you have to     *
*(1) Double left-click the graph from the output file to get   *
*    into the edit mode, which will open up a new window (SPSS *
*    Chart Editor)                                             *
*(2) In the new opened window, go to the menus bar and         *
*    click "Chart" then  "Option", which will open a new       *
*    dialog box (Scatterplot Options)                          *
*(3) On the left side of the new dialog box, there is a section*
*    named "Case Label". Click on the "Reverse Triangle" and   *
*    you will see three options "OFF, ON, AS IF".  Choose "ON".*
*(4) Click "OK" on the "Scatterplot Option" dialog box then you*
*    will see the fitted OLS regression line in the            *
*    "SPSS Chart Editor"                                       *
*(5) Close the "SPSS Chart Editor" (by clicking the "X" on the *
*    Top-Right corner of window) and you will see the fitted   *
*    OLS regression line shown in the output file              *
****************************************************************.


*****************************************************************
*Figure 10.3.3(A) Index Plot of Residuals vs Case Number (p.399)*
*****************************************************************.

Get file='C:\Temp\Ch10_2_1a.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with residual
/Missing=Listwise
/Title='Figure 10.3.3 Index Plot of Residuals vs Case Number'
'(A) Original Data Set'.

****************************************************************
*To insert the "Reference Line (Y=0)" to the plot, you have to *
*(1) Double left-click the graph from the output file to get   *
*    into the edit mode, which will open up a new window (SPSS *
*    Chart Editor)                                             *
*(2) In the new opened window, go to the menus bar and         *
*    click "Chart" then  "Refernece line", which will open a   *
*    new dialog box (Axis Selection)                           *
*(3) Check the "Y Scale" option and click "OK".  A new dialog  *
*    box "Scale Axis Reference Lines" come up                  *
*(4) Because the reference line is Y=0, the space of "position *
*    of line(s)" should be filled with "0" (Zero)              *
*(5) Click "ADD" and then click "OK" to close the dialog box.  *
*    You will see the reference line on the figure             *
*(5) Close the "SPSS Chart Editor" (by clicking the "X" on the *
*    Top-Right corner of window) and you will see the fitted   *
*    OLS regression line shown in the output file              *
****************************************************************.


*********************************************************
*Figure 10.3.3(B) Index Plot of Residuals vs Case Number*
*********************************************************.

Get file='C:\Temp\Ch10_2_1b.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with residual
/Missing=Listwise
/Title='Figure 10.3.3 Index Plot of Residuals vs Case Number'
'(B) Data Set Containing Outlier for Case 6'.

EXECUTE.

********************************************************* 
*For details of how to insert a reference line  (Y=0)   *
*in the figure, see the instruction at Figure 10.3.3.(A)*
*********************************************************.



*********************************************************
*Figure 10.3.4(A) Index Plot of Externally Studentized  *
*Residuals (ti) vs. Case Number (p.401)                 *
*********************************************************.

Get file='C:\Temp\Ch10_2_1a.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with ES_resid
/Missing=Listwise
/Title='Figure 10.3.4 Index Plot of Externally Studentized' 
'Residuals vs Case Number: (A) Original Data Set'.

********************************************************* 
*For details of how to insert a reference line  (Y=0)   *
*in the figure, see the instruction at Figure 10.3.3.(A)*
*********************************************************.



*********************************************************
*Figure 10.3.4(B) Index Plot of Externally Studentized  *
*                 Residuals (ti) vs. Case Number        *
*********************************************************.

Get file='C:\Temp\Ch10_2_1b.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with ES_resid
/Missing=Listwise
/Title='Figure 10.3.4 Index Plot of Externally Studentized Residuals' 
'vs Case Number: (B) Data Set Containing Outlier for Case 6'.

EXECUTE.

********************************************************* 
*For details of how to insert a reference line  (Y=0)   *
*in the figure, see the instruction at Figure 10.3.3.(A)*
*********************************************************.


*****************************************************************
*Figure 10.3.5(A) Index Plot of (DFFITS) vs. Case Number (p.403)*
*****************************************************************.

Get file='C:\Temp\Ch10_2_1a.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with DFFITS
/Missing=Listwise
/Title='Figure 10.3.5 Index Plot of (DFFITS) vs Case Number'
 '(A) Original Data Set'.

********************************************************* 
*For details of how to insert a reference line  (Y=0)   *
*in the figure, see the instruction at Figure 10.3.3.(A)*
*********************************************************.



*********************************************************
*Figure 10.3.5(B) Index Plot of (DFFITS) vs. Case Number*
*********************************************************.

Get file='C:\Temp\Ch10_2_1b.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with DFFITS
/Missing=Listwise
/Title='Figure 10.3.5 Index Plot of (DFFITS) vs Case Number'
 '(B) Data Set Containing Outlier for Case 6'.

EXECUTE.

********************************************************* 
*For details of how to insert a reference line  (Y=0)   *
*in the figure, see the instruction at Figure 10.3.3.(A)*
*********************************************************.



**********************************************
*Figure 10.3.6(A) Index Plot of (DFBETAS) vs.* 
Case Number:Intercept (p.406)                *
**********************************************.

Get file='C:\Temp\Ch10_2_1a.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with DFBETA0
/Missing=Listwise
/Title='Figure 10.3.6 Index Plot of (DFBETAS) vs '
 'Case Number Intercept: (A) Original Data Set'.

********************************************************* 
*For details of how to insert a reference line  (Y=0)   *
*in the figure, see the instruction at Figure 10.3.3.(A)*
*********************************************************.



********************************************************************
*Figure 10.3.6(B) Index Plot of (DFBETAS) vs. Case Number:Intercept*
********************************************************************.

Get file='C:\Temp\Ch10_2_1b.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with DFBETA0
/Missing=Listwise
/Title='Figure 10.3.6 Index Plot of (DFBETAS) vs Case'
 'Number: Intercept (B) Data Set Containing Outlier for Case 6'.

EXECUTE.

********************************************************* 
*For details of how to insert a reference line  (Y=0)   *
*in the figure, see the instruction at Figure 10.3.3.(A)*
*********************************************************.


*****************************************************************
*Figure 10.3.6(C) Index Plot of (DFBETAS) vs. Case Number: Slope*
*****************************************************************.

Get file='C:\Temp\Ch10_2_1a.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with DFBETA1
/Missing=Listwise
/Title='Figure 10.3.6 Index Plot of (DFBETAS) vs '
 'Case Number Slope: (C) Original Data Set'.

********************************************************* 
*For details of how to insert a reference line  (Y=0)   *
*in the figure, see the instruction at Figure 10.3.3.(A)*
*********************************************************.



*****************************************************************
*Figure 10.3.6(D) Index Plot of (DFBETAS) vs. Case Number: Slope*
*****************************************************************.

Get file='C:\Temp\Ch10_2_1b.sav'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=caseno with DFBETA1
/Missing=Listwise
/Title='Figure 10.3.6 Index Plot of (DFBETAS) vs Case'
 'Number: Slope (D) Data Set Containing Outlier for Case 6'.

EXECUTE.

********************************************************* 
*For details of how to insert a reference line  (Y=0)   *
*in the figure, see the instruction at Figure 10.3.3.(A)*
*********************************************************.

