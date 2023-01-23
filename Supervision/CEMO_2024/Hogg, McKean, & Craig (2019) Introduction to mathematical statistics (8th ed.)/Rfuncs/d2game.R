d2game <-
function(){
    rng1 <- 1:20
    Win <- 0
    x <- sample(rng1,1,pr=rep(1/20,20))
    rng2 <- x:25
    m <- length(rng2)
    y <- sample(rng2,1,pr=rep(1/m,m))
    if(y > 21){Win<-1}
    return(Win)
}
