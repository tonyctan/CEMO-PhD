dex165 <-
function(){
#  pmf for Exercise 1.6.5
   x=0:5
   pmf = choose(20,x)*choose(80,5-x)/choose(100,5)
   tab = rbind(x,pmf)
   return(tab)
}
