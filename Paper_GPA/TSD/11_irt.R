###### ADMIN INFO ######
# Date: 03 May 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: IRT analysis of subject difficulties

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files
# containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to ~/Documents, depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("M:/p1708-tctan/Documents")
} else {
    setwd("/tsd/p1708/home/p1708-tctan/Documents/")
}
if (interactive()) {getwd()} else {cat(paste0(
    "Working directory is now set to ", getwd(), "\n"
))}

# Read in minor_3_plus (N = 57730, the most restrictive dataset)
if (!interactive()) {print("Start data loading...")}
difficulty <- data.table::fread("./Rolf/60618.csv")
if (interactive()) {names(difficulty)} else {print("Data loading complete.")}
if (interactive()) {dim(difficulty)}

# Save subjects' codes and names
subj_code <- names(difficulty)[-c(1:8)]
subj_name <- c(
    "Written Norwegian",
    "Oral Norwegian",
    "Written English",
    "Oral English",
    "Mathematics",
    "Natural Sciences",
    "Social Sciences",
    "Religion",
    "Music",
    "Arts and Handcraft",
    "Physical Education",
    "Food and Health",
    "Mathematics (written exam)",
    "English (written exam)",
    "Norwegian (written exam)",
    "English (oral exam)",
    "Norwegian (oral exam)"
)

# Load R package `mirt`
suppressWarnings(suppressMessages(library(mirt)))

# Partial credit model
pcm <- mirt(difficulty[,c(9:25)], itemtype = "Rasch", SE = T)
pcm_coef <- coef(pcm, printSE = T, IRTpars = T, as.data.frame = T)
data.table::fwrite(
    cbind(row.names(pcm_coef), round(pcm_coef, digits = 3)),
    "./Rolf/pcm/par_60618.csv"
)

# Option response function
# Auto-print is off in loops, causing corrupted PDFs. Insert print().
for (i in 1:12) {
    pdf(file = paste0("./Rolf/pcm/trace/trace_", subj_code[i], ".pdf"))
    print(directlabels::direct.label(
        itemplot(pcm, item = i, type = 'trace',
            theta_lim = c(-11,6),
            main = paste0(
                "Trace Plot for ", subj_code[i], " (", subj_name[i], ")"
            )
        ), 'top.points'
    ))
    dev.off()
}

# Expected scores
for (i in 1:12) {
    pdf(file = paste0("./Rolf/pcm/score/score_", subj_code[i], ".pdf"))
    print(itemplot(pcm, item = i, type = 'score', CE = T,
            theta_lim = c(-11,6),
            main = paste0(
                "Expected Score for ", subj_code[i], " (", subj_name[i], ")"
            )
    ))
    dev.off()
}

# Information and standard errors
for (i in 1:12) {
    pdf(file = paste0("./Rolf/pcm/info/infoSE_", subj_code[i], ".pdf"))
    print(itemplot(pcm, item = i, type = 'infoSE', CE = T,
            theta_lim = c(-11,6),
            main = paste0(
                "Information and SE for ", subj_code[i], " (", subj_name[i], ")"
            )
    ))
    dev.off()
}

# Diagnostic tests

# Empirical reliability (F1 = 0.9537, using both EAP (quick) and MAP (slow))
fscores(pcm, method = "EAP", full.scores = T, full.scores.SE = T, returnER = T)

# Conditional dependence information
residuals(pcm)

for (i in 1:12) {
    pdf(file = paste0("./Rolf/pcm/empirical/emp_", subj_code[i], ".pdf"))
    print(itemfit(pcm,
        group.bins = 10,
        empirical.plot = i,
        empirical.CI = 0.95,
        empirical.ploy.collapse = T
    ))
    dev.off()
}

itemfit(pcm,
    group.bins = 10,
    empirical.plot = 1,
    empirical.CI = 0.95,
    empirical.ploy.collapse = T
)













# Generalised partial credit model
gpcm <- mirt(difficulty[,c(9:20)], itemtype = "gpcm", SE = T)
gpcm_coef <- coef(gpcm, printSE = T, IRTpars = T, as.data.frame = T)
data.table::fwrite(
    cbind(row.names(gpcm_coef), round(gpcm_coef, digits = 3)),
    "./Rolf/gpcm/par.csv"
)


# Option response function
for (i in 1:12) {
    pdf(file = paste0("./Rolf/gpcm/trace/trace_", subj_code[i], ".pdf"))
    print(directlabels::direct.label(
        itemplot(gpcm, item = i, type = 'trace',
            xlim = c(-6.5,6.5),
            main = paste0(
                "Trace Plot for ", subj_code[i], " (", subj_name[i], ")"
            )
        ), 'top.points'
    ))
    dev.off()
}

# Expected scores
for (i in 1:12) {
    pdf(file = paste0("./Rolf/gpcm/score/score_", subj_code[i], ".pdf"))
    print(itemplot(gpcm, item = i, type = 'score', CE = T,
            xlim = c(-6.5,6.5),
            main = paste0(
                "Expected Score for ", subj_code[i], " (", subj_name[i], ")"
            )
    ))
    dev.off()
}

# Information and standard errors
for (i in 1:12) {
    pdf(file = paste0("./Rolf/gpcm/info/infoSE_", subj_code[i], ".pdf"))
    print(itemplot(gpcm, item = i, type = 'infoSE', CE = T,
            xlim = c(-6.5,6.5),
            main = paste0(
                "Information and SE for ", subj_code[i], " (", subj_name[i], ")"
            )
    ))
    dev.off()
}

# Diagnostic tests

# Empirical reliability (F1 = 0.9537, using both EAP (quick) and MAP (slow))
fscores(gpcm, method = "EAP", full.scores = T, full.scores.SE = T, returnER = T)

# Conditional dependence information
residuals(gpcm)

for (i in 1:12) {
    pdf(file = paste0("./Rolf/gpcm/empirical/emp_", subj_code[i], ".pdf"))
    print(itemfit(gpcm,
        group.bins = 10,
        empirical.plot = i,
        empirical.CI = 0.95,
        empirical.ploy.collapse = T
    ))
    dev.off()
}



  #                            #  
 ###                          ### 
#####       End script       #####
