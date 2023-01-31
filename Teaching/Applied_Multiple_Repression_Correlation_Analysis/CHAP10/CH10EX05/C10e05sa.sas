*Chapter 10 code by Oi-man Kwok and Steve West.     *
*Psychology department, Arizona State University    *
*This uses SAS version 8.0.1. Later version of SAS  * 
*may incorporate additional features.               *;

Title 'Chapter 10 Table 10.5.1-2: Effect of Multicollinearity';

options ovp nocenter linesize=80 pagesize=44;

******************************************************************
*Table 10.5.1 Effect of Multicollinearity: Two IV Example (p.421)*
******************************************************************;

**********************************************************
*Reading in correlation matrix:                          *
*Unlike the other codes in this book which use the raw   *
*data, this data command reads in the correlation matrix *
*and the following proc reg permits analysis of the      *
*correlation matrix.                                     *
**********************************************************;

*(A). Corrlelation between the two independent variable=0*
*N=100, Mean_X1 = Mean_X2=0, Mean_Y=20                   *
*Variance_X1 = 3, Variance_X2 = 4, Variance_Y = 5        *
*CORR_12=0, CORR_Y1=.30, CORR_Y2=.40, R-square=.250      *;

*(type=corr) tells SAS that we are going to use a        *
*correlation matrix. missover tells SAS that we are only *
*using the lower triangle. Mean, Standard deviation and N*
*for each variable are in the rows below the corrletion  *
*matrix.                                                 *;

data t1051a (type=corr);
infile cards missover;
input _type_ $ _name_ $ X1 X2 Y;
cards;
corr X1   1.00
corr X2   0.00 1.00
corr Y    0.30 0.40 1.00
mean mean 0.00 0.00 20.00
std  std  1.732 2.000 2.236
N    N    100 100 100
;

*stb requests standardized regression coefficients. tol   *
*requests the tolerance. vif requests VIF. pcorr2 requests*
*the squared partial correlations. scorr2 requests the    *
*squared semi-partial correlations.                       *;

proc reg;
model y= x1 x2/stb tol vif pcorr2 scorr2;
title2;
title3 'Table 10.5.1 (A) Corr Between X1 & X2= .00';
run;


*Read in the correlation matrix                             *
*(B). Corrlelation between the two independent variable=0.10*
*N=100, Mean_X1 = Mean_X2=0, Mean_Y=20                      *
*Variance_X1 = 3, Variance_X2 = 4, Variance_Y = 5           *
*CORR_12=0.10, CORR_Y1=.30, CORR_Y2=.40, R-square=.228      *;

data t1051b (type=corr);
infile cards missover;
input _type_ $ _name_ $ X1 X2 Y;
cards;
corr X1   1.00
corr X2   0.10 1.00
corr Y    0.30 0.40 1.00
mean mean 0.00 0.00 20.00
std  std  1.732 2.000 2.236
N    N    100 100 100
;

proc reg;
model y= x1 x2/stb tol vif pcorr2 scorr2;
title2;
title3 'Table 10.5.1 (B) Corr Between X1 & X2= .10';
run;


*Read in the correlation matrix                             *
*(C). Corrlelation between the two independent variable=0.50*
*N=100, Mean_X1 = Mean_X2=0, Mean_Y=20                      *
*Variance_X1 = 3, Variance_X2 = 4, Variance_Y = 5           *
*CORR_12=0.50, CORR_Y1=.30, CORR_Y2=.40, R-square=.173      *;

data t1051c (type=corr);
infile cards missover;
input _type_ $ _name_ $ X1 X2 Y;
cards;
corr X1   1.00
corr X2   0.50 1.00
corr Y    0.30 0.40 1.00
mean mean 0.00 0.00 20.00
std  std  1.732 2.000 2.236
N    N    100 100 100
;

proc reg;
model y= x1 x2/stb tol vif pcorr2 scorr2;
title2;
title3 'Table 10.5.1 (C) Corr Between X1 & X2= .50';
run;


*Read in the correlation matrix                             *
*(D). Corrlelation between the two independent variable=0.90*
*N=100, Mean_X1 = Mean_X2=0, Mean_Y=20                      *
*Variance_X1 = 3, Variance_X2 = 4, Variance_Y = 5           *
*CORR_12=0.90, CORR_Y1=.30, CORR_Y2=.40, R-square=.179      *;

