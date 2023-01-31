*Chapter 4 code by Oi-man Kwok and Steve West.      *
*Psychology department, Arizona State University    *
*This uses SPSS version 10.0.7. Later version of    *
*SPSS may incorporate additional features.          *.

Title 'Chapter 4 Figure 4.2.1 to Figure 4.4.7'.

*This generates most of the figures in section 4.2*
*through 4.4                                      *.

*Standard SPSS option for page formatting*.

Set Width=80.

*****************************************************
*There are seven variables in the dataset:          *
*caseno, caseno2, year, pub, male, cite, salary     *
*We will only use year, pub, male and salary here   *
*year: Years Since PhD                              *
*pub: Number of Publication                         *
*male: 1=male, 0=female					    *
*****************************************************.

*This reads the data for Chapter 4 into a file named *
*ch4.sav. Following the variable name are the columns*
*in which the data are found                         *.

Data list file='c:\ccwa\CHAP04\CH04EX01\C04e01dt1.txt'
/1 caseno 1-3 caseno2 4-6 year 7-9 pub 10-12
   male 13-15 cite 16-18 salary 19-24.

variable label caseno Case number.
variable label year Years since PhD. 
variable label pub Number of publications.
variable label cite Number of citations.

EXECUTE.

Save outfile = 'C:\Temp\ch4.sav'.

EXECUTE.

*4.2.1 (p.104): histograms*.
*In the box below the second EXECUTE statement is the description*
*of the point and click procedure to adjust the number of bins   *.

GRAPH
  /HISTOGRAM(NORMAL)=year
  /TITLE= 'Figure 4.2.1 Histogram of years since Ph.D.' '(A) Five bins'.

EXECUTE.

GRAPH
  /HISTOGRAM(NORMAL)=year
  /TITLE= 'Figure 4.2.1 Histogram of years since Ph.D.' '(B) Twenty bins'.

EXECUTE.

****************************************************************
*To change the number of bins of the histogram, you have to    *
*(1) Double left-click the graph from the output file to get   *
*    into the edit mode, which will open up a new window (SPSS *
*    Chart Editor)                                             *
*(2) Double click on the X-axis and a new dialog(Interval Axis)*
*    box comes out                                             *
*(3) Go to the "Intervals" section and click on "Custom" then  *
*    click "Define"                                            *
*(4) Change the number at the space of "# of intervals" to the *
*    number of bins you want and click "continuous"            *
*(5) Click "OK" and close the "Interval Axis" dialog box       *
* **************************************************************.                                    

*4.2.2 (p.105): Stem and leaf display*.

TITLE 'Figure 4.2.2 Stem and leaf display of years since Ph.D.'

EXAMINE
  VARIABLES=year
  /PLOT STEMLEAF
  /MISSING LISTWISE
  /NOTOTAL.

EXECUTE.

*Figure 4.2.3 kernel density estimate not presently available in*
*SPSS10                                                         *.

*4.2.4 (p.110): boxplot*.

TITLE 'Figure 4.2.4 boxplot of years since Ph.D.'

EXAMINE
  VARIABLES=year
  /PLOT Boxplot
  /MISSING LISTWISE
  /NOTOTAL
.

EXECUTE.

*4.2.5 (p.112): scatterplot*.
*The BIVAR produces the simple two variable scatterplot*.

TITLE 'Figure 4.2.5 Scatterplots and enhanced scatterplots'.

GRAPH
  /SCATTERPLOT(BIVAR)=year WITH salary
  /MISSING=LISTWISE 
  /TITLE 'Figure 4.2.5 Scatterplots and enhanced scatterplots'
         '(A) Basic Scatterplot: Salary vs years since PhD'.

EXECUTE.


*figure 4.2.5b*.
GRAPH
  /SCATTERPLOT(BIVAR)=male WITH year
  /MISSING=LISTWISE 
  /TITLE 'Figure 4.2.5 Scatterplots and enhanced scatterplots'
         '(B) Basic Scatterplot: Years since PhD vs Female'.

