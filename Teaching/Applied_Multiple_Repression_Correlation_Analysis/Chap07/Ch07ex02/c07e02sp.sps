*********************************************************************
* SPSS CODE FILE:C07E02SP.SPS
* Reads data file C07E02DT.TXT
* ICON PAGE 294
* Chapter 7, Example 2 
* File contains raw X, Z, Y for 250 cases
* This is for the curvilinear by linear interaction in chapter 7
*     Figure 7.9.1 and Table 7.9.1
* Simulation by Steven C. Pitts, University of Maryland-Baltimore Co.
* SPSS syntax by Leona S. Aiken
*********************************************************************


data list file = 'c:\ccwa\chap07\ch07ex02\c07e02dt.txt' records=1
    /case (f4.0) x(f12.6) z(f12.6) y(f12.6).
execute.

descriptives variables=x z
   /statistics=mean stddev.

*******************************************************
* Use the means of X and Z from descriptives
* meanx = 4.47004
* meanz = 4.80992
* to create centered predictors xc and zc
*******************************************************

compute meanx = 4.47004.
compute meanz = 4.80992.
compute xc = x - meanx.
compute zc = z - meanz.

**********************************************************************
* compute all the terms for use in the overall centered regression
* equation to assess the curvilinear X by linear Z interaction:
* crossproduct of centered xc and zc (xzc)
* square of centered xc (x2c)
* crossproduct of squared centered xc  with centered zc (x2zc)
**********************************************************************

compute x2c = xc**2.
compute xzc = xc*zc.
compute x2zc = xc*xc*zc.

*******************************************************
* generate the regression equation assessing the
* curvilinear by linear interaction in Table 7.9.1 (page 294)
* equation contains all lower order terms (xc, zc, x2c, xzc)
* contained in the highest order term (x2zc)
* the zpp option provides the zero-order correlation, as well as the 
* partial correlation and part (semi-partial) correlation
* for each term in the overall regression equation 
* with all other terms partialled;
* note that SAS reports squared partial and 
* semi-partial correlations
********************************************************

regression variables=xc x2c zc xzc x2zc y
     /statistics= defaults bcov zpp ci 
     /dependent = y
     /method=enter xc x2c zc xzc x2zc
     /descriptives=mean stddev cor.


