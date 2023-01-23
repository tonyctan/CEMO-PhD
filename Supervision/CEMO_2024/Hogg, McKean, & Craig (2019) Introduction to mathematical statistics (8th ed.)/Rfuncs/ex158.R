ex158 <-
function(){
#   for Exercise 1.5.8
    plot(c(0,1)~c(-1.25,1.25),xlab="x",ylab="y",pch=" "); segments(-1.25,0,-1,0)
    segments(1.00,1,1.25,1); segments(-1,.25,1,.75)
    points(-1,.25,pch=18); points(1,1,pch=18);points(-1,0,pch=21)
    points(1,.75,pch=21);title("Exercise 1.5.8")}
