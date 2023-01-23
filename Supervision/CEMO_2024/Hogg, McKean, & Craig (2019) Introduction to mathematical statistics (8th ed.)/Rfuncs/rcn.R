rcn <-
function(n,eps,sigmac){
#
#  returns a random sample of size n drawn from
#  a contaminated normal distribution with percent
#  contamination eps and variance ratio sigmac
#
ind<-rbinom(n,1,eps)
x<-rnorm(n)
rcn<-x*(1-ind)+sigmac*x*ind
rcn
}
