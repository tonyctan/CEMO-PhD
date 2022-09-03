# Previous achievement (low vs high achievers)
# We the authors decided to use 1 SD below mean as the cutoff for low achievers.
# We select the theoretical definition of $\mu=50$, $\sigma^2=10^2$ rather than
# the empirical mean(), sd() for our measure such that when distribution curves
# change shape, eg left tails retract, less students are classified as low ach.
ach_lo <- math2$np_math8 < 40 + 0
ach_hi <- math2$np_math8 > 60 + 0


# Sum mother's and father's income
atipcu_math <- ifelse(is.na(math2$atipcu_mo) & is.na(math2$atipcu_fa),
    NA,
    rowSums(cbind(math2$atipcu_mo, math2$atipcu_fa), na.rm=T)
)
atipcu_read <- ifelse(is.na(read2$atipcu_mo) & is.na(read2$atipcu_fa),
    NA,
    rowSums(cbind(read2$atipcu_mo, read2$atipcu_fa), na.rm=T)
)
