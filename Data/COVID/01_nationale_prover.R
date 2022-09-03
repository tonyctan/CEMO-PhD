###### ADMIN INFO ######
# Date: 11 August 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Re-format national test data

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files
# containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to the location of all registry datasets,
# depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("N:/durable/data/registers")
} else {
    setwd("/tsd/p1708/data/durable/data/registers")
}
if (interactive()) {
    getwd()
} else {
    cat(paste0(
        "Working directory is now set to ", getwd(), "\n"
    ))
}

# Read in national test data. Show header names if interactive.
if (!interactive()) {
    print("Start data loading...")
}
np <- data.table::fread("W21_4952_NASJONALE_PROVER.csv")
if (interactive()) {
    names(np)
} else {
    print("Data loading complete.")
}

# Inspect the year range of the national test data
table(unlist(np$AARGANG))
# Our data range from October 2007 October 2020

############
### Loop ###
############

aar <-  seq(2014, 2020) # [i] Cohort name
# aar = {2014, 2015, 2016, 2017, 2018, 2019, 2020}
aar_leng <- length(aar) # aar_leng should be 7
aargang <- paste0(aar, 10)

# Adjust plot parameters
par(
    mar = c(2, 2, 2, 2) # Reduce the plot margins from 5 (default) to 2
)

# Specify the path for PDF plots
pdf("N:/no-backup/COVID/01_nationale_prover.pdf")

