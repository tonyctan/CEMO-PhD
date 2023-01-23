onesampsgn <-
function(x,test=F,alt=0,theta0=0,alpha=.05,maktable=T,plotb=F){
#
#   Test of H_0: theta = theta0
#
    n = length(x)
    ind = rep(0,n)
    ind[x==theta0] = 1
    n = n - sum(ind)
    if(test){
        ts = sum(sign(x-theta0))
        zp = (ts-1)/sqrt(n)
        zn = (ts+1)/sqrt(n)
        if(alt==1){
             pval = 1 - pnorm(zp)
             zs = zp
        }
        if(alt==-1){
             pval = pnorm(zn)
             zs = zn
        }
        if(alt==0){
             if(ts >= 0){
                 pval = 2*(1 - pnorm(zp))
                 zs = zp
             } else {
                 pval = 2*pnorm(zn)
                 zs = zn
             }
        }
    }
# 
#    Estimation
# 
#
    n = length(x)
    est = median(x)
    xs = sort(x)
    crit = -qnorm(alpha/2)
    cut = round((n/2) - crit*sqrt(n/4) - .5)
    if(cut < 0){cut=0}
    lci = xs[cut+1]
    uci = xs[n-cut]
    acconf = 1 - 2*pbinom(cut,n,1/2)
    tau = (sqrt(n)*(uci-lci))/(2*crit)

    if(maktable){
        if(test){
            cat("\n")
            cat("Results for the Sign procedure","\n")
            if(alt == 0){cat("Test of theta =",theta0," versus theta not equal to ",theta0,"\n")}
            if(alt == 1){cat("Test of theta =",theta0," versus theta greater than ",theta0,"\n")}
            if(alt == -1){cat("Test of theta =",theta0," versus theta less than ",theta0,"\n")}
            cat("Test stat. S is",ts," Standardized (z) Test-Stat.",zs,"p-value",pval,"\n")
            cat("\n")
        }
        cat("Estimate ",est," SE is ",tau/sqrt(n),"\n")
        pct = 100*(1-alpha)
        cat(pct,"%","Confidence Interval is ","(",lci,",",uci,")","\n")
        cat("    Actual Confidence  is ",acconf,"\n")
        cat("Estimate of the scale parameter tau",tau,"\n")
        cat("\n","This CI is the asymptotic form, see Hettmansperger and McKean (2011)","\n")
    }
    if(plotb){
        boxplot(x,notch=T)
        title(main="95% Notched Boxplot of Data")
    }


   if(test==T){
        list(ts=ts,zs=zs,pval=pval,est=est,lci=lci,uci=uci,acconf=acconf,tau=tau)
   } else {
        list(est=est,lci=lci,uci=uci,acconf=acconf,tau=tau)
   }
}
