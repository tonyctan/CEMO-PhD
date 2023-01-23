
# Turn on R package tikzDevice
library("tikzDevice")
options(tikzMetricPackages = c(
    "\\usepackage[utf8]{inputenc}",
    "\\usepackage[T1]{fontenc}",
    "\\usetikzlibrary{calc}",
    "\\usepackage{amssymb}"
))
# Set up a tikz device
tikz("normal-dist.tex", width = 8, height = 4,
    standAlone = TRUE,
    packages = c(
        "\\usepackage{tikz}",
        "\\usepackage[active,tightpage,psfixbb]{preview}",
        "\\PreviewEnvironment{pgfpicture}",
        "\\setlength\\PreviewBorder{0pt}",
        "\\usepackage{amssymb}"
    )
)
# Draw a normal curve
u = seq(-3, 3, by = 0.01)
plot(u, dnorm(u), type="l", axes = FALSE, xlab = "", ylab = "", col = "white")
axis(1)
I = which((u>=0) & (u<=1))
polygon(
    c(u[I], rev(u[I])),
    c(dnorm(u)[I], rep(0,length(I))),
    col="red", border=NA
)
lines(u, dnorm(u), lwd = 2, col = "blue")
# Add text
text(-1.5, dnorm(-1.5) + 0.17,
    "$\\textcolor{blue}{X\\sim\\mathcal{N}(0,1)}$",
    cex = 1.5
)
text(1.75, dnorm(1.75) + .25,
    "$\\textcolor{red}{\\mathbb{P}(X\\in[0,1])=\\displaystyle{\\int_0^1 \\varphi(x)dx}}$",
    cex = 1.5
)
# Turn off device
dev.off()
