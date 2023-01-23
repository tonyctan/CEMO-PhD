tpowerg <-
function(mu0,sig,n,alpha=0.05,byv=.1){
#
#    Graphs power function for t-test of mu = mu0 vs mu not= mu0
#
      fse <- 4*sig/sqrt(n); maxmu <- mu0 + fse; tc <- qt(1-(alpha/2),n-1)
      minmu <- mu0 -fse
      mu1 <- seq(minmu,maxmu,.1)
      delta <- (mu1-mu0)/(sig/sqrt(n))
      gammas <- 1 - pt(tc,n-1,ncp=delta) + pt(-tc,n-1,ncp=delta)
      plot(gammas~mu1,pch=" ",xlab=expression(mu[1]),ylab=expression(gamma))
      lines(gammas~mu1)
}
