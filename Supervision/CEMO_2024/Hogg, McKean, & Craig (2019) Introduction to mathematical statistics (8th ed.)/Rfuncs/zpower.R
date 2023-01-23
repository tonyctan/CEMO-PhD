zpower <- function(n,mu0,sigma,alpha=.05){
#
#   Plots the power curve for one-sample z-test for a two-sided
#   test of mu = mu0.
#
      zc <- abs(qnorm(alpha/2))
      l <- -zc*(sigma/sqrt(n)) + mu0
      k <- zc*(sigma/sqrt(n)) + mu0
      delta <- ((sigma/sqrt(n))*(6+zc))/16
      mul <- mu0 - (3+zc)*(sigma/sqrt(n))
      cuts <- c(mul)
      for(i in 1:20){cuts <- c(cuts,mul+i*delta)}
      gam <- pnorm(l,cuts,sigma/sqrt(n)) + 1 - pnorm(k,cuts,sigma/sqrt(n))

      plot(gam~cuts,pch=" ",xlab=expression(mu),ylab=expression(gamma(mu)),cex=2)
      lines(gam~cuts,lty=1,cex=2)
}
