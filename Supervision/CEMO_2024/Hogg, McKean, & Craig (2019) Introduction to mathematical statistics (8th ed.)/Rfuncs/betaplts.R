betaplts <-
function(){
#  Uncomment next line for a pdf file
   par(mfrow=c(4,4));r1=2:5; r2=2:5;x=seq(.01,.99,.01)
   for(a in r1){for(b in r2){plot(dbeta(x,a,b)~x);
   title(paste("alpha = ",a,"beta = ",b))}}}
