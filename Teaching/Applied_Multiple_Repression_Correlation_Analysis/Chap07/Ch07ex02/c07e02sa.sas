*********************************************************************
* SAS CODE FILE:C07E02SA.SAS
* Reads data file C07E02DT.TXT
* ICON PAGE 294
* Chapter 7, Example 2
* File contains raw X, Z, Y for 250 cases
* This is for the curvilinear by linear interaction in chapter 7
*     Figure 7.9.1 and Table 7.9.1
* Simulation and SAS syntax by Steven C. Pitts, University of Maryland-Baltimore Co.
*********************************************************************;

filename indat 'c:\ccwa\chap07\ch07ex02\c07e02dt.txt';

options nocenter;

data one; infile indat;
   input case x z y;

*************************************************
* create variables xc and zc which will represent 
* centered x and z, respectively 
*************************************************;
                  
xc=x;
zc=z;

*****************************************************
* using proc standard center xc and zc by defining  
* mean=0. create new data set called "center" 
*****************************************************;
      
proc standard mean=0 out=center;
   var xc zc;

data two; set center;

*******************************************************
* create all cross product terms for the completely 
* centered example: 
* crossproduct of centered xc and zc (xzc)
* square of centered xc (x2c)
* crossproduct of squared centered xc with centered zc (x2zc)
*******************************************************;                     

xzc=xc*zc;
x2c=xc**2;
x2zc=x2c*zc;

*******************************************************
* generate the regression equation assessing the
* curvilinear by linear interaction in Table 7.9.1 (page 294)
* equation contains all lower order terms (xc, zc, x2c, xzc)
* contained in the highest order term (x2zc)
* the pcorr2 option provides the squared
* partial correlation coefficient for each term in
* the overall regression equation with all other terms partialled,
* and the scorr2 option provides squared semi-partial (part) correlations.
* note that SPSS does not square the partial and semi-partial correlations.
*******************************************************;

proc reg simple corr;
   model y=xc zc xzc x2c x2zc /covb corrb pcorr2 scorr2;
   quit;


