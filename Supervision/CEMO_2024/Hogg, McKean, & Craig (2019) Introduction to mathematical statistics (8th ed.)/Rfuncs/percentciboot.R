percentciboot <-
function(x,b,alpha){
#
theta<-mean(x)
thetastar<-rep(0,b)
n<-length(x)
for(i in 1:b){xstar<-sample(x,n,replace=T)
             thetastar[i]<-mean(xstar)
             }
thetastar<-sort(thetastar)
pick<-round((alpha/2)*(b+1))
lower<-thetastar[pick]
upper<-thetastar[b-pick+1]
list(theta=theta,lower=lower,upper=upper,thetasta=thetastar)
#list(theta=theta,lower=lower,upper=upper)
}
