ellipmake <-
function(p=.95,b=matrix(c(1,.75,.75,1),nrow=2),mu=c(5,2)){
#   Part of this code was obtained from an annonymous author at the site
#   http://stats.stackexchange.com/questions/9898/
    csq <- qchisq(p,2); B=csq*b; A=solve(B); eig <- eigen(A)
    gam <- eig$vectors; lam2 <- sqrt(diag(eig$values))
    theta <- seq(0,2*pi,length.out=200); y1 <- cos(theta)
    y2 <- sin(theta); ym <- cbind(y1,y2); xm <- ym%*%solve(lam2)%*%t(gam)
    xm[,1]=xm[,1]+mu[1];xm[,2]=xm[,2]+mu[2]
    plot(xm[,2]~xm[,1],pch=" "); lines(xm[,2]~xm[,1])
    title(main=paste("Chi-sq Probability ",p))
}
