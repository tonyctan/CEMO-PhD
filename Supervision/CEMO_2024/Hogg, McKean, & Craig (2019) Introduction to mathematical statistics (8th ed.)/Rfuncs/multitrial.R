multitrial <-
function(p){
   pr <- c(0,psum(p))
   r <- runif(1); ic <- 0; j <- 1
   while(ic==0){if((r > pr[j]) && (r <= pr[j+1]))
   {multitrial <-j; ic<-1}; j<- j+1}
   return(multitrial)}