for (i in 2:aar_leng) { # Year 8 (i=1), then Year 9 (i=2)

    ############
    ### MATH ###
    ############

    # Narrow down to Year 8
    temp1 <- np[which(np$PROVE == "NPREG08"), ]
    # Further narrow down to aar-1
    temp1 <- temp1[which(temp1$AARGANG == aargang[i - 1]), ]
    # Remove students whose participation status is A or I
    temp1 <- temp1[which(temp1$DELTATTSTATUS != "A"), ]
    temp1 <- temp1[which(temp1$DELTATTSTATUS != "I"), ]

    # Narrow down to Year 9
    temp2 <- np[which(np$PROVE == "NPREG09"), ]
    # Further narrow down to aar
    temp2 <- temp2[which(temp2$AARGANG == aargang[i]), ]
    # Remove students whose participation status is A or I
    temp2 <- temp2[which(temp2$DELTATTSTATUS != "A"), ]
    temp2 <- temp2[which(temp2$DELTATTSTATUS != "I"), ]

    # Merge aar-1 with aar
    temp <- dplyr::full_join(
        temp1,
        temp2,
        by = "w21_4952_lopenr_person"
    )

    # Only keep (always in 2014--2015 pair, except for Person ID):
    #   Admin variables:
    #   Person ID, School ID, Municipality, School Type, Participation Status
    #   Grade variables:
    #   Grades
    temp_math <- temp[, c(
        "w21_4952_lopenr_person",
        "w21_4952_lopenr_orgnr.x", "w21_4952_lopenr_orgnr.y",
        "SKOLEKOM.x", "SKOLEKOM.y",
        "SKOLETYPE.x", "SKOLETYPE.y",
        "DELTATTSTATUS.x", "DELTATTSTATUS.y",
        "SKALAPOENG.x", "SKALAPOENG.y"
    )]

    # Rename the columns
    names(temp_math) <- c(
        "idper",
        paste0("idsc_", aar[i - 1]), paste0("idsc_", aar[i]),
        paste0("scmu_", aar[i - 1]), paste0("scmu_", aar[i]),
        paste0("types_", aar[i - 1]), paste0("types_", aar[i]),
        paste0("partst_", aar[i - 1]), paste0("partst_", aar[i]),
        paste0("np_math8_", aar[i - 1]),  paste0("np_math9_", aar[i])
    )

    # Recode national test result 0.000 to NA
    temp_math[, 10] <- car::recode(unlist(temp_math[, 10]), "0 = NA")
    temp_math[, 11] <- car::recode(unlist(temp_math[, 11]), "0 = NA")
    # We will impute those NA using MI later.

    ############
    ### READ ###
    ############

    # Narrow down to Year 8
    temp1 <- np[which(np$PROVE == "NPLES08"), ]
    # Further narrow down to aar-1
    temp1 <- temp1[which(temp1$AARGANG == aargang[i - 1]), ]
    # Remove students whose participation status is A or I
    temp1 <- temp1[which(temp1$DELTATTSTATUS != "A"), ]
    temp1 <- temp1[which(temp1$DELTATTSTATUS != "I"), ]

    # Narrow down to Year 9
    temp2 <- np[which(np$PROVE == "NPLES09"), ]
    # Further narrow down to aar
    temp2 <- temp2[which(temp2$AARGANG == aargang[i]), ]
    # Remove students whose participation status is A or I
    temp2 <- temp2[which(temp2$DELTATTSTATUS != "A"), ]
    temp2 <- temp2[which(temp2$DELTATTSTATUS != "I"), ]

    # Merge aar-1 with aar
    temp <- dplyr::full_join(
        temp1,
        temp2,
        by = "w21_4952_lopenr_person"
    )

    # Only keep (always in 2014--2015 pair, except for Person ID):
    #   Admin variables:
    #   Person ID, School ID, Municipality, School Type, Participation Status
    #   Grade variables:
    #   Grades
    temp_read <- temp[, c(
        "w21_4952_lopenr_person",
        "w21_4952_lopenr_orgnr.x", "w21_4952_lopenr_orgnr.y",
        "SKOLEKOM.x", "SKOLEKOM.y",
        "SKOLETYPE.x", "SKOLETYPE.y",
        "DELTATTSTATUS.x", "DELTATTSTATUS.y",
        "SKALAPOENG.x", "SKALAPOENG.y"
    )]

    # Rename the columns
    names(temp_read) <- c(
        "idper",
        paste0("idsc_", aar[i - 1]), paste0("idsc_", aar[i]),
        paste0("scmu_", aar[i - 1]), paste0("scmu_", aar[i]),
        paste0("types_", aar[i - 1]), paste0("types_", aar[i]),
        paste0("partst_", aar[i - 1]), paste0("partst_", aar[i]),
        paste0("np_read8_", aar[i - 1]),  paste0("np_read9_", aar[i])
    )

    # Recode national test result 0.000 to NA
    temp_read[, 10] <- car::recode(unlist(temp_read[, 10]), "0 = NA")
    temp_read[, 11] <- car::recode(unlist(temp_read[, 11]), "0 = NA")
    # We will impute those NA using MI later.

    ############
    ### Plot ###
    ############

    # Density plots: comparing 2014 and 2015's math results

    plot(density( # Plot pre-test (Year 8) in red
        unlist(temp_math[, 10]), na.rm = TRUE),
        xlim = c(15, 85),
        col = "red",
        xlab = "Scaled National Test Grade",
        ylab = "Kernel Density",
        main = "Density Plot of National Test (Mathematics)"
    )

    par(new = TRUE) # Superimpose the next plot on existing one

    plot(density( # Plot post-test (Year 9) in blue
        unlist(temp_math[, 11]), na.rm = TRUE),
        xlim = c(15, 85),
        col = "blue",
        xaxt = "n", yaxt = "n",
        ann = FALSE
    )

    legend("topleft", # Add a legend to the plot
        legend = c(
            paste0("Year 8 (", aar[i - 1], ")"),
            paste0("Year 9 (", aar[i], ")")
        ),
        col = c("red", "blue"),
        lty = 1,
        cex = 0.8
    )

    # Density plots: comparing 2014 and 2015's reading results

    plot(density(
        unlist(temp_read[, 10]), na.rm = TRUE),
        xlim = c(15, 85),
        col = "red",
        xlab = "Scaled National Test Grade",
        ylab = "Kernel Density",
        main = "Density Plot of National Test (Reading)"
    )

    par(new = TRUE)

    plot(density(
        unlist(temp_read[, 11]), na.rm = TRUE),
        xlim = c(15, 85),
        col = "blue",
        xaxt = "n", yaxt = "n",
        ann = FALSE
    )

    legend("topright",
        legend = c(
            paste0("Year 8 (", aar[i - 1], ")"),
            paste0("Year 9 (", aar[i], ")")
        ),
        col = c("red", "blue"),
        lty = 1,
        cex = 0.8
    )

    # Create a cohort marker
    cohort_math <- rep(aar[i], dim(temp_math)[1])
    cohort_read <- rep(aar[i], dim(temp_read)[1])

    # Create a condition marker
    if (aar[i] == 2020) {
        condition1_math <- rep(1, dim(temp_math)[1])
    } else {
        condition1_math <- rep(0, dim(temp_math)[1])
    }
    if (aar[i] == 2020) {
        condition1_read <- rep(1, dim(temp_read)[1])
    } else {
        condition1_read <- rep(0, dim(temp_read)[1])
    }

    # Save this loop's cohort data to M Drive
    data.table::fwrite(cbind(cohort_math, condition1_math, temp_math),
        paste0("N:/no-backup/COVID/01_math_", aar[i], ".csv"),
        col.names = FALSE # Turn off header
    )
    data.table::fwrite(cbind(cohort_read, condition1_read, temp_read),
        paste0("N:/no-backup/COVID/01_read_", aar[i], ".csv"),
        col.names = FALSE
    )
}
# Conclude PDF plots
dev.off()

# Restore canvas
par(mfrow = c(1,1))

  #                            #  
 ###                          ### 
#####       End script       #####
