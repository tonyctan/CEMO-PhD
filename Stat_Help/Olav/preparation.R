##### Step 0: Read in Norwegian PIAAC data #####
library(Orcs) # Set working directory depending on the operating system
setwdOS(lin = "~/uio/", win = "M:/", ext = "pc/Dokumenter/PhD/Stat_Help/Olav/")
piaac <- read.csv("prgnorp1.csv")


##### Step 1: Inspect dataset #####
dim(piaac)


##### Step 2: Inspect variables #####
hist(piaac$EARNMTHBONUS) # Received error message
table(unlist(piaac$EARNMTHBONUS)) # Any missings?
# Mark "" (empty cells) as missings [196]
# Mark "V" (Valid skip) as missings [1305]
# Mark "1" (1 kr as monthly income?! Seriously!) as missing [1]


hist(piaac$AGE_R) # No missing. Keep as it is.

hist(piaac$GENDER_R) # No missing. But transform it to (0,1) coding.

hist(piaac$IMGEN) # Received error message
table(unlist(piaac$IMGEN)) # Inspect missings:
# Mark "" (empty cells) as missings [175]
# Mark "A" (Non-immigrant and one foreign-born parent) as missings [213]
# Mark "N" (Not stated or inferred) as missings [12]

hist(piaac$YRSQUAL_T) # Received error message
table(unlist(piaac$YRSQUAL_T))
# Mark "" (blank cell) as missing [175]
# Mark "D" (codebook didn't say what this code stands for) as missing [1]
# Mark "N" (Not stated or inferred) as missing [1]


##### Step 3: Trim dataset ####
names(piaac) # Obtain each variable's column position
piaac_lean <- piaac[ , c(
# Outcome variable
    1298, # EARNMTHBONUS: Monthly earnings including bonuses for wage and salary earners (derived)
# Input variables
    1159:1168, # Literacy
    1170:1179, # Numeracy
    1181:1190, # Problem-solving skills
# Control variables
    5, # GENDER_R: Person resolved gender from BQ and QC check (derived)
    4, # AGE_R: Person resolved age from BQ and QC check (derived)
    403, # IMGEN: First and second generation immigrants (derived)
    386, # YRSQUAL_T: Highest level of education obtained imputed into years of education (derived)
    1198:1200 # PIAAC complex design variables
)]
head(piaac_lean, 3)


##### Step 4: Mark missing values as -99 #####
library(car)

