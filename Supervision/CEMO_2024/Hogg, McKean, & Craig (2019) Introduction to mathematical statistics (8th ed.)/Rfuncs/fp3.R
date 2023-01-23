fp3 <-
function(){
    numdf = 1:9
    denomdf = c(1:30,40,60,120)
    ic = length(denomdf)
    xmat = matrix(rep(0,9*ic),ncol=9)
    for(i in 1:ic){
          for(j in 1:9){
             xmat[i,j] = round(100*qf(.99,j,denomdf[i]))/100
          }
    }
    xmat = cbind(denomdf,xmat)
    xmat = rbind(c(0,numdf),xmat)
    vec = c(0,round(100*qchisq(0.99, numdf)/numdf)/100)
    xmat=rbind(xmat,vec)
    xmat
}
