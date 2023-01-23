ftableb <-
function(){
top = 1:16
c1 = rep(c(.95,.975,.99),16)
c2 = rep(1,3)
c2s = c2
for(j in 2:16){c2=c2+1
               c2s=c(c2s,c2)}
is = length(c1)
js = length(top)
ptabs = matrix(rep(0,768),ncol=16)
for(i in 1:is)
    {for(j in 1:js)
        {ptabs[i,j] = qf(c1[i],top[j],c2s[i])}}
ptabs = round(100*ptabs)/100
ftableb = cbind(c1,c2s,ptabs)
ftableb 
}
