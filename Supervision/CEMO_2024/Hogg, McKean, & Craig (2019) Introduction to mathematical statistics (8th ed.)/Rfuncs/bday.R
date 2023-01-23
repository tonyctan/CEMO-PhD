bday <-
function(n){
    bday = 1
    nm1 = n - 1
    for(j in 1:n){
       bday = bday*((365-(j-1))/365)
    }
    bday <- 1 - bday
    return(bday)
}
