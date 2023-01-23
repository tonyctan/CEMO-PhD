boottesttwo <-
function(x,y,b){
#
#  x vector containing first sample.
#  y vector containing first sample.
#  b number of bootstrap replications.
#
#  origtest: value of test statistic on original samples
#  pvalue: bootstrap p-value
#  teststatall: vector of bootstrap test statistics
#
n1<-length(x)
n2<-length(y)
v<-teststat(x,y)
z<-c(x,y)
counter<-0
teststatall<-rep(0,b)
for(i in 1:b){xstar<-sample(z,n1,replace=T)
              ystar<-sample(z,n2,replace=T)
              vstar<-teststat(xstar,ystar)
              if(vstar >= v){counter<-counter+1}
              teststatall[i]<-vstar}
pvalue<-counter/b
list(origtest=v,pvalue=pvalue,teststatall=teststatall)
#list(origtest=v,pvaule=pvalue)
}
