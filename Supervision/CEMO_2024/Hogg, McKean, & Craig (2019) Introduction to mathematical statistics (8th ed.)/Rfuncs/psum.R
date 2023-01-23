psum <-
function(v){
   p<-0; psum <- c()
   for(j in 1:length(v)){p<-p+v[j]; psum <- c(psum,p)}
   return(psum)}
