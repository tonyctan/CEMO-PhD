Raschthetahat_SE=function(x,delta) {
# arguments: x - person response vector
#                (needed only for plot.  without plot pass only obs scr X & delete
#                 calculation of the observed score within the funciton)
#            delta - vector containing as many item locations as there are 
#                    responses in x
# Call: Raschthetahat_SE(x,delta)


  # for plot set abscissa to have 9 tick marks,ordinate to have 5, & character labels to be 3
  
  par(lab=c(9,5,3))
  
  
  # general initializations for Rasch person estimation
  
  maxit=20       # maxiterations
  ccrit=0.001    # convergence criterion
  L = length(x)  # nitems
  
  X = sum(x)     # calc observed score
  
  
  
# To mimic the typical MLE implementation uncomment the follow if statement.
# Deal w/ zero variance response vectors; change X = 0 to be X = 0.5 & 
#     change X= L to be X = L -0.5.  The resulting person location estimates are
#     not MLEs, but pseudo MLEs.
  if(X==0) {
    X=0.5
  } else {
    if (X==L) {
      X=L-0.5
    }
  }
  
  t_est=log(X/(L-X))  # initial value for t_est
  
  # estimation
  
  it = 1
  
  converged = FALSE
  
  while ((it <= maxit) & (! converged) ) {
    expctdX = 0.0
    expctdVar = 0.0
    for (j in 1:L) {
      p = 1/(1+exp(-1.0*(t_est-delta[j])))
      
      expctdX = expctdX + p                      # Equation A.9
      
      
      expctdVar = expctdVar + (1-p)*p            # essentially Equation A.10
      
      
    }  # for j loop
    
    step=(X - expctdX)/-expctdVar


    t_est=t_est - step                           # Equation A.5

#   to see the iteration table uncomment the following two lines
#    if (it==1) {print('iteration  pre_t        1st      2nd          step      post_t') }
#   cat(sprintf("%12.d %10.5f %10.5f %10.5f %10.5f %10.5f",it,(t_est+step),(X - expctdX),(-expctdVar),step,t_est),"\n")

    
    converged = abs(step) < ccrit
    
    if (converged | it == maxit) {
      se = 1/sqrt(expctdVar)                     # Equation A.12
    }
    
    
    it = it + 1
  }  # while it & step loop
  
  
  
  # produce lnL plot
  mintheta= -4.0; maxtheta = 4.0; incr = 0.1   # initializations
  nvals=(abs(mintheta)+abs(maxtheta))/incr+1
  lnL = rep(0.0,nvals)   
  t = seq(mintheta,maxtheta,incr)
  
  for (k in 1:81) {
    
    lnLike = 0.0
    
    for (j in 1:L) {
      
      p = 1/(1+exp(-1.0*(t[k]-delta[j])))
      
      lnLike = lnLike + x[j]*log(p) + (1-x[j])*log(1 - p)
      
    }  # for j loop
    
    lnL[k] = lnLike
    
  }  # for k loop
  
  
  cat(plot(t,lnL,xlab="theta",type="l",ylab="lnL",xlim=c(mintheta,maxtheta)),"\n")
  
  cat(paste("theta est",t_est,"\n")) 
  cat(paste("SEE",se,"\n"))
  cat(paste("Converged ",converged,"\n"))
  
  Raschthetahat_SE=c(t_est,se)
}

