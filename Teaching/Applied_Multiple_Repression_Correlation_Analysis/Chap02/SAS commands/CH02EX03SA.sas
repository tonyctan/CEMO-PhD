/* Chapter 2: BIVARIATE CORRELATION AND REGRESSION */
/* Table 2.3.1  Correlation Between a Dichotomous and a Scales Variable */

title 'Chapter 2: BIVARIATE CORRELATION AND REGRESSION -- Table 2.3.1';
data c0203;
input stimulus$ task @@;
keep stimulus task stima zstima stimb zstimb ztask;
if stimulus='stim' then stima=1;
if stimulus='none' then stima=0;
if stimulus='stim' then stimb=20;
if stimulus='none' then stimb=50;
zstima=stima;
zstimb=stimb;
ztask=task;
cards;
none 67 none 72 none 70 none 69
stim 66 stim 64 stim 68
;
proc standard data=c0203 mean=0 std=1 out=cc0203;
var zstima zstimb ztask;
run;
data ccc0203;
set cc0203;
zyza=ztask*zstima;
zyzb=ztask*zstimb;
output;
proc corr data=ccc0203;
var task stima stimb;
run;
proc means data=ccc0203;
by stimulus;
run;
proc print data=ccc0203;
run;