EXECUTE.

*Jittering is not available in SPSS10*.

*figure 4.2.5d*.
*The same syntax as figure 4.2.5a, with point and click modification*
*presented in box below                                             *.

GRAPH
  /SCATTERPLOT(BIVAR)=year WITH salary
  /MISSING=LISTWISE 
  /TITLE 'Figure 4.2.5 Scatterplots and enhanced scatterplots'
         '(D) Salary vs years since PhD: Superimposed regression line'.

EXECUTE.

****************************************************************
*To insert a regression line on the scatterplot, you have to   *
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
*(6) Close the "SPSS Chart Editor" (by clicking the "X" on the *
*    Top-Right corner of window) and you will see the fitted   *
*    regression line shown in the output file                  *
****************************************************************.


*figure 4.2.5e*.
*The same syntax as figure 4.2.5a, with point and click modification*
*to produce the lowess curve.  Figure F, G, and H apply lowess to   *
*another dataset from Chapter 6                                     *.


GRAPH
  /SCATTERPLOT(BIVAR)=year WITH salary
  /MISSING=LISTWISE 
  /TITLE 'Figure 4.2.5 Scatterplots and enhanced scatterplots'
         '(D) Superimposed lowess fit: Salary vs years since PhD'.

EXECUTE.

****************************************************************
*To insert a Lowess fit line on the scatterplot, you have to   *
*(1) Double left-click the graph from the output file to get   *
*    into the edit mode, which will open up a new window (SPSS *
*    Chart Editor)                                             *
*(2) In the new opened window, go to the menus bar and         *
*    click "Chart" then  "Option", which will open a new       *
*    dialog box (Scatterplot Options)                          *
*(3) From the new dialog box, go to the "Fit Line" part and    *
*    check the "Total" option (which will create the           *
*    Lowess fit line for the whole data).  Then go to click the*
*    "Fit Options", which will open another new dialog box     *
*    (Scatterplot Options: Fit Line)                           *
*(4) Click the "Lowess" option and fill in "% of Point to Fit" *
*    (Default is 50%).  Click "Continuous" and get back        *
*    to the "Scatterplot Options: Fit Line" dialog box         *
*(5) Click "OK" on the "Scatterplot Option" dialog box then you*
*    will see the Lowess fit line in the "SPSS Chart Editor"   *
*(6) Close the "SPSS Chart Editor" (by clicking the "X" on the *
*    Top-Right corner of window) and you will see the Lowess   *
*    fit line shown in the output file                         *
****************************************************************.

*4.2.6 (p.116): scatterplot matrix*.

Graph
/Scattterplot(matrix)=salary cite male pub year
/missing=listwise
/TITLE 'Figure 4.2.6 Faculty salary example: scatterplot matrix'.

EXECUTE.


*4.4.1 (p.126): residual plots*. 
*Regression model to produce residuals*.
*Statistics command: produces regression coefficients, multipleR,*
*ANOVA, multicollinearity indices (Chapter 10), tolerance        *
*(Chapter 10), and zero-order, partial, and part (semi-partial)  *
*correlation. Casewise command produces residuals and predicted  *
*values which then save in a file named ch441.sav.               *. 


REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA COLLIN TOL ZPP
  /DEPENDENT salary
  /METHOD=ENTER year pub male cite
  /residuals=id (caseno)
  /Casewise all RESID PRED
  /Save RESID (resid_s) PRED (pred_s).  

EXECUTE.

variable label resid_s Residual.
variable label pred_s Predicted values.


Save outfile = 'c:\Temp\ch441.sav'.

EXECUTE.

Get file='c:\Temp\Ch441.sav'.

EXECUTE.

*Figure 4.4.1a*.

Graph
/Scatterplot(BIVAR)=year with resid_s
/Missing=Listwise
/Title='Figure 4.4.1 Scatterplots of salary data'
'(A) Residuals vs year since Ph.D.'.

