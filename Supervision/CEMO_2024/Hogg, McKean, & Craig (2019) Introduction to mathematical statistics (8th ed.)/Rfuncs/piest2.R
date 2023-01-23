piest2 <-
function(n){
#
#  Obtains the estimate of pi and its standard
#  error for the simulation discussed in Example 5.8.3
#
#  n is the number of simulations
#
samp<-4*sqrt(1-runif(n)^2)
est<-mean(samp)
se<-sqrt(var(samp)/n)
list(est=est,se=se)
}
