dcn <-
function(x,eps,sigc){
#   pdf of contaminated normal
   dcn <- (1-eps)*dnorm(x) + eps*dnorm(x/sigc)/sigc
   return(dcn)
}
