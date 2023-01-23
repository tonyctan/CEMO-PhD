tpowerg2 <-
function(mu0,mu1,sig,n,alpha=0.05,byv=.1){
#
#    Graphs power function for t-test of mu = mu0 vs mu not= mu0
#
      delta <- (mu1-mu0)/(sig/sqrt(n))
      tc <- qt(1-(alpha/2),n-1)
      delta <- (mu1-mu0)/(sig/sqrt(n))
      gammas <- 1 - pt(tc,n-1,ncp=delta) + pt(-tc,n-1,ncp=delta)
      return(gammas)
}
