dloggamma <-
function(x,alpha,beta){
#  This functions assumes that x>1
        p1 <- 1/(gamma(alpha)*beta^alpha)
        p2 <- x^(-(beta+1)/beta)*(log(x))^{alpha-1}
        dloggamma <- p1*p2
        return(dloggamma)
}
