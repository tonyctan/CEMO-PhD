cipi <-
function(fit,hmat,alpha=.05){

    hmat <- as.matrix(hmat)
    k <- length(hmat[,1])

    n <- length(fit$resid)
    p <- length(fit$coef)
    df <- n - p
    sfit <- summary(fit)
    sig <- sfit$sigma
    vc <- sfit$cov.unscaled
    beta <- fit$coef
    tc <- abs(qt(alpha/2,df))

    matci <- matrix(rep(0,4*k),ncol=4)
    matpi <- matrix(rep(0,4*k),ncol=4)

    for(i in 1:k){
       h <- hmat[i,]
       theta <- t(h)%*%beta
       seci <- sig*sqrt(t(h)%*%vc%*%h)
       lci <- theta - tc*seci
       uci <- theta + tc*seci
       matci[i,] <- c(theta,seci,lci,uci)
       sepi <- sig*sqrt(1+t(h)%*%vc%*%h)
       lpi <- theta - tc*sepi
       upi <- theta + tc*sepi
       matpi[i,] <- c(theta,sepi,lpi,upi)
}
       matcipi <- cbind(matci,matpi)
       colnames(matcipi) <- c("Pred","SECI","LCI","UCI","Pred","SEPI","LPI","UPI")
       return(matcipi)
}
