RaschItem_SE=function(x,item) {
  # arguments: x - response data matrix
  #                (needed only for plot.  without plot pass only item scr q & delete
  #                 calculation of the item score within the function)
  #            item - item of interest
  
  # Call: RaschItem_SE=function(x,item)
  
  
  # for plot set abscissa to have 9 tick marks,ordinate to have 5, & character labels to be 3
  
  par(lab=c(9,5,3))
  
  
  # general initializations for Rasch itemestimation
  
  maxit=20L       # maxiterations as an integer
  ccrit=0.001    # convergence criterion
  N = length(x[,item])  # n persons
  L = length(x[1,])     # Length: # of items
  L_1 = L-1
  
  q = as.integer(colSums(x))    # calc item score
  X=rowSums(x)       # calc observed scores, X
  
  nX = as.integer(table(X))          # frequency of each obs. score
  adjustment = nX[1]+nX[L+1]  # remove zero response vectors
  
  #  nX = hist(X,plot=F)  # Per R documentation, use the hist function to find the frequency distribution for performance reasons.
  #  adjustment = nX$counts[0]+nX$counts[L]  # remove zero response vectors
  
  t_est=rep(-99.9, L_1)     # determine provisional person estimates

  for (i in 1:L_1) {  t_est[i]=log(i/(L-i))   }
  
  Nadj= N - adjustment
  delta_est=0.0            # determine initial value for delta_est; Equation B.3
  for (j in 1:L) {
    q[j] = q[j] - adjustment
    delta_est = delta_est + log((Nadj-q[j])/q[j])
  }
  delta_est=log((N-q[item])/q[item]) - delta_est/L  
  
  
  # estimation 
  it = 1  
  converged = FALSE
  
  while ((it <= maxit) & (! converged) ) {
    expctdq = 0.0
    expctdVar = 0.0
    # offset due to X being 0-based & indexing is 1-based
    for (i in 1:L_1) {
      p = 1/(1+exp(-1.0*(t_est[i]- delta_est)))
      
      expctdq = expctdq + nX[i+1]*p                      # essentially numerator of Equation B.2
      
      
      expctdVar = expctdVar + nX[i+1]*p*(1-p)            # essentially denominator of Equation B.2
      
      
    }  # for j loop
    
    
    expctdq = expctdq - q[item]
    step=expctdq/-expctdVar
    
    delta_est =delta_est  - step                 # Equation B.2
    
    
    # To see the iteration table uncomment the following two lines    
#    if (it==1) {print('iteration  pre_d        1st          2nd          step      post_d') }
#      cat(sprintf("%12.d  %10.5f %12.5f %12.5f %10.5f %10.5f",it,(delta_est+step),expctdq, (-expctdVar),step,delta_est),"\n")

    converged = abs(step) < ccrit
    
    if (converged | it == maxit) {
      se = 1/sqrt(expctdVar)     }                  # essentially Equation B.4
    
    
    
    it = it + 1
  }  # while it & step loop
  
  
  # produce lnL plot
  mindelta= -4.0; maxdelta = 4.0; incr = 0.1   # initializations
  nvals=(abs(maxdelta)+abs(mindelta))/incr+1
  lnL = rep(0.0,nvals)   # initializations
  delta = seq(mindelta,maxdelta,incr)
  
  t_est=rep(-99.9, Nadj)
  u=rep(-99.9,Nadj)
  
  k=1
  for (i in 1:N) {
    if((X[i]>0) & (X[i] < L)) {      # deal w/ zero variance rsp vectors
      t_est[k]=log(X[i]/(L-X[i]))
      u[k]=x[i,item] 
      k = k + 1
    }
  }
  
  for (k in 1:nvals) {
    
    lnLike = 0.0
    
    for (i in 1:Nadj) {
      
      p = 1/(1+exp(-1.0*(t_est[i]-delta[k])))
      
      lnLike = lnLike + u[i]*log(p) + (1-u[i])*log(1 - p)
      
    }  # for i loop
    
    lnL[k] = lnLike
    
  }  # for k loop
  
  
  cat(plot(delta,lnL,main=paste("item ",item),xlab="delta",type="l",ylab="lnL",xlim=c(mindelta,maxdelta)),"\n")
  
  
  cat(paste("delta est",delta_est,"\n"))
  cat(paste("SEE",se,"\n"))
  cat(paste("Converged ",converged,"\n"))
  
  RaschItem_SE=c(delta_est,se)
} 
RaschItem_SE(x,1)