EXECUTE.


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
*For details of how to insert a Lowess fit line         *
*in the figure, see the instruction at Figure 4.2.5e    *
*********************************************************.

*Figure 4.4.1b*.

Graph
/Scatterplot(BIVAR)=pred_s with resid_s
/Missing=Listwise
/Title='Figure 4.4.1 Scatterplots of salary data'
'(B) Residuals vs predicted values'.

EXECUTE.

*Figure 4.4.2 same as Figure 4.4.1 applied to a dataset from*
*Chapter 6                                                  *.

*4.4.3 (p.129): added variable plot*.
*Two separate regression models are run (salary and cite as *
*the DVs), and the residuals of each are saved and matched  *
*Only a single line can be overlayed in SPSS10.  So straight*
*line and lowess curve overlays are produced separately     *.

Get file = 'C:\Temp\ch4.sav'.

EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA COLLIN TOL ZPP
  /DEPENDENT salary
  /METHOD=ENTER year pub male
  /residuals=id (caseno)
  /Casewise RESID
  /Save RESID (resid_s).  

EXECUTE.

variable label resid_s e(Salary|years publications male).

Save outfile = 'C:\Temp\ch443a.sav'.

EXECUTE.

Get file = 'C:\Temp\ch4.sav'.

EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF R ANOVA COLLIN TOL ZPP
  /DEPENDENT cite
  /METHOD=ENTER year pub male
  /residuals=id (caseno)
  /Casewise RESID
  /Save RESID (resid_c).  

EXECUTE.

variable label resid_c e(Citations|years publications male).

Save outfile = 'C:\Temp\ch443b.sav'.

EXECUTE.

Match files
/file ='C:\Temp\ch443a.sav'
/file ='C:\Temp\ch443b.sav'
/by caseno
/keep resid_s resid_c.

EXECUTE.

Graph
/Scatterplot(BIVAR)=resid_c with resid_s
/Missing=Listwise
/Title='Figure 4.4.3 Added varianle plot' 'Regression line'.

EXECUTE.

Graph
/Scatterplot(BIVAR)=resid_c with resid_s
/Missing=Listwise
/Title='Figure 4.4.3 Added varianle plot' 'Lowess fit line'.

EXECUTE.

*********************************************************
*Lowess fit line and regression line can only be fitted *
*separately in different graphs                         *
*********************************************************.

********************************************************* 
*For details of how to insert a regression line and a   *
*Lowess fit line in the figure, see the instruction     *
* at Figure 4.2.5d and Figure 4.2.5e                    *
*********************************************************.


*4.4.4 (p.131): scatterplots of residuals which is the same*
*scatterplot as Figure 4.4.1a & Figure 4.4.1b              *.

Get file='C:\Temp\Ch441.sav'.

EXECUTE.

*Figure 4.4.4a*.

Graph
/Scatterplot(BIVAR)=year with resid_s
/Missing=Listwise
/Title='Figure 4.4.4 Plots of residuals'
'(A) Residuals vs year since Ph.D.'.

EXECUTE.

********************************************************* 
*For details of how to insert a reference line (Y=0),   *
*see the instruction at Figure 4.4.1a                   *
*********************************************************.

*Figure 4.4.4b*.

Graph
/Scatterplot(BIVAR)=pred_s with resid_s
/Missing=Listwise
/Title='Figure 4.4.4 Scatterplots of salary data'
'(B) Residuals vs predicted values'.

EXECUTE.

********************************************************* 
*For details of how to insert a reference line (Y=0),   *
*see the instruction at Figure 4.4.1a                   *
*********************************************************.

*Figure 4.4.4c*.

Graph
/Scatterplot(BIVAR)=year with resid_s
/Missing=Listwise
/Title='Figure 4.4.4 Plots of residuals'
'(c) Residuals vs year since Ph.D. (Lowess fit added)'.

EXECUTE.

**********************************************************
*Confidence interval of Lowess fit line cannot be plotted*
**********************************************************.

