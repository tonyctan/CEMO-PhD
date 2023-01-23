boottestonemed <-
function(x,theta0,b){
#
#  x = sample
#  theta0 is the null value of the mean
#  b is the number of bootstrap resamples
#
#  origtest contains the value of the test statistics 
#           for the original sample
#  pvalue is the bootstrap p-value
#  teststatall contains the b bootstrap tests
#
n<-length(x)
v<-median(x)
z<-x-median(x)+theta0
counter<-0
teststatall<-rep(0,b)
for(i in 1:b){xstar<-sample(z,n,replace=T)
              vstar<-median(xstar)
              if(vstar >= v){counter<-counter+1}
              teststatall[i]<-vstar}
pvalue<-counter/b
list(origtest=v,pvalue=pvalue,teststatall=teststatall)
#list(origtest=v,pvaule=pvalue)
}
