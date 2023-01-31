****************************************
* SPSS CODE FILE:C07E01SP.SPS
* Reads data file C0701DT.TXT
* ICON PAGE 275
* Chapter 7, Example 1
* This is the example of 245 cases, endurance, age, exercise
* in Section 7.4.5, Figure 7.4.1, Table 7.4.1, Table 7.5.1
* Simulation by Steven C. Pitts, University of Maryland-Baltimore Co.
* SPSS syntax by Leona S. Aiken
*******************************************

data list file = 'c:\ccwa\chap07\ch07ex01\c07e01dt.txt'
      /1 case (f4.0) xage (f6.0) zexer (f6.0) yendu (f6.0).
execute.

************************************************
*run descriptives for centering xage and zexer.
************************************************

descriptives variables = xage zexer yendu
   /statistics = mean stddev.

************************************************************
*  means and standard deviations from output of descriptives
*  xage      Mean         49.184      Std dev      10.107
*  zexer     Mean         10.673      Std dev       4.775
*  yendu     Mean         26.531      Std dev      10.819
************************************************************

************************************************************
* compute the centered variables and crossproducts
* xagec is the centered age variable
* zexerc is the centered exercise variable
* xz is the crossproduct of the raw (uncentered) xage and zexer.
* xcent*zcent is the crossproduct of the centered xagec and zexerc.
************************************************************

compute xagec = xage - 49.184.
compute zexerc = zexer - 10.673.
compute xz = xage*zexer.
compute xzcent = xagec*zexerc.

******************************************
* centered regression analysis reported in
* Table 7.4.1, Sections A, B, C (page 276)
* Table 7.5.1, Section A (page 283)
******************************************

regression variables=xagec zexerc xzcent yendu
     /statistics= defaults bcov ci
    /dependent = yendu
    /method=enter xagec zexerc
    /method=enter xzcent
    /descriptives=mean stddev cor.

********************************************
* uncentered regression analysis reported in
* Table 7.4.1, Section F (page 276)
********************************************

regression variables=xage zexer xz yendu
     /statistics= defaults bcov ci
    /dependent = yendu
    /method=enter xage zexer
    /method=enter xz
    /descriptives=mean stddev cor.


********************************************
* do the "standardized solution"
* run descriptives to form the standardized (z) scores corresponding
* to the centered predictors and save them;
* "zxcent" is the standardized (z) score corresponding to xagec
* "zexerc" is the standardized (z) score corresponding to zexerc
* "zyendu" is the standardized (z) score corresponding to yendu
* then compute the crossproduct of the z scores for the 
*       standardized interaction term
*******************************************

descriptives variables=xagec (zxcent) zexerc (zzcent) yendu (zyendu)
           /save.
compute zinter=(zxcent*zzcent).

********************************************
* run the appropriate regression analysis for a standardized solution
* with an interaction; use the "raw" coefficients from the following
* analysis as the standardized solution, given in
* Table 7.5.1, Section B (page 283) 
*******************************************

regression variables=zxcent zzcent zinter zyendu
     /statistics= defaults bcov ci
    /dependent = zyendu
    /method=enter zxcent zzcent
    /method=enter zinter
    /descriptives=mean stddev cor.


