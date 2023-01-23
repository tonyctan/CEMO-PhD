normtab <-
function(){ za <- seq(0.00,3.59,.01);
#  Generates normal table of probabilities
    pz <- t(matrix(round(pnorm(za),digits=4),nrow=10))
    colnames(pz) <- seq(0,.09,.01)
    rownames(pz) <- seq(0.0,3.5,.1); return(pz)}
