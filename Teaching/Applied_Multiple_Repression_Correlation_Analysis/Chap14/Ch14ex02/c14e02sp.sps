****************************************************
* SPSS CODE FILE:C14E02SP.SPS
* Reads data file C14E02DT.TXT
* ICON PAGE 542 
* This example is the aggregated analysis predicting
* mean weight loss per group from mean motivation
* in the group, Table 14.2.1B. (page 542)
* There are 40 groups. 
* Variable TREAT(1=treated; 0=control);
*          SIZE (number of cases in group)
*          motmean (mean motivational level in group)
*          pdsmean (mean pounds lost in group)
* SPSS syntax by Leona S. Aiken
****************************************************

data list file='c:\ccwa\chap14\ch14ex02\c14e02dt.txt' free records=1
      / group treat   size   motmean   pdsmean.
execute.

descriptives variables =pdsmean motmean
      /statistics = mean stddev.


*********************************************************
*values from descriptives, for use in centering variables
*Mean   motivate       3.469      Std dev        .448
*Mean   pounds        15.159      Std dev       2.660
*********************************************************

******************************************************
* create centered motivation variable, centering around
* grand mean
******************************************************

compute motmeanc = motmean - 3.469.

descriptives variables = motmeanc
       /statistics = mean stddev.

REGRESSION
  /MISSING LISTWISE
  /descriptives=mean stddev cor
  /STATISTICS COEFF OUTS R ANOVA
  /DEPENDENT pdsmean
  /METHOD=ENTER motmeanc  .



    

