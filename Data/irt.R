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
difficulty <- data.table::fread("./Rolf/57730.csv")
if (interactive()) {names(difficulty)} else {print("Data loading complete.")}
if (interactive()) {dim(difficulty)}

# Load R package `mirt`
suppressWarnings(suppressMessages(library(mirt)))

# Generalised partial credit model
gpcm <- mirt(difficulty[,c(9:20)], itemtype = "gpcm", SE = T)
coef(gpcm, printSE = T, IRTpars = T)
data.table::fwrite(coef(gpcm, printSE = T, IRTpars = T, as.data.frame = T),
    "./Rolf/parameter.csv",
    now.names = T
)

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
    "Physical Education",
    "Music",
    "Food and Health",
    "Arts and Handcraft",
    "Religion"
)

# Item characteristic curves
# Auto-print is off in loops, causing corrupted PDFs. Insert print().
for (i in 1:12) {
    pdf(file = paste0("./Rolf/trace/trace_", subj_code[i], ".pdf"))
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
    pdf(file = paste0("./Rolf/score/score_", subj_code[i], ".pdf"))
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
    pdf(file = paste0("./Rolf/info/infoSE_", subj_code[i], ".pdf"))
    print(itemplot(gpcm, item = i, type = 'infoSE', CE = T,
            xlim = c(-6.5,6.5),
            main = paste0(
                "Information and SE for ", subj_code[i], " (", subj_name[i], ")"
            )
    ))
    dev.off()
}


  #                            #  
 ###                          ### 
#####       End script       #####
