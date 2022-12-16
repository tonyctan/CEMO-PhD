###### ADMIN INFO ######
# Date: 19 Feb 2023
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Visualise IRT parameters

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files
# containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to the GPA paper folder depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("M:/p1708-tctan/Documents/Paper_GPA/")
} else {
    setwd("/tsd/p1708/home/p1708-tctan/Documents/Paper_GPA")
}

if (interactive()) {
    getwd()
} else {
    cat(paste0(
        "Working directory is now set to ", getwd(), "\n"
    ))
}

        ########################
        # Model fit statistics #
        ########################

# Read in model fit statistics
infit <- data.frame(data.table::fread("./data/11_pcm_infit_holder.csv"))
outfit <- data.frame(data.table::fread("./data/11_pcm_outfit_holder.csv"))

rownames(infit) <- rownames(outfit) <- c(
    "NORW",
    "NORO",
    "ENGW",
    "ENGO",
    "MATH",
    "NATS",
    "SOCS",
    "RELI",
    "MUSI",
    "HAND",
    "PHED",
    "FOOD",
    "E-MATH",
    "E-ENGW",
    "E-NORW",
    "E-ENGO",
    "E-NORO"
)
colnames(infit) <- colnames(outfit) <- c(
    "PV1", "PV2", "PV3", "PV4", "PV5",
    "PV6", "PV7", "PV8", "PV9", "PV10"
)

pdf("./figures/fit.pdf")
jerk = 0.13
# Visualise fit statistics
plot(
    cbind(rep(1 - jerk, 10), unlist(infit[1, ])),
    xlim = c(0, 17), ylim = c(0.4, 1.6),
    xlab = "", ylab = "",
    main = "IRT Model Fit Statistics",
    xaxt = "n", # Turn off horizontal axis for further customisation
    las = 1, # label horizontal
    col = "blue"
)
axis(1,
    at = seq(1:17),
    labels = rownames(infit),
    las = 2 # text vertical
)
par(new = TRUE)
plot(
    cbind(rep(1 + jerk, 10), unlist(outfit[1, ])),
    xlim = c(0, 17), ylim = c(0.4, 1.6),
    xaxt = "n", yaxt = "n", ann = FALSE,
    col = "red"
)
for (i in 2:17) {
    par(new = TRUE)
    plot(
        cbind(rep(i - jerk, 10), unlist(infit[i, ])),
        xlim = c(0, 17), ylim = c(0.4, 1.6),
        xaxt = "n", yaxt = "n", ann = FALSE,
        col = "blue"
    )
    par(new = TRUE)
    plot(
        cbind(rep(i + jerk, 10), unlist(outfit[i, ])),
        xlim = c(0, 17), ylim = c(0.4, 1.6),
        xaxt = "n", yaxt = "n", ann = FALSE,
        col = "red"
    )
}
# Add reference lines (1, +/- 0.2, +/- 0.4)
abline(h = 1)
abline(h = c(0.8, 1.2), col = "black", lty = "dotted")
abline(h = c(0.6, 1.4), col="gray", lty = "dotted")
# Add legend
legend("topleft",
    legend = c(
        "Information weighted fit (infit)",
        "Unweighted fit mean square (outfit)"
    ),
    col = c("blue", "red"),
    lty = c(0, 0),  # No solid line through little circles
    pch=c(1, 1),    # Both are circles
    lwd = 2,        # Thicker circles
    bty = "n"       # No border
)
dev.off()

        #########################
        # Difficulty thresholds #
        #########################

# Read in IRT results
par <- data.frame(data.table::fread("./data/11_pcm_mi_par.csv"))
SE <- data.frame(data.table::fread("./data/11_pcm_mi_SE.csv"))

# Assign row name (same as model fit statistics) and column names
rownames(par) <- rownames(SE) <- rownames(infit)
colnames(par) <- colnames(SE) <- c(
    "delta_1", "delta_2", "delta_3", "delta_4", "delta_5"
)