data t1051d (type=corr);
infile cards missover;
input _type_ $ _name_ $ X1 X2 Y;
cards;
corr X1   1.00
corr X2   0.90 1.00
corr Y    0.30 0.40 1.00
mean mean 0.00 0.00 20.00
std  std  1.732 2.000 2.236
N    N    100 100 100
;

proc reg;
model y= x1 x2/stb tol vif pcorr2 scorr2;
title2;
title3 'Table 10.5.1 (D) Corr Between X1 & X2= .90';
run;


*Read in the correlation matrix                              *
*(E). Corrlelation between the two independent variable=0.949*
*N=100, Mean_X1 = Mean_X2=0, Mean_Y=20                       *
*Variance_X1 = 3, Variance_X2 = 4, Variance_Y = 5            *
*CORR_12=0.949, CORR_Y1=.30, CORR_Y2=.40, R-square=.224      *;

data t1051e (type=corr);
infile cards missover;
input _type_ $ _name_ $ X1 X2 Y;
cards;
corr X1   1.00
corr X2   0.949 1.00
corr Y    0.30 0.40 1.00
mean mean 0.00 0.00 20.00
std  std  1.732 2.000 2.236
N    N    100 100 100
;

proc reg;
model y= x1 x2/stb tol vif pcorr2 scorr2;
title2;
title3 'Table 10.5.1 (E) Corr Between X1 & X2= .949';
run;


*******************************************************************
*Table 10.5.2 Effect of Multicollinearity: Four IV Example (p.422)*
*******************************************************************;

*Read in the correlation matrix                              *
*(A). Corrlelation between the four independent variable=0   *
*N=100, Mean_X1 = Mean_X2= Mean_X3 = Mean_X4 =0, Mean_Y=20   *
*Variance_X1=3, Variance_X2 =4, Variance_X3=5, Variance_X4=4 *
*Variance_Y=5,  R-square=.495                                *
*CORR_12 = CORR_13 = CORR_23 = 0, CORR_i4 = 0                *
*CORR_Y1 =.30, CORR_Y3 = .40, CORR_Y2 = CORR_Y4 =.35,        *;

data t1052a (type=corr);
infile cards missover;
input _type_ $ _name_ $ X1 X2 X3 X4 Y;
cards;
corr X1   1.00
corr X2   0.00 1.00
corr X3   0.00 0.00 1.00
corr X4   0.00 0.00 0.00 1.00
corr Y    0.30 0.35 0.40 0.35 1.00
mean mean 0.00 0.00 0.00 0.00 20.00
std  Std  1.732 2.000 2.236 2.000 2.236
N    N    100 100 100 100 100
;

proc reg;
model y= x1 x2 x3 x4/stb tol vif pcorr2 scorr2;
title2;
title3 'Table 10.5.2 (A) Corr Among X1, X2 & X3= .000';
run;


*Read in the correlation matrix                              *
*(B). Corrlelation between the four independent variable=0   *
*N=100, Mean_X1 = Mean_X2= Mean_X3 = Mean_X4 =0, Mean_Y=20   *
*Variance_X1=3, Variance_X=5, Variance_X2 = Variance_X4 = 4  *
*Variance_Y = 5, R-square=.325                               *
*CORR_12 = CORR_13 = CORR_23 = 0.933, CORR_i4 = 0            *
*CORR_Y1 =.30, CORR_Y3 = .40, CORR_Y2 = CORR_Y4 =.35,        *;

data t1052b (type=corr);
infile cards missover;
input _type_ $ _name_ $ X1 X2 X3 X4 Y;
cards;
corr X1   1.00
corr X2   0.933 1.00
corr X3   0.933 0.933 1.00
corr X4   0.00 0.00 0.00 1.00
corr Y    0.30 0.35 0.40 0.35 1.00
mean mean 0.00 0.00 0.00 0.00 20.00
std  Std  1.732 2.000 2.236 2.000 2.236
N    N    100 100 100 100 100
;

proc reg;
model y= x1 x2 x3 x4/stb tol vif pcorr2 scorr2;
title2;
title3 'Table 10.5.2 (B) Corr Among X1, X2 & X3= .933';
run;
