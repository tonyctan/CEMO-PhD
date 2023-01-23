simplegame <-
function(amtpaid){
       gain <- -amtpaid
       x <- 0:2; pace  <- (choose(4,x)*choose(48,2-x))/choose(52,2)
       x <- sample(1:6,1,prob=rep(1/6,6))
       if(x > 2){
            y <- sample(0:1,1,prob=rep(1/2,2))
            if(y==0){
                gain <- gain + 1
            } else {
                z <- sample(0:2,1,prob=pace)
                if(z==0){gain <- gain + 2}
                if(z==1){gain <- gain + 10}
                if(z==2){gain <- gain + 50}
             }
         }
         return(gain)
}
