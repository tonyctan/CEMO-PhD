ex1427 <-
function(){
#   Exercise 1.4.27
#   returns pwin = 1 if the player wins; else returns pwin=0
#
    pwin = 0; x = sample(1:20,1); y= sample(x:25,1)
    if(y>21){pwin=1}
    return(pwin)}
