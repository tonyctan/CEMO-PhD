****************************************************
* SAS CODE FILE:C14E02SA.SAS
* Reads data file C14E02DT.TXT
* ICON PAGE 542 
* This example is the aggregated analysis predicting
* mean weight loss per group from mean motivation
* in the group, Table 14.2.1B.
* There are 40 groups. 
* Variable TREAT(1=treated, 0=control),
*          SIZE (number of cases in group)
*          motmean (mean motivational level in group)
*          pdsmean (mean pounds lost in group)
*   SAS syntax by Jonathan E. Butner, University of Utah
*     to mirror C14E02SP.SPS by Leona S. Aiken
****************************************************;

options nocenter;
data c14e2;
  infile 'c:\ccwa\Chap14\Ch14ex02\C14e02dt.txt';
  input group treat size motmean pdsmean;
run;

proc means;
  var pdsmean motmean;
run;

****************************************************
* SAS CODE FILE:C14E02SA.SAS
* Reads data file C14E02DT.TXT
* ICON PAGE 542 
* This example is the aggregated analysis predicting
* mean weight loss per group from mean motivation
* in the group, Table 14.2.1B.
* There are 40 groups. 
* Variable TREAT(1=treated, 0=control),
*          SIZE (number of cases in group)
*          motmean (mean motivational level in group)
*          pdsmean (mean pounds lost in group)
*   SAS syntax by Jonathan E. Butner, University of Utah
*     to mirror C14E02SP.SPS by Leona S. Aiken
****************************************************;

options nocenter;
data c14e2;
  infile 'c:\ccwa\Chap14\Ch14ex02\C14e02dt.txt';
  input group treat size motmean pdsmean;
run;

proc means;
  var pdsmean motmean;
run;

*********************************************************
*values from proc means used in centering variables
*The MEANS Procedure
*
*Variable     N            Mean         Std Dev         Minimum         Maximum
*
*pdsmean     40      15.1587950       2.6604425       9.7500000      24.4286000
*motmean     40       3.4688500       0.4483691       2.5000000       4.6000000

*********************************************************;

******************************************************
* create centered motivation variable, centering around
* grand mean
******************************************************;

data c14e2c;
  set c14e2;

motmeanc = motmean - 3.469;

proc means data = c14e2c;
  var motmeanc;
run;

proc reg simple corr data = c14e2c;
  model pdsmean = motmeanc/stb;
run;
quit;

*********************************************************
*values from descriptives, for use in centering variables
*Mean   motivate       3.469      Std dev        .448
*Mean   pounds        15.159      Std dev       2.660
*********************************************************;

******************************************************
* create centered motivation variable, centering around
* grand mean
******************************************************;

data c14e2c;
  set c14e2;

motmeanc = motmean - 3.469;

proc means data = c14e2c;
  var motmeanc;
run;

proc reg simple corr data = c14e2c;
  model pdsmean = motmeanc/stb;
run;
quit;
