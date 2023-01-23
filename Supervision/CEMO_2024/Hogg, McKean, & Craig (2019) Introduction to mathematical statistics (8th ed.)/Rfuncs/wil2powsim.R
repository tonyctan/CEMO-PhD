wil2powsim <-
function(n1,n2,nsims,eps,vc,Delta=0,alpha=.05){
      indwil <-0; indt <- 0
      for(i in 1:nsims){
          x <- rcn(n1,eps,vc); y <- rcn(n2,eps,vc) + Delta
          if(wilcox.test(y,x)$p.value <= alpha){indwil <- indwil + 1}
          if(t.test(y,x,var.equal=T)$p.value <= alpha){indt <- indt + 1}
       }
       powwil <- sum(indwil)/nsims; powt <- sum(indt)/nsims
       return(c(powwil,powt))
}
