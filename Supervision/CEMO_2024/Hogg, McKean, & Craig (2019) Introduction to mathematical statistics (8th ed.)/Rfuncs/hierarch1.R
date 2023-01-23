hierarch1 <-
function(nsims,x,tau,kstart){
#    This R program performs the
#    Gibbs sampler given in Example 11.4.2
bold<-1
clambda<-rep(0,(nsims+kstart))
cb<-rep(0,(nsims+kstart))
for(i in 1:(nsims+kstart))
   {clambda[i]<-rgamma(1,shape=(x+1),scale=(bold/(bold+1)))
    newy<-rgamma(1,shape=2,scale=(tau/(clambda[i]*tau+1)))
    cb[i]<-1/newy
    bold<-1/newy}
gibbslambda<-clambda[(kstart+1):(nsims+kstart)]
gibbsb<-cb[(kstart+1):(nsims+kstart)]
list(clambda=clambda,cb=cb,gibbslambda=gibbslambda,gibbsb=gibbsb)
}
