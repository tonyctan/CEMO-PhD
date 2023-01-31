*****************************************************
* SAS CODE FILE:C07E01SA.SAS
* Reads data file C0701DT.TXT
* ICON PAGE 275
* Chapter 7, Example 1
* This is the example of 245 cases, endurance, age, exercise
* in Section 7.4.5, Figure 7.4.1, Table 7.4.1, Table 7.5.1
* Simulation by Steven C. Pitts, University of Maryland-Baltimore Co;
*   SAS syntax by Jonathan E. Butner, University of Utah
*   to mirror SPSS syntax C07E01SP.SPS by Leona S. Aiken
******************************************************;

data c7e1;
  infile 'c:\ccwa\chap07\ch07ex01\c07e01dt.txt';
  input case 1-4 xage 5-10 zexer 11-16 yendu 17-22;
run;

************************************************
*run descriptives for centering xage and zexer.
************************************************;

proc means;
  var xage zexer yendu;
run;

***********************************************************************************
*  means and standard deviations from output of proc means
*
*                              The MEANS Procedure
*
*   Variable      N            Mean         Std Dev         Minimum         Maximum
*   
*   xage        245      49.1836735      10.1069556      20.0000000      82.0000000
*   zexer       245      10.6734694       4.7752253               0      26.0000000
*   yendu       245      26.5306122      10.8191202               0      55.0000000
*
************************************************************************************;

**************************************************
* compute the centered variables and crossproducts
* xagec is the centered age variable
* zexerc is the centered exercise variable
* xz is the crossproduct of the raw (uncentered) xage and zexer.
* xcent*zcent is the crossproduct of the centered xagec and zexerc.
**************************************************;

data c7e1c;
  set c7e1;
xagec = xage - 49.184;
zexerc = zexer - 10.673;
xz = xage*zexer;
xzcent = xagec*zexerc;
run;

******************************************
* centered regression analysis reported in
* Table 7.4.1, Sections A, B, C (page 276)
* Table 7.5.1, Section A (page 283)
******************************************;

proc reg simple corr data = c7e1c;
  model yendu = xagec zexerc/covb corrb clb stb;
  model yendu = xagec zexerc xzcent/covb corrb clb stb;
  test xzcent;
run;

********************************************
* uncentered regression analysis reported in
* Table 7.4.1, Section F (page 276)
********************************************;

proc reg simple corr data = c7e1c;
  model yendu = xage zexer/covb corrb clb stb;
  model yendu = xage zexer xz/covb corrb clb stb;
  test xz;
run;

********************************************
* do the "standardized solution"
* run descriptives to form the standardized (z) scores corresponding
* to the centered predictors and save them;
* "zxcent" is the standardized (z) score corresponding to xagec
* "zexerc" is the standardized (z) score corresponding to zexerc
* "zyendu" is the standardized (z) score corresponding to yendu
* then compute the crossproduct of the z scores for the 
*       standardized interaction term
*******************************************;
data c7e1c2;
  set c7e1c;
zxcent = xagec;
zzcent = zexerc;
zyendu = yendu;
run;
proc means data = c7e1c2;
  var xagec zexerc yendu;
run;
proc standard out=c7ec1z mean=0 std=1;
var zxcent zzcent zyendu;
run;
data c7ec1z2;
  set c7ec1z;
zinter=(zxcent*zzcent);
run;

********************************************
* run the appropriate regression analysis for a standardized solution
* with an interaction, use the "raw" coefficients from the following
* analysis as the standardized solution.
* Table 7.5.1, Section B (page 276) 
*******************************************;

proc reg simple corr data = c7ec1z2;
  model zyendu = zxcent zzcent/stb covb corrb clb;
  model zyendu = zxcent zzcent zinter/stb covb corrb clb;
  test zinter;
run;
quit;
