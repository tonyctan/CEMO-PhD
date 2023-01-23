piest <-
function(n){
#
#  Obtains the estimate of pi and its standard
#  error for the simulation discussed in Example 5.8.1
#
#  n is the number of simulations
#
u1<-runif(n)
u2<-runif(n)
cnt<-rep(0,n)
chk<-u1^2 + u2^2 - 1
cnt[chk < 0]<-1
est<-mean(cnt)
se<-4*sqrt(est*(1-est)/n)
est<-4*est
list(estimate=est,standard=se)
}
