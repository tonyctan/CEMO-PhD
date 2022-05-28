# Point working directory to current directory, depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("M:/pc/Dokumenter/PhD/Data/plots/pcm")
} else {
    setwd("/home/tony/uio/pc/Dokumenter/PhD/Data/plots/pcm")
}
if (interactive()) {getwd()} else {
    cat(paste0(
    "Working directory is now set to ", getwd(), "\n"
    ))
}

# Read in point estimates
e_par <- read.table("E_par.txt", sep = "\t", header = T)
# Read in standard errors
e_se <- read.table("E_se.txt", sep = "\t", header = T)

# Pre-define 5 colours that are colour blind-friendly
library(RColorBrewer)
colour <- brewer.pal(5, "Dark2")

# Save plot into PDF
pdf("e_vis.pdf")

matplot(
    e_par[, -1],                    # Exclude the first column (subject name)
    main = "Exam Grades",
    xlab = "", ylab = "",           # Remove x and y labels
    ylim = c(-8, 4.5),                # Set y-axis limits
    type = "l",                     # Line plot
    lty = 1, lwd = 2,               # Line type solid, line width
    col = colour,                   # Use pre-defined colours
    xaxt = "n"                      # No x-axis
)
axis(
    side = 1,                       # Horizontal/bottom axis
    at = c(1:dim(e_par)[1]),                   # Display each subject name
    labels = e_par[, 1],            # Labels drawn from first column
    las = 2,                        # Perpendicular to axis
    lwd.tick = 0                    # Turn off tick marks
)
grid(
    nx = 0, ny = NULL,
    col = "black",
    lty = "dashed", lwd = 0.5
)
legend(
    "bottomleft",                   # Position of legend
    inset = 0.03,                   # Inset from plot
    legend = rev(names(e_par)[-1]), # Use reverse order of subjects
    col = rev(colour),              # Use default colours (but reverse)
    lty = 1, lwd = 2,               # Line type solid, line width
    seg.len = 3,                    # Length of legend segments
    cex = 1,                        # Increase font size
    horiz = T,                      # Horizontal layout
    bty = "n"                       # No border
)

# Add 95% confidence intervals
for (j in 1:I(dim(e_par)[2]-1)) { # By 5 switching points (the "b" parameters)
    for (i in 1:dim(e_par)[1]) { # By 15 subjects (including gaps)
        arrows(
            i, e_par[i, j + 1] + 1.96 * e_se[i, j + 1],
            i, e_par[i, j + 1] - 1.96 * e_se[i, j + 1],
            length = 0.025,
            angle = 90, # Arrow head perpendicular to shaft
            code = 3, # Draw arrow head on both ends
            col = colour[j]
        )
    }
}

dev.off()
