*Chapter 10 code by Oi-man Kwok and Steve West.     *
*Psychology department, Arizona State University    *
*This uses SPSS version 10.0.7. Later version of    *
*SPSS may incorporate additional features.          *.

Title 'Figure 10.4.2 Illustration of a Clump of Outliers'.

Set Width=80.

*There are four variables in the dataset:           *
*caseno, year, pub, and pub65                       *
*year: Years Since PhD                              *
*pub: Number of Publication (N=65)                  *
*pub62: Number of Publication (N=62, not include the*
*       clump of outliers                           *.

Data list file='c:\ccwa\CHAP10\CH10EX04\C10e04dt.txt'
/1 caseno 1-2 year 3-10 pub62 11-18 pub 19-26.

EXECUTE.


*************************************************************
*To get the regression model and diagnostics for the group  *
*without the clump of outliers (Caseno = 63 64 and 65 are   *
*deleted). Pub62 has missing values for these cases and SPSS*
*does listwise deletion. See Chapter 11 on missing data.    *
*************************************************************.

*Figure 10.4.2 (p.416)*.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA COLLIN TOL ZPP
  /DEPENDENT pub62
  /METHOD=ENTER year
  /residuals=id (caseno)
  /casewise all COOK LEVER SDRESID SDBETA SDFIT .

EXECUTE.


************************************************************
*To get the regression model and diagnostics of the clump  *
*of outliers (Caseno = 63 64 and 65)                       *
************************************************************.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA COLLIN TOL ZPP
  /DEPENDENT pub
  /METHOD=ENTER year
  /residuals=id (caseno)
  /casewise all COOK LEVER SDRESID SDBETA SDFIT .

EXECUTE.

******************************************************************* 
*Figure 10.4.2 Illustration of a Clump of Outliers                *
*       Scatterplot of Years Since Ph.D. vs Number of Publications* 
*******************************************************************.

*This produces the overlay of two different regression lines.*
*vertical is label for y-axis. horizontal is label for x-axis*
*plot command tells to overlay data from pub62 and pub with  *
*year. The instructions for plotting the multiple regression *
*lines for different groups are shown in the box below.      *.

plot format=overlay
/title '10.4.2 Illustration of a Clump of Outliers'
/vertical = 'number of publication'
/horizontal = 'years since Ph.D.'
/plot pub62 pub with year.

EXECUTE.

****************************************************************
*In the figure you will see two groups marked by two different *
*colors (one group with the most observations (N=62), and the  *
*other group with only the three outliers (N=3)                * 
*To insert the OLS regression line for different conditions    *
*(with and without the clump of outliers), you have to         *
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
*    in the "SPSS Chart Editor"                                *
*(6) To change the Axis Range, double left-click on the        *
*    Axis you want to change.  For example, you want to change *
*    the range of the Y-axis, then you double left-click the   *
*    Y-axis, and the "Y Scale Axis" dialog box will come up.   *
*    At the center of the box, there is a part named "Range"   *
*    with minimum displayed value = 1 and maximum displayed    *
*    value = 69.  Change the minimum displayed value to 80 and *
*    click "OK" to close the dialog box                        *
*(7) You can also change the symbols and the colors of the     *
*    symbols and the regression lines.  For example, to change *
*    the symbols of the pub group (with the clump of the       *
*    outliers), you left click the symbol of the pub group at  *
*    the legend.  Then go to the manual bar and click the      *
*    "*" icon (Star shape icon).  Click on the shape you want  *
*    to apply (e.g. "X"), then click "Apply".  All the         *
*    observations in the pub group will turn to "X".  To change*
*    the color of the symbols or the regression lines, you     *
*    left click on the target you want to change color (e.g.   *
*    regression line of the pub group to blue), then right     *
*    click the "Crayon" icon.  Left click the color (e.g. blue)*
*    you want to use and then click "Apply".  The regression   *
*    line of the pub group will change to blue.  Click "close" *
*    to close the dialog box.                                  *
*(8) Close the "SPSS Chart Editor" (by clicking the "X" on the *
*    Top-Right corner of window) and you will see the fitted   *
*    OLS regression line shown in the output file              *
****************************************************************.
