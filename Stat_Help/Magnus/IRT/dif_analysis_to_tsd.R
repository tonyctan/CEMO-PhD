setwd("/home/ubuntu/uio/pc/Dokumenter/PhD/Stat_Help/Magnus/IRT/")

dfkjonn <- data.table::fread("dfkjonn.csv")

multigrp <- mirt::multipleGroup(dfkjonn[1:34], 1, group = c(dfkjonn$Kjonn), rep("Rasch"), invariance = c("free_means", "free_vars", colnames(dfkjonn)))

mirt::DIF(MGmodel = multigrp, which.par = c("d1", "d2", "d3", "d4", "d5", "d"), scheme = "drop_sequential", items2test = colnames(dfkjonn)[1:34], seq_stat = "BIC") 

