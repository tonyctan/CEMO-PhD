qqplotc4s2 <-
function(vec){
n<-length(vec)
ps<-(1:n)/(n+1)
normalqs<-qnorm(ps)
y<-sort(vec)
#postscript("try.ps",horizontal=T)
par(mfrow=c(2,2))
boxplot(y,ylab="x")
title(main="Panel A")
plot(normalqs,y,xlab="Normal quantiles",ylab="Sample quantiles")
title(main="Panel B",xlab="Normal quantiles",ylab="Sample quantiles")
plot(qlaplace(ps),y,xlab="Laplace quantiles",ylab="Sample quantiles")
title(main="Panel C")
plot(qexp(ps),y,xlab="Exponential quantiles",ylab="Sample quantiles")
title(main="Panel D")
}
