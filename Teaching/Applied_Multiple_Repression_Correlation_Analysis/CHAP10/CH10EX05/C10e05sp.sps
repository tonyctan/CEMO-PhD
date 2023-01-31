*Chapter 10 code by Oi-man Kwok and Steve West.     *
*Psychology department, Arizona State University    *
*This uses SPSS version 10.0.7. Later version of    *
*SPSS may incorporate additional features.          *.

Set Width=80.

Title 'Chapter 10 Table 10.5.1-2: Effect of Multicollinearity'.

******************************************************************
*Table 10.5.1 Effect of Multicollinearity: Two IV Example (p.421)*
******************************************************************.

**********************************************************
*Reading in correlation matrix:                          *
*Unlike the other codes in this book which use the raw   *
*data, this data command reads in the correlation matrix *
*and the following regression command permits analysis   *
*of the correlation matrix.                              *
**********************************************************;

*(A). Corrlelation between the two independent variable=0*
*N=100, Mean_X1 = Mean_X2=0, Mean_Y=20                   *
*Variance_X1 = 3, Variance_X2 = 4, Variance_Y = 5        *
*CORR_12=0, CORR_Y1=.30, CORR_Y2=.40, R-square=.250      *.

*Matrix command tells SPSS a matrix will be read. The   *
*lower diagonal commands in Format tells the program to *
*read in the lower triangle of the correlation matrix.  *
*The type of the data is indicated at the beginning of  *
*each row.                                              *.                  

Matrix data variables=rowtype_ X1 X2 Y
/Format = list lower diagonal.
begin data
corr    1.00
corr    0.00 1.00
corr    0.30 0.40 1.00
mean    0.00 0.00 20.00
std     1.732 2.000 2.236
N       100 100 100
end data.

EXECUTE.

*Table 10.5.1 (A)*.

*matix = in(*) tells SPSS to conduct a regression analysis*
*based on the current read in matrix                      *. 

Regression matrix = in (*)
/Statistics coeff r anova ses tol zpp
/Dependent Y
/Method = Enter X1 X2.

*"TOL" in "/Statistics" line: Request for the Tolerance and VIF*. 

EXECUTE.


*Read in the correlation matrix                             *
*(B). Corrlelation between the two independent variable=0.10*
*N=100, Mean_X1 = Mean_X2=0, Mean_Y=20                      *
*Variance_X1 = 3, Variance_X2 = 4, Variance_Y = 5           *
*CORR_12=0.10, CORR_Y1=.30, CORR_Y2=.40, R-square=.228      *.

Matrix data variables=rowtype_ X1 X2 Y
/Format = list lower diagonal.
begin data
corr    1.00
corr    0.10 1.00
corr    0.30 0.40 1.00
mean    0.00 0.00 20.00
std     1.732 2.000 2.236
N       100 100 100
end data.

EXECUTE.

*Table 10.5.1 (B)*.

Regression matrix = in (*)
/Statistics coeff outs r anova ses tol zpp
/Dependent Y
/Method = Enter X1 X2.

EXECUTE.


*Read in the correlation matrix                             *
*(C). Corrlelation between the two independent variable=0.50*
*N=100, Mean_X1 = Mean_X2=0, Mean_Y=20                      *
*Variance_X1 = 3, Variance_X2 = 4, Variance_Y = 5           *
*CORR_12=0.50, CORR_Y1=.30, CORR_Y2=.40, R-square=.173      *.

Matrix data variables=rowtype_ X1 X2 Y
/Format = list lower diagonal.
begin data
corr    1.00
corr    0.50 1.00
corr    0.30 0.40 1.00
mean    0.00 0.00 20.00
std     1.732 2.000 2.236
N       100 100 100
end data.

EXECUTE.

*Table 10.5.1 (C)*.

Regression matrix = in (*)
/Statistics coeff outs r anova ses tol zpp
/Dependent Y
/Method = Enter X1 X2.

EXECUTE.


*Read in the correlation matrix                             *
*(D). Corrlelation between the two independent variable=0.90*
*N=100, Mean_X1 = Mean_X2=0, Mean_Y=20                      *
*Variance_X1 = 3, Variance_X2 = 4, Variance_Y = 5           *
*CORR_12=0.90, CORR_Y1=.30, CORR_Y2=.40, R-square=.179      *.

