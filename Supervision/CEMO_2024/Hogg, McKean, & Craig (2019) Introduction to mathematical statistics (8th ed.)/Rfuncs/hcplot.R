hcplot <-
function(){
      load("scotteyehair.rda")
      vec = apply(scottish,2,sum)
      n=sum(vec)
      vecs = sort(vec,decreasing=T)
      vecs=vecs/n
      nms = c("Medium","Fair","Dark","Red","Black")
 
      postscript("c4s1egs1.ps")
      barplot(vecs,beside=TRUE,names.arg=nms,ylab="",xlab="Haircolor",cex.lab=1.8)
      title("Bar Chart of Haircolor of Scottish Schoolchildren",cex.main=1.25)
      dev.off()
}
