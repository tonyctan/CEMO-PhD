# Import VG data
setwd("N:\\durable\\data\\registers")
vg <- data.table::fread("W21_4952_TAB_KAR_VG.csv")

# Inspect frequency distribution for 2018/19 data
freq <- data.frame(table(unlist(
    vg[which(vg$SKOLEAR == 20182019), ]$VIDEREGAENDEPOENG
)))

# Visualise raw data
plot(density(vg$VIDEREGAENDEPOENG, na.rm=T))

# Remove 0s and visualise again
pdf("M:/p1708-tctan/Documents/Sverre/Sverre.pdf")
    plot(
        density(vg$VIDEREGAENDEPOENG[vg$VIDEREGAENDEPOENG>0], na.rm=T),
        xlim = c(0,70),
        xlab = "Senior High School GPA", ylab = "Kernel Density",
        main = "Density Plot of 2018/19 Senior HIgh School GPA"
    )
dev.off()
