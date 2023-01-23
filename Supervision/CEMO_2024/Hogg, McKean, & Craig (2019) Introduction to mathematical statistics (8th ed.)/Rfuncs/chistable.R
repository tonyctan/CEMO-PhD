chistable <-
function(){
x = c(.01,.025,0.50,.10,.90,.95,.975,.99)
top = 30
ptabs = matrix(rep(0,240),ncol=8)
for(i in 1:8)
    {ptabs[,i] = qchisq(x[i],1:top)}
ptabs = round(1000*ptabs)/1000
chistable = cbind(1:top,ptabs)
chistable 
}
