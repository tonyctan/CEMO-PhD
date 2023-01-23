ttable <-
function(){
    ps = c(.9,.925,.950,.975,.99,.995,.999); df = 1:30; tab=c()
    for(r in df){tab=rbind(tab,qt(ps,r))}; df=c(df,Inf);nq=qnorm(ps)
    tab=rbind(tab,nq);tab=cbind(df,tab);return(tab)}
