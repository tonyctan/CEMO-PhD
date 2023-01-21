# Read in PISA 2018 Student Questionnaire ST183 data
setwd("~/uio/pc/Dokumenter/PhD/Stat_Help/Raphael/")
irt <- read.table("PISA_2018_STU_ST034_NOR.txt",
    header = TRUE, sep = "\t"
)
# Rename the columns
names(irt) <- c("Sex", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6")
irt$Sex <- factor(irt$Sex,
    levels = c(1, 2),
    labels = c("Female", "Male")
)
# Record the number of students out of the OECE database
N0 <- nrow(irt) # N_0 = 14,274 students


# Remove cases with missing values
irt <- irt[complete.cases(irt), ]
# Record the number of useable cases
N <- nrow(irt) # N = 12,008 students

# Calculate data loss rate
loss <- (N0 - N) / N * 100 # 18.87%

        ##########################
        # Descriptive statistics #
        ##########################

irt_M <- irt[which(irt$Sex == "Male"), ]
irt_F <- irt[which(irt$Sex == "Female"), ]

psych::describeBy(irt, group = irt$Sex, mat = TRUE, type = 3, digits = 2)

rbind(
    table(unlist(irt_M$Sex)),
    table(unlist(irt_F$Sex))
)

rbind(
    table(unlist(irt_M$Q1)),
    table(unlist(irt_F$Q1))
)

rbind(
    table(unlist(irt_M$Q2)),
    table(unlist(irt_F$Q2))
)

rbind(
    table(unlist(irt_M$Q3)),
    table(unlist(irt_F$Q3))
)

rbind(
    table(unlist(irt_M$Q4)),
    table(unlist(irt_F$Q4))
)

rbind(
    table(unlist(irt_M$Q5)),
    table(unlist(irt_F$Q5))
)

rbind(
    table(unlist(irt_M$Q6)),
    table(unlist(irt_F$Q6))
)


# Correlation matrix
round(cor(irt_M[, -1], use = "pairwise.complete.obs", method = "pearson"), 2)
round(cor(irt_F[, -1], use = "pairwise.complete.obs", method = "pearson"), 2)

        ##############################
        # Item response theory (IRT) #
        ##############################
library(mirt)

# GPCM model
gpcm_all <- mirt(irt[, -1], model = 1, itemtype = "gpcm", verbose = FALSE)
gpcm_M <- mirt(irt_M[, -1], model = 1, itemtype = "gpcm", verbose = FALSE)
gpcm_F <- mirt(irt_F[, -1], model = 1, itemtype = "gpcm", verbose = FALSE)

# Model fit
M2(gpcm_all, type = "C2", use_dentype_estimate = TRUE)
M2(gpcm_M, type = "C2", use_dentype_estimate = TRUE)
M2(gpcm_F, type = "C2", use_dentype_estimate = TRUE)

# DIF: 1st round --- identify DIF items
irt.mg <- multipleGroup(
    data = irt[, -1], model = 1, group = irt$Sex, itemtype = "gpcm",
    invariance = c("free_means", "free_var", colnames(irt[, -1])),
    SE = TRUE, verbose = FALSE
)

# Item fit
itemfit(irt.mg)

DIF(irt.mg,
    which.par = c("a1", "d"),
    scheme = "drop", item2test = 1:6, seq_stat = "BIC", verbos = FALSE
)
# Conclusion: Q1--Q4 have DIF; Q5--Q6 no DIF

        #########
        # Plots #
        #########

irt.mg <- multipleGroup(
    data = irt[, -1], model = 1, group = irt$Sex, itemtype = "gpcm",
    invariance = c("free_means", "free_var", colnames(irt[, -1])[-c(1:4,6)]),
    SE = TRUE, verbose = FALSE
)

library(latex2exp)
.axis.h <- seq(-4, 4, by = 0.01)

.colour.M <- c("blue", "blue", "blue", "blue", "black", "black")
.colour.F <- c("red", "red", "red", "red", "white", "white")
.colour <- cbind(.colour.M, .colour.F)

pdf("./CCC.pdf", width=10.5, height=14.85)
par(mfrow = c(3, 2), oma = c(0, 1, 1, 0))


for(.i in 1:6){

# Plot a phantom ICC just to set up the title and axes
plot(
    .axis.h,
    probtrace(extract.item(extract.group(irt.mg, 1), .i), .axis.h)[, 1],
    type = "l",
    xlab = TeX("$\\theta$"),
    ylab = TeX("$P(\\theta)$"),
    ylim = c(0, 1),
    col = "white",
    main = paste0(
        "Category Characteristic Curves for ST034Q0", .i, "NA"
    )
) # close plot()

par(new = TRUE)

for(.j in 1:4){
par(new = TRUE)
plot(
    .axis.h,
    probtrace(extract.item(extract.group(irt.mg, 1), .i), .axis.h)[, .j],
    type = "l",
    axes = F,         # Turn off both horizontal and vertical axes
    ann = F,          # Turn off axes ticks/markers/scales/numbers
    ylim = c(0, 1),
    col = .colour[.i , 1]
    )   # close plot()
}   # Close for(.j in 1:4)

par(new = TRUE)     # Enable superimpose

for(.j in :4){
par(new = TRUE)
plot(
    .axis.h,
    probtrace(extract.item(extract.group(irt.mg, 2), .i), .axis.h)[, .j],
    type = "l",
    axes=F,         # Turn off both horizontal and vertical axes
    ann=F,          # Turn off axes ticks/markers/scales/numbers
    ylim = c(0, 1),
    col = .colour[.i , 2]
    )   # close plot()
}   # Close for (.j in 1:4)
}   # Close for(.i in 1:6)

par(mfrow=c(1,1))
dev.off()
