rscn <-
function(n,eps,sd,mu){
#
#  returns a random sample of size n drawn from
#  a skewed contaminated normal distribution with percent
#  contamination eps, variance ratio sd, and mean mu.
#
  x1 = rnorm(n)
  x2 = rnorm(n,mu,sd)
  b1 = rbinom(n,1,eps)
  rscn = x1*(1-b1) + b1*x2
  rscn
}
