tpower2g2 <-
function(n,m,Delta,sig,alpha){
#
#    Computes power function for two-sample t-test
#    for the alternative mu1 > mu2.  Delta = mu1 -mu2
#    is the argument for the power function.
#
      delta <- sqrt(n*m/(m+n))*(Delta/sig); df = n+m-2
      tc <- qt(1-alpha,df)
      gammas <- 1 - pt(tc,df,ncp=delta)
      return(gammas)
}
