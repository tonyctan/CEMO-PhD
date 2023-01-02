# Read in SPSS data
setwd("~/uio/pc/Dokumenter/PhD/Coursework/UV9121 Process data/")
qqq <- foreign::read.spss("./FLT/CY07_MSU_FLT_QQQ.SAV", to.data.frame = TRUE)
rt <- foreign::read.spss("./FLT/CY07_MSU_FLT_TIM.SAV", to.data.frame = TRUE)

# Merge qqq and rt into flt by student ID (CNTSTUID)
flt <- merge(qqq, rt, by = "CNTSTUID")

# Only retain variables of interest
var_wanted <- c(
    "CNTRYID.x",
    "CNTSTUID",
    "ST004D01T",
    "HISEI",
    "W_FSTUWT",
    "FL164_TT",
    "FL164Q01HA", "FL164Q02HA", "FL164Q03HA", "FL164Q04HA", "FL164Q05HA", "FL164Q06HA", "FL164Q07HA", "FL164Q08HA", "FL164Q09HA", "FL164Q10HA", "FL164Q11HA", "FL164Q12HA", "FL164Q13HA", "FL164Q14HA", "FL164Q15HA", "FL164Q16HA", "FL164Q17HA", "FL164Q18HA",
    "PV1FLIT", "PV2FLIT", "PV3FLIT", "PV4FLIT", "PV6FLIT", "PV7FLIT", "PV8FLIT", "PV9FLIT", "PV10FLIT"
)
flt_trimmed <- flt[, names(flt) %in% var_wanted]

# Save datasets in CSV format
data.table::fwrite(qqq,
    "./Analysis/qqq.csv",
    sep = "\t", row.names = FALSE, nThread = getDTthreads()
)
data.table::fwrite(rt,
    "./Analysis/rt.csv",
    sep = "\t", row.names = FALSE, nThread = getDTthreads()
)
data.table::fwrite(flt_trimmed,
    "./Analysis/flt.csv",
    sep = "\t", row.names = FALSE, nThread = getDTthreads()
)