# Re-order the subjects from the hardest to the easiest
par_teacher <- par[c(5, 1, 3, 6, 4, 2, 8, 7, 9, 10, 11, 12), ]
SE_teacher <- SE[c(5, 1, 3, 6, 4, 2, 8, 7, 9, 10, 11, 12), ]

# Generate 5 colours that are colour blind-friendly
colors <- RColorBrewer::brewer.pal(n = 5, name = "Dark2")

pdf("./figures/teacher-assigned.pdf")
plot(
    cbind(seq(1:12), unlist(par_teacher[, 1])),
    ylim = c(-7.5, 4.5),
    xlab = "", ylab = "", # Fine tune labels later
    main = "Difficulty Thresholds for Teacher-assigned Grades",
    type = "l", # Link dots using solid lines
    las = 1, # Set labels to horizontal
    xaxt = "n", # Turn off horizontal axis for further customisation
    col = colors[1]
)
# Customise horizontal axis
axis(1, # 1 = horizontal axis
    at = seq(1:12),
    labels = rownames(par_teacher),
    las = 2 # Rotate texts to vertical
)
# Rotate y-axis label to vertical
mtext(expression(delta), side = 2, line = 3, las = 1)
# Add 95% CI bars
for (i in 1:12) { # upper bound
    arrows(
        x0 = i,
        y0 = par_teacher[[i, 1]],
        x1 = i,
        y1 = par_teacher[[i, 1]] + 1.96 * SE_teacher[[i, 1]],
        angle = 90,
        length = 0.05,
        code = 2,
        col = colors[1],
        lwd = 1
    )
}
for (i in 1:12) { # lower bound
    arrows(
        x0 = i,
        y0 = par_teacher[[i, 1]],
        x1 = i,
        y1 = par_teacher[[i, 1]] - 1.96 * SE_teacher[[i, 1]],
        angle = 90,
        length = 0.05,
        code = 2,
        col = colors[1],
        lwd = 1
    )
}
# Repeat this procedure for delta_2 to delta_5
for (j in 2:5) {
    par(new = TRUE)
    plot(
        cbind(seq(1:12), unlist(par_teacher[, j])),
        ylim = c(-7.5, 4.5),
        xaxt = "n", yaxt = "n", ann = FALSE,
        main = "Teacher-assigned Grades",
        type = "l",
        col = colors[j]
    )
    for (i in 1:12) { # upper bound
        arrows(
            x0 = i,
            y0 = par_teacher[[i, j]],
            x1 = i,
            y1 = par_teacher[[i, j]] + 1.96 * SE_teacher[[i, j]],
            angle = 90,
            length = 0.05,
            code = 2,
            col = colors[j],
            lwd = 1
        )
    }
    for (i in 1:12) { # lower bound
        arrows(
            x0 = i,
            y0 = par_teacher[[i, j]],
            x1 = i,
            y1 = par_teacher[[i, j]] - 1.96 * SE_teacher[[i, j]],
            angle = 90,
            length = 0.05,
            code = 2,
            col = colors[j],
            lwd = 1
        )
    }
}
# Add horizontal grid lines
abline(h = -6:4, col = "gray", lty = "dotted")
# Add legend
legend("topright",
    legend = c(
        latex2exp::TeX(r'($delta_5$)'),
        latex2exp::TeX(r'($delta_4$)'),
        latex2exp::TeX(r'($delta_3$)'),
        latex2exp::TeX(r'($delta_2$)'),
        latex2exp::TeX(r'($delta_1$)')
    ),
    col = c(
        colors[5],
        colors[4],
        colors[3],
        colors[2],
        colors[1]
    ),
    lty = 1,        # Solid line
    cex = 1,        # normal line thickness
    bty = "n",      # no border
    horiz = TRUE    # Lay out legend horizontally
)
dev.off()

  #                            #  
 ###                          ### 
#####       End script       #####
