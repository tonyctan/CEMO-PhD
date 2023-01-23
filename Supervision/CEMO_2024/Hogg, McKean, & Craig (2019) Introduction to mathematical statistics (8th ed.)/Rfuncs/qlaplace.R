qlaplace <-
function(ps){
low<-ps[ps < .5]
high<-ps[ps >= .5]
lowq<-log(2*low)
highq<--log(2*(1-high))
qlaplace<-c(lowq,highq)
}
