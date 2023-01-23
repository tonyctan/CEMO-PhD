bootstrapcis64 <-
function(x,c,nb=3000,alp2=0.025){
#    Bootstrap CI for P(X <= c) based on mle for a normal
#    distribution.   Sample is in x.

     n <- length(x)
     xb = mean(x); sb = (((n-1)/n)*var(x))^.5; est <- pnorm((c-xb)/sb)
     
     collest <- c()
     for(i in 1:nb){
          xr=sample(x,50,replace=T)
          xb = mean(xr); sb = (((n-1)/n)*var(xr))^.5; estr <- pnorm((c-xb)/sb)
          collest <- c(collest,estr)
     }

     colls <- sort(collest)
     cut <- round(nb*alp2)
     lb <- colls[cut]; ub <- colls[nb - (cut-1)]
     list(est,lb,ub)
}
