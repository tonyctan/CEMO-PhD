pcn <-
function(x,eps,sigc){
#   cdf of contaminated normal
   pcn <- (1-eps)*pnorm(x) + eps*pnorm(x/sigc)
   return(pcn)
}