Matrix data variables=rowtype_ X1 X2 Y
/Format = list lower diagonal.
begin data
corr    1.00
corr    0.90 1.00
corr    0.30 0.40 1.00
mean    0.00 0.00 20.00
std     1.732 2.000 2.236
N       100 100 100
end data.

EXECUTE.

*Table 10.5.1 (D)*.

Regression matrix = in (*)
/Statistics coeff outs r anova ses tol zpp
/Dependent Y
/Method = Enter X1 X2.

EXECUTE.


*Read in the correlation matrix                              *
*(E). Corrlelation between the two independent variable=0.949*
*N=100, Mean_X1 = Mean_X2=0, Mean_Y=20                       *
*Variance_X1 = 3, Variance_X2 = 4, Variance_Y = 5            *
*CORR_12=0.949, CORR_Y1=.30, CORR_Y2=.40, R-square=.224      *.

Matrix data variables=rowtype_ X1 X2 Y
/Format = list lower diagonal.
begin data
corr    1.00
corr    0.949 1.00
corr    0.30 0.40 1.00
mean    0.00 0.00 20.00
std     1.732 2.000 2.236
N       100 100 100
end data.

EXECUTE.

*Table 10.5.1 (E)*.

Regression matrix = in (*)
/Statistics coeff outs r anova ses tol zpp
/Dependent Y
/Method = Enter X1 X2.

EXECUTE.


*******************************************************************
*Table 10.5.2 Effect of Multicollinearity: Four IV Example (p.422)*
*******************************************************************.

*Read in the correlation matrix                              *
*(A). Corrlelation between the four independent variable=0   *
*N=100, Mean_X1 = Mean_X2= Mean_X3 = Mean_X4 =0, Mean_Y=20   *
*Variance_X1=3, Variance_X3=5, Variance_X2 = Variance_X4 = 4 *
*Variance_Y = 5, R-square=.495                               *
*CORR_12 = CORR_13 = CORR_23 = 0, CORR_i4 = 0                *
*CORR_Y1 = .30, CORR_Y3 = .40, CORR_Y2 = CORR_Y4 =.35,       *.

Matrix data variables=rowtype_ X1 X2 X3 X4 Y
/Format = list lower diagonal.
begin data
corr    1.00
corr    0.00 1.00
corr    0.00 0.00 1.00
corr    0.00 0.00 0.00 1.00
corr    0.30 0.35 0.40 0.30 1.00
mean    0.00 0.00 0.00 0.00 20.00
std     1.732 2.000 2.236 2.000 2.236
N       100 100 100 100 100
end data.

*Table 10.5.2 (A)*.

Regression matrix = in (*)
/Statistics coeff outs r anova ses tol zpp
/Dependent Y
/Method = Enter X1 X2 X3 X4.

EXECUTE.


*Read in the correlation matrix                              *
*(B). Corrlelation between the four independent variable=0   *
*N=100, Mean_X1 = Mean_X2= Mean_X3 = Mean_X4 =0, Mean_Y=20   *
*Variance_X1=3, Variance_X3 =5, Variance_X2 = Variance_X4 = 4*
*Variance_Y = 5, R-square=.325                               *
*CORR_12 = CORR_13 = CORR_23 = 0.933, CORR_i4 = 0            *
*CORR_Y1 = .30, CORR_Y3 = .40, CORR_Y2 = CORR_Y4 =.35,       *.

Matrix data variables=rowtype_ X1 X2 X3 X4 Y
/Format = list lower diagonal.
begin data
corr    1.00
corr    0.933 1.00
corr    0.933 0.933 1.00
corr    0.00 0.00 0.00 1.00
corr    0.30 0.35 0.40 0.35 1.00
mean    0.00 0.00 0.00 0.00 20.00
std     1.732 2.000 2.236 2.000 2.236
N       100 100 100 100 100
end data.

*Table 10.5.2 (B)*.

Regression matrix = in (*)
/Statistics coeff outs r anova ses tol zpp
/Dependent Y
/Method = Enter X1 X2 X3 X4.

EXECUTE.

