binomci <-
function(s,n,theta1,theta2,value,maxstp=100,eps=.00001){
    y1 = pbinom(s,n,theta1)
    y2 = pbinom(s,n,theta2)
    ic1 = 0
    ic2 = 0
    if(y1 >= value){ic1=1}
    if(y2 <= value){ic2=1}
    if((ic1*ic2) > 0){
        istep = 0
        while(istep < maxstp){
            istep = istep + 1
            theta3 = (theta1 + theta2)/2
            y3 = pbinom(s,n,theta3)
            if(y3 > value){
                 theta1 = theta3
                 y1 = y3
            } else {
                 theta2 = theta3
                 y2 = y3
            }
            if(abs(theta1-theta2) < eps){istep = maxstp}
         }
         list(solution=theta3,valatsol = y3)
     } else {
         list(error="Bad Starts")
     }
}
