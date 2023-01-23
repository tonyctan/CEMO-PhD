fp2 <-
function(){
    numdf = c(10,15,20,25,30,40,60,120)
    denomdf = c(1:30,40,60,120)
    ic = length(denomdf)
    xmat = matrix(rep(0,8*ic),ncol=8)
    for(i in 1:ic){
          for(j in 1:8){
             
             xmat[i,j] = round(100*qf(.95,numdf[j],denomdf[i]))/100
          }
    }
    xmat = cbind(denomdf,xmat)
     xmat = rbind(c(0,numdf),xmat)
    vec = c(0,round(100*qchisq(0.95, numdf)/numdf)/100)
    xmat=rbind(xmat,vec)
    vec2 = c(0,round(100*denomdf/qchisq(.05,denomdf))/100,1)
    xmat = cbind(xmat,vec2)
    xmat
}