# Step 4.1: Recode outcome variable
piaac_lean$EARNMTHBONUS <- recode(piaac_lean$EARNMTHBONUS, "
    c('','V', '1') = '-99'
")
hist(piaac_lean$EARNMTHBONUS)
# Too skewed. Log transform:
for (i in 1:dim(piaac_lean)[1]) {
    if (piaac_lean$EARNMTHBONUS[i] > 0) {
        piaac_lean$log_EARN[i] <- log(piaac_lean$EARNMTHBONUS[i])
    } else {
        piaac_lean$log_EARN[i] <- -99
    }
}

# Step 4.2: Recode input variables
names(piaac_lean) # First PV in column 2, last in column 31
for (j in 2:31) {
    piaac_lean[ , j] <- recode(piaac_lean[ , j], "
        NA = '-99'
    ")
}

# Step 4.3: Recode control variables

# Recode GENDER_R into MALE (female = 0, male = 1)
piaac_lean$MALE <- (piaac_lean$GENDER_R - 2) * (-1)

# Rename AGE_R into AGE
piaac_lean$AGE <- piaac_lean$AGE_R
# Centre AGE (call it cAGE)
piaac_lean$cAGE <- piaac_lean$AGE - mean(piaac_lean$AGE)
# Square cAGE (call it cAGEsq)
piaac_lean$cAGEsq <- (piaac_lean$cAGE)^2

# Recode missings in immigration status (IMGEN)
piaac_lean$IMGEN <- recode(piaac_lean$IMGEN, "
    c('','A', 'N') = '-99'
")
table(unlist(piaac_lean$IMGEN)) # Good.

# Recode IMGEN into 1st and 2nd generation migrant
IM1 <- piaac_lean$IMGEN == 1 # Generate T/F responses
piaac_lean$IM1 <- IM1 + 0 # Turn T/F into 1/0

IM2 <- piaac_lean$IMGEN == 2 # Generate T/F responses
piaac_lean$IM2 <- IM2 + 0 # Turn T/F into 1/0

# Recode missings in years of education (YRSQUAL_T)
piaac_lean$EDU <- recode(piaac_lean$YRSQUAL_T, "
    c('','N', 'D') = '-99'
")
table(unlist(piaac_lean$EDU)) # Good.

# Center EDU (call it cEDU)
EDUdist <- data.frame(table(unlist(piaac_lean$EDU)))[-1, ] # Remove -99 entries
EDUyears <- as.numeric(as.matrix(EDUdist[, 1])) # Save possible EDUyears
EDUcount <- as.numeric(as.matrix(EDUdist[, 2])) # Save counts of each EDUyear
mEDU <- EDUyears %*% EDUcount / sum(EDUcount) # Compute dot product, then divide by total count. (That is, I am calculating mean years of EDU)
for (i in 1:dim(piaac_lean)[1]) {
    if (piaac_lean$EDU[i] > 0) {
        piaac_lean$cEDU[i] <- piaac_lean$EDU[i] - mEDU
    } else {
        piaac_lean$cEDU[i] <- -99
    }
}
# Compare count table before and after centring
table(unlist(piaac_lean$EDU))
table(unlist(piaac_lean$cEDU))
# Good. I did not mess up the distribution. Now I can square it
for (i in 1:dim(piaac_lean)[1]) {
    if (piaac_lean$cEDU[i] > -90) {
        piaac_lean$cEDUsq[i] <- (piaac_lean$cEDU[i])^2
    } else {
        piaac_lean$cEDUsq[i] <- -99
    }
}
# Have a look at the count table of the squared-centred version of EDU
table(unlist(piaac_lean$cEDUsq))
# Good!

# Lastly, create a cAGE x MALE interaction term (in order to answer 4(b))
piaac_lean$cross <- piaac_lean$cAGE * piaac_lean$MALE

# Have a look at the spreadsheet once more
head(piaac_lean, 3)


# Step 5: Re-arrange into a clean dataset
names(piaac_lean)
piaac_export <- piaac_lean[ , c(
    39,     # log_EARN
    2:11,   # Literacy
    12:21,  # Numeracy
    22:31,  # Problem-solving
    40,     # MALE
    42,     # cAGE (Always use the centred version)
    43,     # cAGEsq
    44,     # 1st generation migrant
    45,     # 2nd generation migrant
    47,     # cEDU (Always use the centred version)
    48,     # cEDUsq
    49,     # Interaction between cAGE and MALE
    36:38   # PIAAC complex design variables
)]
head(piaac_export, 3)

# Step 6: Split dataset by plausible values
names(piaac_export)
piaac1 <- piaac_export[ , c(1,2,12,22,32:42)]
head(piaac1, 3) # Looks good

piaac2 <- piaac_export[ , c(1,3,13,23,32:42)]
piaac3 <- piaac_export[ , c(1,4,14,24,32:42)]
piaac4 <- piaac_export[ , c(1,5,15,25,32:42)]
piaac5 <- piaac_export[ , c(1,6,16,26,32:42)]
piaac6 <- piaac_export[ , c(1,7,17,27,32:42)]
piaac7 <- piaac_export[ , c(1,8,18,28,32:42)]
piaac8 <- piaac_export[ , c(1,9,19,29,32:42)]
piaac9 <- piaac_export[ , c(1,10,20,30,32:42)]
piaac10 <- piaac_export[ , c(1,11,21,31,32:42)]

# Make sure to end the line with Windows convention (eol="\n")
write.table(piaac1, "piaac1.dat", row.names = F, col.names = F, eol="\n")
write.table(piaac2, "piaac2.dat", row.names = F, col.names = F, eol="\n")
write.table(piaac3, "piaac3.dat", row.names = F, col.names = F, eol="\n")
write.table(piaac4, "piaac4.dat", row.names = F, col.names = F, eol="\n")
write.table(piaac5, "piaac5.dat", row.names = F, col.names = F, eol="\n")
write.table(piaac6, "piaac6.dat", row.names = F, col.names = F, eol="\n")
write.table(piaac7, "piaac7.dat", row.names = F, col.names = F, eol="\n")
write.table(piaac8, "piaac8.dat", row.names = F, col.names = F, eol="\n")
write.table(piaac9, "piaac9.dat", row.names = F, col.names = F, eol="\n")
write.table(piaac10, "piaac10.dat", row.names = F, col.names = F, eol="\n")
