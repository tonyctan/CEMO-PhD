plotsulfur <-
function(){
    load("sulfurdio.rda")
    postscript("histsulfur.ps")
    hist(sulfurdioxide,xlab="Sulfurdioxide",ylab=" ",pr=T,ylim=c(0,.04),cex.main=1.25)
    lines(density(sulfurdioxide))
    y = dnorm(sulfurdioxide,53.91667,10.07371)
    lines(y~sulfurdioxide,lty=2)
    dev.off()
}
