getcis <-
function(mat,cc=.90){
    numb <- length(mat[,1]); ci <- c()
    for(j in 1:numb){ci<-rbind(ci,t.test(mat[j,],conf.level=cc)$conf.int)}
    return(ci)}