********************************************************* 
*For details of how to insert a Lowess fit line in the  *
*figure, see the instruction at Figure 4.2.5e           *
*********************************************************.

*Figure 4.4.5 used the same procedure as in Figure 4.4.4 (C) with*
*other datasets                                                  *.

*4.4.6 (p.135): index plot of residuals           *
*Three different datasets are used for Figure (A),* 
*(B and C) and (D)                                *.

Data list file='c:\ccwa\CHAP04\CH04EX01\C04e01dt2.txt'
/1 caseno 1-3 cluster 4-6 resid_a 7-14 resid_bc 15-22
   resid_d 23-30.

Variable label caseno Case Number.
Variable label resid_a Residual. 
Variable label resid_bc Residual. 
Variable label resid_d Residual.

EXECUTE.

*Figure 4.4.6a*.

Graph
/Scatterplot(BIVAR)=caseno with resid_a
/Missing=Listwise
/Title='Figure 4.4.6 Index plots of residuals'
'(A) Independent residuals from a random sample'.

EXECUTE.

********************************************************* 
*For details of how to insert a reference line (Y=0),   *
*see the instruction at Figure 4.4.1a                   *
*********************************************************.

*Figure 4.4.6 (B): the residuals for each cluster were identified*
*by "cluster" in the scatterplot statement, and each cluster was *
*assigned for a different color                                  *.

Graph
/Scatterplot(BIVAR)=caseno with resid_bc by cluster
/Missing=Listwise
/Title='Figure 4.4.6 Index plots of residuals'
'(B) Residuals from clustered data (10 cases per cluster)'.

EXECUTE.

********************************************************* 
*For details of how to insert a reference line (Y=0),   *
*see the instruction at Figure 4.4.1a                   *
*********************************************************.

*Figure 4.4.6c*.
*In variables command indicates to plot by cluster*.

TITLE 'Figure 4.4.6(C) Side by side boxplots of the 10 clusters'.

Examine
variables = resid_bc by cluster
/Plot=Boxplot
/Statistics=none
/Nototal
/Missing=report.

EXECUTE.

*Figure 4.4.6d*.

Graph
/Scatterplot(BIVAR)=caseno with resid_d
/Missing=Listwise
/Title='Figure 4.4.6 Index plots of residuals'
'(D) Autocorrelated residuals (rho=.70)'.

EXECUTE.


********************************************************* 
*For details of how to join the points (i.e. insert a   *
*Lowess fit line with % of point to fit =1) in the      *
*figure, see the instruction at Figure 4.2.5e           *
*********************************************************.

********************************************************* 
*For details of how to insert a reference line (Y=0),   *
*see the instruction at Figure 4.4.1a                   *
*********************************************************.

*4.4.7 (p.138): Normal curve overlay and Q-Q plot*
*The (normal) in the histogram statement below   *
*produces the normal overlay                     *. 

*Using the same data as Figure 4.4.1*.

Get file='C:\Temp\Ch441.sav'.

EXECUTE.

*Figure 4.4.7a*.

GRAPH
  /HISTOGRAM(NORMAL)=resid_s
  /TITLE= 'Figure 4.4.7 Plot to assess normality of the residuals' 
  '(A) Histogram of residuals with normal curve overlay'.

EXECUTE.

*Note: SPSS10 reverses the X and Y axes on the Q-Q plot.  The plot*
*produced is the mirror image of Figure 4.4.7 (B)                 *.

TITLE 'Figure 4.4.7 Plot to assess normality of the residuals' 
  '(B) Normal Q-Q plot of residuals with superimposed straight line'.

*Figure 4.4.7b*.
PPLOT
/variables=resid_s
/Type=Q-Q
/dist=normal
/plot=normal
.

EXECUTE.

********************************************************* 
*For details of how to insert a regression line in the  *
*figure, see the instruction at Figure 4.2.5d           *
*********************************************************.

*SPSS10 cannot produce 95% CI for the Q-Q plot*.
