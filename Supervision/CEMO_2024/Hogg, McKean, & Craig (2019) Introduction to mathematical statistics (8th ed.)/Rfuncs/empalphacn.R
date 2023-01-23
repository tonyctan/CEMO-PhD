empalphacn <-
function(nsims){
#
#  Obtains the empirical level of the test discussed
#  Example 5.8.5.
#
#  nsims is the number of simulations
#
sigmac<-25
eps<-.25
alpha<-.05
n<-20
tc<-qt(1-alpha,n-1)
ic<-0
for(i in 1:nsims){
    samp<-rcn(n,eps,sigmac)
    ttest<-(sqrt(n)*mean(samp))/var(samp)^.5
    if(ttest > tc){ic<-ic+1}
    }
empalp<-ic/nsims
err<-1.96*sqrt((empalp*(1-empalp))/nsims)
list(empiricalalpha=empalp,error=err)
}
