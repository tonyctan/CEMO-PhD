condsim1 <-
function(nsims){
collect<-rep(0,nsims)
for(i in 1:nsims)
   {y<--.5*log(1-runif(1))
    collect[i]<--log(1-runif(1))+y
   }
collect
}
