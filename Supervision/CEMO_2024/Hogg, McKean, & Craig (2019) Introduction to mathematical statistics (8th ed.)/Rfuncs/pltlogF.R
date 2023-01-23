pltlogF <-
function(){
     postscript("newfig8sect17.ps")
     x <- seq(-8,22,.01)
     y <- dlogF(x)
     plot(x,y,axes=F,xlab=" ",ylab=" ",type="l")
     q1 <- qlogF(.25)
     q2 <- qlogF(.50)
     q3 <- qlogF(.75)
     d1 <- dlogF(q1)
     d2 <- dlogF(q2)
     d3 <- dlogF(q3)
     axis(2,at=c(0,d2,d3),labels=c(" ","0.10","0.05"),pos=-8) 
#     axis(1,at=c(-8,q1,q2,q3),labels=c("-8","q1","q2","q3"),pos=0)
      axis(1,at=c(-8,q1,q2,q3),labels=c("-8",expression(italic(bold(q[1]))),expression(italic(bold(q[2]))),expression(italic(bold(q[3])))),pos=0,cex=2)
     segments(q1,0,q1,d1,cex=2)
     segments(q2,0,q2,d2,cex=2)
     segments(q3,0,q3,d3,cex=2)
     arrows(q3,0,22,0)
     arrows(-8,d2,-8,.113)
     text(23,-.0005,expression(italic(x)),cex=1.2)
     text(-8,.116,expression(italic(f(x))),cex=1.2)

     dev.off()
#> plot(y~x)
#> x <- seq(-8,18,.01)
#> y <- dlogF(x)
#> plot(y~x)
#> x <- seq(-8,22,.01)
#> y <- dlogF(x)
#> plot(y~x)
#> qlogF(.25)
#[1] -0.4419242
#> qlogF(.50)
#[1] 1.824549
#> qlogF(.75)
#[1] 5.321057
#> plogF(20)
#[1] 0.9867252
#> plogF(-10)
#[1] 4.539375e-05
#> plogF(5.321057)
#[1] 0.75
}
