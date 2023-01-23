gibbser3 <-
function(alpha,beta,nt,m,n){
x0 = 1
yc = rep(0,m+n)
xc = c(x0,rep(0,m-1+n))
for(i in 2:(m+n)){yc[i] = rbeta(1,xc[i-1]+alpha,nt-xc[i-1]+beta)
              xc[i] = rbinom(1,nt,yc[i])}
y1=yc[1:m]
y2=yc[(m+1):(m+n)]
x1=xc[1:m]
x2=xc[(m+1):(m+n)]
list(y1 = y1,y2=y2,x1=x1,x2=x2)
}
