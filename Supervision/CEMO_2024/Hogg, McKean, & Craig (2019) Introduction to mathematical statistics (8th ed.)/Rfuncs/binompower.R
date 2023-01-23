binompower <-
function(){
#  The values below sketch power functions for tests
#  described in Eaxmple 4.5.2.   But it is easy to
#  change these for other binomial situations
n<-20
k1<-11       # Reject if S <= k1
k2<-12       # Reject if S <= k2
p0<-.7       # Null Hypothesis H_0: p = p0
x<-seq(.4,1,.01)
pow1<-pbinom(k1,n,x)
pow2<-pbinom(k2,n,x)
#par(mfrow=c(2,2))
#postscript(file="figbino.ps")
plot(x,pow2,xlab="p",ylab=expression(gamma(p)),ylim=c(0,1),xlim=c(.35,1),type="l",lty=2)
lines(x,pow1,lty=1)
title("Power Functions for Binomial Tests")
text(.72,.4,"Level 0.23")
text(.54,.4,"Level 0.11")
}
