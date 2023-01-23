mlelogistic <-
function(x,theta0=mean(x),numstp=100,eps=.0001){
n = length(x)
numfin = numstp
small = 1.0*10^(-8)
ic = 0
istop = 0
while(istop == 0){
    ic = ic + 1
    expx = exp(-(x - theta0))
    lprime = n-2*sum(expx/(1+expx))
    ldprime = -2*sum(expx/(1+expx)^2)
    theta1 = theta0 - (lprime/ldprime)
    check = abs(theta0-theta1)/abs(theta0 + small)
    if(check < eps){istop=1}
    theta0 = theta1
}
list(theta1=theta1,check=check,realnumstps=ic)
}
