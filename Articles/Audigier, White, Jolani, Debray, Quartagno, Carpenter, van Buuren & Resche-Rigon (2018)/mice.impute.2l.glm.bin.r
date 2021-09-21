require(lme4)
require(MASS)
require(mvtnorm)

mice.impute.2l.glm.bin <- function(y, ry, x,type,...){
  # the main code
  x<-cbind.data.frame(rep(1,nrow(x)), x)
  names(x) <- paste("V",1:ncol(x),sep="")
  
  type <- c(2, type)
  
  clust <- names(x)[type==(-2)]
  rande <- names(x)[type==2]
  fixe <- names(x)[type>0]
  
  n.class <- length(unique(x[,clust]))
  x[,clust] <- factor(x[,clust], labels=1:n.class)
  lev<-levels(x[,clust])
  X<-x[,fixe,drop=F]
  Z<-x[,rande,drop=F]
  xobs<-x[ry,,drop=F]
  yobs<-y[ry]
  Xobs<-X[ry,,drop=F]
  Zobs<-Z[ry,,drop=F]
  
  
  randmodel <- paste("yobs ~ ", paste(fixe[-1], collapse="+"),
                     "+ ( 1 +", paste(rande[-1],collapse="+"), 
                     "|", clust, ")") # [-1] to remove intercept
  
  suppressWarnings(fit <- try(glmer(formula(randmodel), 
                                    data = data.frame(yobs,xobs), 
                                    family = binomial),silent=F))
  if(!is.null(attr(fit,"class"))){
    if(attr(fit,"class")=="try-error"){
      warning("glmer cannot be run, sorry!")
      return(y[!ry])
    }
  }  
  
  # draw beta*
  beta <- fixef(fit)
  rv <- t(chol(vcov(fit)))
  beta.star <- beta + rv %*% rnorm(ncol(rv))
  
  # calculate psi*
  rancoef <- as.matrix(ranef(fit)[[1]]) 
  lambda <- t(rancoef)%*%rancoef
  temp <- ginv(lambda)
  ev <- eigen(temp)
  

  if (mode(ev$values) == "complex") {
    ev$values <- suppressWarnings(as.numeric(ev$values))
    ev$vectors <- suppressWarnings(matrix(as.numeric(ev$vectors),nrow=length(ev$values)))
  }
  if(sum(ev$values<0)>0)
  {
    ev$values[ev$values<0]<-0
    temp <- ev$vectors%*%diag(ev$values)%*%t(ev$vectors)
  }

  deco <- (ev$vectors)%*%sqrt(diag(ev$values))
  temp.psi.star <- rWishart(1, nrow(rancoef), diag(nrow(lambda)))[,,1]
  psi.star <- ginv(deco%*%temp.psi.star%*%t(deco)) 
  
  #### psi.star positive definite?
  if (!isSymmetric(psi.star)){
    psi.star <- (psi.star + t(psi.star))/2
  }
  valprop<-eigen(psi.star)
  if(sum(valprop$values<0)>0)
  {
    valprop$values[valprop$values<0]<-0
    psi.star<-valprop$vectors%*%diag(valprop$values)%*%t(valprop$vectors)
  }

  
  misindicator<-aggregate(as.data.frame(ry),by=list(clust=x[,clust]),FUN=function(x){sum(x)!=length(x)})
  
  for (i in lev[misindicator[,2]]){
    suppressWarnings(bi.star <- t(rmvnorm(1,mean = rep(0,nrow(psi.star)), sigma = psi.star, method="chol"))) # draw bi
    logit <- as.matrix(X[!ry & x[,clust]==i,]) %*% beta.star + as.matrix(Z[!ry & x[,clust]==i,])%*% bi.star
    y[!ry & x[,clust]==i]<- rbinom(nrow(logit), 1, as.vector(1/(1 + exp(-logit))))
  }
  return(y[!ry])
}
