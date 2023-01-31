*Chapter 10 code by Oi-man Kwok and Steve West.     *
*Psychology department, Arizona State University    *
*This uses SPSS version 10.0.7. Later version of    *
*SPSS may incorporate additional features.          *.

Set Width=80.

Title 'Figure 10.3.7 Effect of Adding a Single Data Point'.

*Adding the Extra Point: (p.407-408)                *
*(A) At the Mean of X, Mean of Y                    *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *.

Data list file='c:\ccwa\CHAP10\CH10EX02\C10e02dt1.txt'
/1 caseno 1-3 year 4-9 pub 10-15

variable label  caseno 'Case Number'
                year 'Years Since Ph.D.' 
                pub 'Number of Publications'.

EXECUTE.

**************************************************
*To get the regression model and diagnostics for *
*the (A)At the Mean of X, Mean of Y dataset      *
**************************************************.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL ZPP
  /DEPENDENT pub
  /METHOD=ENTER year
  /residuals=id (caseno)
  /Casewise all COOK LEVER SDRESID SDBETA SDFIT.  

EXECUTE.


**************************************************************************** 
*Figure 10.3.7(A) Effect of Adding a Single Data Point at Various Locations* 
****************************************************************************.

Graph
/Scatterplot(BIVAR)=year with pub
/Missing=Listwise
/Title='Figure 10.3.7 Effect of Adding a Single Data Point'
'at Various Locations: (A) At the Mean of X, Mean of Y'.

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
*    Check the "Total" option (which will create the           *
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



*(B) At Extreme X, Extreme Y (On Original Reg Line) *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *.

Data list file='c:\ccwa\CHAP10\CH10EX02\C10e02dt2.txt'
/1 caseno 1-3 year 4-9 pub 10-15

variable label  caseno 'Case Number'
                year 'Years Since Ph.D.' 
                pub 'Number of Publications'.

EXECUTE.

*******************************************************
*To get the regression model and diagnostics for      *
*the (B)At Extreme X, Extreme Y (On Original Reg Line)*
*******************************************************.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA COLLIN TOL ZPP
  /DEPENDENT pub
  /METHOD=ENTER year
  /residuals=id (caseno)
  /Casewise all COOK LEVER SDRESID SDBETA SDFIT.  

EXECUTE.


**************************************************************************** 
*Figure 10.3.7(B) Effect of Adding a Single Data Point at Various Locations* 
****************************************************************************.

Graph
/Scatterplot(BIVAR)=year with pub
/Missing=Listwise
/Title='Figure 10.3.7 Effect of Adding a Single Data Point at Various'
'Locations: (B) At Extreme X,Extreme Y (On Original Reg Line)'.

EXECUTE.

********************************************************* 
*For details of how to insert a linear regression line  *
*in the figure, see the instruction at Figure 10.3.7.(A)*
*********************************************************.


*(C) At the Mean of X, Extreme Value of Y           *
*There are three variables in the dataset:          *
*caseno, year, pub                                  *
*year: Years Since PhD                              *
*pub: Number of Publication                         *.

Data list file='c:\ccwa\CHAP10\CH10EX02\C10e02dt3.txt'
/1 caseno 1-3 year 4-9 pub 10-15

variable label  caseno 'Case Number'
                year 'Years Since Ph.D.' 
                pub 'Number of Publications'.

EXECUTE.

*******************************************************
*To get the regression model and diagnostics for      *
*the (C)At the Mean of X, Extreme Value of Y          *
*******************************************************.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA COLLIN TOL ZPP
  /DEPENDENT pub
  /METHOD=ENTER year
  /residuals=id (caseno)
  /Casewise all COOK LEVER SDRESID SDBETA SDFIT.  

EXECUTE.


**************************************************************************** 
*Figure 10.3.7(C) Effect of Adding a Single Data Point at Various Locations* 
****************************************************************************.

Graph
/Scatterplot(BIVAR)=year with pub
/Missing=Listwise
/Title='Figure 10.3.7 Effect of Adding a Single Data Point at'
'Various Locations: (C)At the Mean of X, Extreme Value of Y'.

EXECUTE.

********************************************************* 
*For details of how to insert a linear regression line  *
*in the figure, see the instruction at Figure 10.3.7.(A)*
*********************************************************.


*(D) At Extreme X, Extreme Y (Not on Original Reg Line)*
*There are three variables in the dataset:             *
*caseno, year, pub                                     *
*year: Years Since PhD                                 *
*pub: Number of Publication                            *.

Data list file='c:\ccwa\CHAP10\CH10EX02\C10e02dt4.txt'
/1 caseno 1-3 year 4-9 pub 10-15

variable label  caseno 'Case Number'
                year 'Years Since Ph.D.' 
                pub 'Number of Publications'.

EXECUTE.

***********************************************************
*To get the regression model and diagnostics for          *
*the (D)At Extreme X, Extreme Y (Not on Original Reg Line)*
***********************************************************.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA COLLIN TOL ZPP
  /DEPENDENT pub
  /METHOD=ENTER year
  /residuals=id (caseno)
  /Casewise all COOK LEVER SDRESID SDBETA SDFIT.  

EXECUTE.


**************************************************************************** 
*Figure 10.3.7(D) Effect of Adding a Single Data Point at Various Locations* 
****************************************************************************.

Graph
/Scatterplot(BIVAR)=year with pub
/Missing=Listwise
/Title='Figure 10.3.7 Effect of Adding a Single Data Point at Various'
'Locations: (D) At Extreme X,Extreme Y (Not on Original Reg Line)'.

EXECUTE.

********************************************************* 
*For details of how to insert a linear regression line  *
*in the figure, see the instruction at Figure 10.3.7.(A)*
*********************************************************.


