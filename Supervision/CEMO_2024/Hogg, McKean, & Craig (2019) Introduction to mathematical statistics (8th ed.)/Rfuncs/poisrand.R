poisrand <-
function(n,lambda){
    poisrand = rep(0,n)
    for(i in 1:n){
        xt = 0
        t = 0
        while(t < 1){
           x = xt
           y = -(1/lambda)*log(1-runif(1))
           t = t + y
           xt = xt + 1
        }
        poisrand[i] = x
     }
     poisrand
}
