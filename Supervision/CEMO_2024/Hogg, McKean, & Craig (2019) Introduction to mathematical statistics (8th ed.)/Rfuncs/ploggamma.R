ploggamma <-
function(x,alpha,beta){
#   This program assumes that all components of x are >= 1
      ploggamma <- pgamma(log(x),alpha,1/beta)
      return(ploggamma)
}
