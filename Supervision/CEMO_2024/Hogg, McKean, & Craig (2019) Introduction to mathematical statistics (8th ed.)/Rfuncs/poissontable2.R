poissontable2 <-
function(){
ptabs = matrix(rep(0,11),ncol=11)
r1 = (0:10)/10
r2 = r1 + 1
r3 = c(0,2.2,2.4,2.6,2.8,3.0,3.2,3.4,3.6,3.8,4.0)
r4 = r3 + 2
r5 = c(0,6.5,7.0,7.5,8.0,8.5,9.0,9.5,10.0,10.5,11.0)

xmat = rbind(r1,r2,r3,r4,r5)
top = c(6,8,12,16,23)

for(i in 1:5){
    ptabs = rbind(ptabs,xmat[i,])
    ptemp = matrix(c(0:top[i]),ncol=1)
    for(j in 1:10){ptemp = cbind(ptemp,round(1000*ppois(0:top[i],xmat[i,j+1]))/1000)}
    ptabs = rbind(ptabs,ptemp)
}
poissontable2 = ptabs
poissontable2
#write(t(ptabs),ncol=11,file="pois2.tex")
}
