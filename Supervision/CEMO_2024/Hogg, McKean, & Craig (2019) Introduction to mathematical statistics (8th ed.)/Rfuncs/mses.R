mses <-
function(x,theta0){
      mses <- sum((x-theta0)^2)/length(x)
      return(mses)
}
