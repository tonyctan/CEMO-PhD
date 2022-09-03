###### ADMIN INFO ######
# Date: 12 August 2022
# Author: Tony Tan
# Email: tctan@uio.no
# Position: PhD candidate
# Organisation: CEMO, UV, UiO
# Script purpose: Extract teacher-assigned grades

###### DATA PROTECTION ######
# Nature: An R script sourcing Norwegian registry data leading to files
# containing equally sensitive personal info
# Security level (input-script-output): black-green-black
# Computer environment (store-view-edit-execute): any-any-any-TSD

#####      Begin script      #####
 ###                          ### 
  #                            #  

# Point working directory to the COVID folder depending on OS
if (Sys.info()["sysname"] == "Windows") {
    setwd("N:/no-backup/COVID/")
} else {
    setwd("/tsd/p1708/data/no-backup/COVID/")
}
if (interactive()) {getwd()} else {cat(paste0(
    "Working directory is now set to ", getwd(), "\n"
))}

# load data
math3 <- data.table::fread("math3.csv")
read3 <- data.table::fread("read3.csv")

#load packages
library(lme4)
library(jtools)
library(lmerTest)
library(dplyr)

#### begin: temp (has to be deleted when fixed in syntaxes before)
math3$sex <- dplyr::recode(math3$sex, '1' = 0, '2' = 1)
read3$sex <- dplyr::recode(read3$sex, '1' = 0, '2' = 1)

# another achiver variable (same group size)
# z=0.431
50-0.431*10
50+0.431*10
math3$ach_lo_n <- (math3$np_math8 < 45.69) + 0
math3$ach_hi_n <- (math3$np_math8 > 54.31) + 0
read3$ach_lo_n <- (read3$np_read8 < 45.69) + 0
read3$ach_hi_n <- (read3$np_read8 > 54.31) + 0

# Create another cohort marker
math3$condition_3 <- ifelse(math3$cohort == 2015, 0, NA)
math3$condition_3 <- ifelse(math3$cohort == 2016, 1, math3$condition_3)
math3_3 <- dplyr::filter(math3, !is.na(math3$condition_3))
math3$condition_4 <- ifelse(math3$cohort == 2016, 0, NA)
math3$condition_4 <- ifelse(math3$cohort == 2017, 1, math3$condition_4)
math3_4 <- dplyr::filter(math3, !is.na(math3$condition_4))
math3$condition_5 <- ifelse(math3$cohort == 2017, 0, NA)
math3$condition_5 <- ifelse(math3$cohort == 2018, 1, math3$condition_5)
math3_5 <- dplyr::filter(math3, !is.na(math3$condition_5))
math3$condition_6 <- ifelse(math3$cohort == 2018, 0, NA)
math3$condition_6 <- ifelse(math3$cohort == 2019, 1, math3$condition_6)
math3_6 <- dplyr::filter(math3, !is.na(math3$condition_6))
math3$condition_7 <- ifelse(math3$cohort == 2019, 0, NA)
math3$condition_7 <- ifelse(math3$cohort == 2020, 1, math3$condition_7)
math3_7 <- dplyr::filter(math3, !is.na(math3$condition_7))

read3$condition_3 <- ifelse(read3$cohort == 2015, 0, NA)
read3$condition_3 <- ifelse(read3$cohort == 2016, 1, read3$condition_3)
read3_3 <- dplyr::filter(read3, !is.na(read3$condition_3))
read3$condition_4 <- ifelse(read3$cohort == 2016, 0, NA)
read3$condition_4 <- ifelse(read3$cohort == 2017, 1, read3$condition_4)
read3_4 <- dplyr::filter(read3, !is.na(read3$condition_4))
read3$condition_5 <- ifelse(read3$cohort == 2017, 0, NA)
read3$condition_5 <- ifelse(read3$cohort == 2018, 1, read3$condition_5)
read3_5 <- dplyr::filter(read3, !is.na(read3$condition_5))
read3$condition_6 <- ifelse(read3$cohort == 2018, 0, NA)
read3$condition_6 <- ifelse(read3$cohort == 2019, 1, read3$condition_6)
read3_6 <- dplyr::filter(read3, !is.na(read3$condition_6))
read3$condition_7 <- ifelse(read3$cohort == 2019, 0, NA)
read3$condition_7 <- ifelse(read3$cohort == 2020, 1, read3$condition_7)
read3_7 <- dplyr::filter(read3, !is.na(read3$condition_7))

#### end: temp (has to be deleted when fixed in syntaxes before)
################################################################################
# equal trend assumption

# math
# ETA1 comparing cohort 2016 with cohort 2015
ETA1 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition_3 +
    (1|idsc9),
data = math3_3,
REML = F
)
summary(ETA1)
jtools::summ(ETA1)
lmerTest::ranova(ETA1)

# ETA2 comparing cohort 2017 with cohort 2016
ETA2 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition_4 +
    (1|idsc9),
data = math3_4,
REML = F
)
summary(ETA2)
jtools::summ(ETA2)
lmerTest::ranova(ETA2)
# condition_4 (B = 0.21, p < 0.001)

# ETA3 comparing cohort 2018 with cohort 2017
ETA3 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition_5 +
    (1|idsc9),
data = math3_5,
REML = F
)
summary(ETA3)
jtools::summ(ETA3)
lmerTest::ranova(ETA3)
# condition_5 (B = -0.14, p < 0.001)

# ETA4 comparing cohort 2019 with cohort 2018
ETA4 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition_6 +
    (1|idsc9),
data = math3_6,
REML = F
)
summary(ETA4)
jtools::summ(ETA4)
lmerTest::ranova(ETA4)
# condition_6 (B = -0.11, p < 0.001)

# ETA5 comparing cohort 2019 with cohort 2018
ETA5 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition_7 +
    (1|idsc9),
data = math3_7,
REML = F
)
summary(ETA5)
jtools::summ(ETA5)
lmerTest::ranova(ETA5)
# condition_7 (B = -0.11, p < 0.001)

# read
# ETA1 comparing cohort 2016 with cohort 2015
ETA1 <- lme4::lmer(I(np_read9-np_read8) ~ 1 +
    condition_3 +
    (1|idsc9),
data = read3_3,
REML = F
)
summary(ETA1)
jtools::summ(ETA1)
lmerTest::ranova(ETA1)
# condition_3 (B = 0.88 p < 0.001)

# ETA2 comparing cohort 2017 with cohort 2016
ETA2 <- lme4::lmer(I(np_read9-np_read8) ~ 1 +
    condition_4 +
    (1|idsc9),
data = read3_4,
REML = F
)
summary(ETA2)
jtools::summ(ETA2)
lmerTest::ranova(ETA2)
# condition_4 (B = 0.32, p < 0.001)

# ETA3 comparing cohort 2018 with cohort 2017
ETA3 <- lme4::lmer(I(np_read9-np_read8) ~ 1 +
    condition_5 +
    (1|idsc9),
data = read3_5,
REML = F
)
summary(ETA3)
jtools::summ(ETA3)
lmerTest::ranova(ETA3)
# condition_5 (B = -0.43, p < 0.001)

# ETA4 comparing cohort 2019 with cohort 2018
ETA4 <- lme4::lmer(I(np_read9-np_read8) ~ 1 +
    condition_6 +
    (1|idsc9),
data = read3_6,
REML = F
)
summary(ETA4)
jtools::summ(ETA4)
lmerTest::ranova(ETA4)
# condition_6 (B = 0.27, p < 0.001)

################################################################################
# math
# single-level (SL) models
# M0 intercept only model (i.e., without independent variables and covariates)
SLMM0 <- lm(I(np_math9-np_math8) ~ 1,
data = math3
)
summary(SLMM0)
jtools::summ(SLMM0)
summary(SLMM0)[8]

# M1 model without covariates
SLMM1 <- lm(I(np_math9-np_math8) ~ condition1,
data = math3
)
summary(SLMM1)
jtools::summ(SLMM1)
summary(SLMM1)[8]

# M2 model without covariates
SLMM2 <- lm(I(np_math9-np_math8) ~ condition1 +                     #IV
    sex + age + atipcu_scale + ach_lo + ach_hi +                    #covariates
    atipcu_scale*condition1 + ach_lo*condition1 + ach_hi*condition1,#interaction
data = math3
)
summary(SLMM2)
jtools::summ(SLMM2)
summary(SLMM2)[8]

#read
# single-level (SL) models
# M0 intercept only model (i.e., without independent variables and covariates)
SLRM0 <- lm(I(np_read9-np_read8) ~ 1,
data = read3
)
summary(SLRM0)
jtools::summ(SLRM0)
summary(SLRM0)[8]

# M1 model without covariates
SLRM1 <- lm(I(np_read9-np_read8) ~ condition1,
data = read3
)
summary(SLRM1)
jtools::summ(SLRM1)
summary(SLRM1)[8]

# M2 model with covariates
SLRM2 <- lm(I(np_read9-np_read8) ~ condition1 +                     #IV
    sex + age + atipcu_scale + ach_lo + ach_hi +                    #covariates
    atipcu_scale*condition1 + ach_lo*condition1 + ach_hi*condition1,#interaction
data = read3
)
summary(SLRM2)
jtools::summ(SLRM2)
summary(SLRM2)[8]

################################################################################
# centering
# centering around the grand mean (grand mean centering = GMC)
# centering around the person’s mean (also known as centering within clusters = CWC)

math8$age_cwc <- misty::center(math$age,
    type = "CWC",
    cluster = "idsc9",
    check = T
)

# function for standardized coefficients
lm.beta.lmer <- function(object) {
    b <- fixef(object)[-1]
    sdx <- apply(getME(object, "X")[,-1],2,sd)
    sdy <- sd(getME(object, "Y"))
    b*sdx/sdy
}


# multi-level (ML) models without dur as Level 2 predictor
# math
# M0 random intercept only model
MLMM0 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    (1|idsc9),
data = math3,
REML = F #maximum likelihood estimation used
)
summary(MLMM0)
jtools::summ(MLMM0) # inspect if intercepts is statistically significant different from 0 and see ICC
lmerTest::ranova(MLMM0) # test if variation in intercepts between level2 entities are statistically significant

# M1 model without covariates
MLMM1 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition1 +
    (1|idsc9),
data = math3,
REML = F
)
summary(MLMM1)
jtools::summ(MLMM1)
lmerTest::ranova(MLMM1)

# M2 model with covariates but without interaction
MLMM2 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition1 +                                                    #IV
    sex + atipcu_scale + ach_lo_n + ach_hi_n +                #covariates
    (1 |idsc9),                                                     #random part
data = math3,
REML = F
)
summary(MLMM2)
jtools::summ(MLMM2)
lmerTest::ranova(MLMM2)
# Model failed to converge with max|grad| = 0.0398825 (tol = 0.002, component 1)

# M3 model with covariates with interaction
MLMM3 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition1 +                                                    #IV
    sex + atipcu_scale + ach_lo_n + ach_hi_n +                      #covariates
    atipcu_scale*condition1 + ach_lo_n*condition1 + ach_hi_n*condition1 + #interaction
    (1 |idsc9),                                                     #random part
data = math3,
REML = F
)
summary(MLMM3)
jtools::summ(MLMM3)
lmerTest::ranova(MLMM3)










# cross classified multi-level model: idsc8 and idsc9
# random intercept and random slope model

# group mean centering of atipcu (SES), ach_lo (low achiever), and ach_hi (high achiever) using dplyr
math3 %>%
    add_rownames() %>%
    group_by(math3$idsc9) %>%
    mutate(math3$atipcu_pos.cent = math3$atipcu_pos-mean(math3$atipcu_pos))[,"atipcs_pos.cent"]

# math
# comparison 2020 and 2019 cohort
# M0 random intercept only model
MLMM0 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    (1|idsc8) +
    (1|idsc9),
data = math3_7,
REML = F #maximum likelihood estimation used
)
summary(MLMM0)
# ICC (idsc8) = 0.1305/(0.1305+0.4332+26.2516) = 0.004866625
# ICC (idsc9) = 0.4332/(0.1305+0.4332+26.2516) = 0.01615496
# ICC (both)  = 0.1305+0.4332/(0.1305+0.4332+26.2516) = 0.146655
jtools::summ(MLMM0) # inspect if intercepts is statistically significant different from 0 and see ICC
lmerTest::ranova(MLMM0) # test if variation in intercepts between level2 entities are statistically significant

# M1 model without covariates
MLMM1 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition_7 +
    (1|idsc9),
data = math3_7,
REML = F
)
summary(MLMM1)
jtools::summ(MLMM1)
lmerTest::ranova(MLMM1)

# LR-test for condition_7
anova(MLMM0, MLMM1)
# Taking the condition_7 into account leads to a statistically significant improvement of the model: Chi^2 = 12.447, df = 1, p < .001

# M2 model with covariates but without interaction
MLMM2 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition_7 +                                                    #IV
    sex + atipcu_scale + ach_lo_n + ach_hi_n +                #covariates
    (1 |idsc9),                                                     #random part
data = math3_7,
REML = F
)
summary(MLMM2)
jtools::summ(MLMM2)
lmerTest::ranova(MLMM2)

# M3 model with covariates with interaction
MLMM3 <- lme4::lmer(I(np_math9-np_math8) ~ 1 +
    condition_7 +                                                    #IV
    sex + atipcu_scale + ach_lo_n + ach_hi_n +                      #covariates
    atipcu_scale*condition_7 + ach_lo_n*condition_7 + ach_hi_n*condition_7 + #interaction
    (1 |idsc9),                                                     #random part
data = math3_7,
REML = F
)
summary(MLMM3)
jtools::summ(MLMM3)
lmerTest::ranova(MLMM3)


# read
# M0 random intercept only model
MLRM0 <- lme4::lmer(I(np_read9-np_read8) ~ 1 +
    (1|idsc9),
data = read3_7,
REML = F #maximum likelihood estimation used
)
summary(MLRM0)
jtools::summ(MLRM0) # inspect if intercepts is statistically significant different from 0 and see ICC
lmerTest::ranova(MLRM0) # test if variation in intercepts between level2 entities are statistically significant

# M1 model without covariates
MLRM1 <- lme4::lmer(I(np_read9-np_read8) ~ 1 +
    condition_7 +
    (1|idsc9),
data = read3_7,
REML = F
)
summary(MLRM1)
jtools::summ(MLRM1)
lmerTest::ranova(MLRM1)

# M2 model with covariates but without interaction
MLRM2 <- lme4::lmer(I(np_read9-np_read8) ~ 1 +
    condition_7 +                                                    #IV
    sex + atipcu_scale + ach_lo_n + ach_hi_n +                #covariates
    (1 |idsc9),                                                     #random part
data = read3_7,
REML = F
)
summary(MLRM2)
jtools::summ(MLRM2)
lmerTest::ranova(MLRM2)

# M3 model with covariates with interaction
MLRM3 <- lme4::lmer(I(np_read9-np_read8) ~ 1 +
    condition_7 +                                                    #IV
    sex + atipcu_scale + ach_lo_n + ach_hi_n +                      #covariates
    atipcu_scale*condition_7 + ach_lo_n*condition_7 + ach_hi_n*condition_7 + #interaction
    (1 |idsc9),                                                     #random part
data = read3_7,
REML = F
)
summary(MLRM3)
jtools::summ(MLRM3)
lmerTest::ranova(MLRM3)




# random intercept and random slope model without cross-level interactions
MLMM1 <- lme4::lmer(DV ~ 1 +
                        sex + age + antipcu + achiever +
                        (1+antipcu+achiever|scid),
data = data,
REML = F #maximum likelihood estimation used
)
summary(MLMM1)
jtools::summ(MLMM1)
lmerTest::ranova(MLMM1)

#random intercept and random slope model with cross-level interactions
MLMM2 <- lme4::lmer(DV ~ 1 +
                        sex + age + antipcu + achiever +
                        antipcu*cohort + achiever*cohort +
                        (1+antipcu+achiever|scid),
data = data,
REML = F #maximum likelihood estimation used
)
summary(MLMM2)
jtools::summ(MLMM2)
lmerTest::ranova(MLMM2)

#read

################################################################################


#multi-level (ML) models with Level 2 predictors
MLM0 <- lme4::lmer(np_math ~ 1 + (1|scid),
data = data,
REML = F #maximum likelihood estimation used
)
summary(M0)
jtools::summ(M0) # inspect if intercepts is statistically significant different from 0 and see ICC
lmerTest::ranova(M0) # test if variation in intercepts between level2 entities are statistically significant

#random intercept and random slope model without Level 2 predictor
MLM1 <- lme4::lmer(np_math ~ 1  +
                                sex + age + antipcu + achiever +
                                (1 + antipcu + achiever|scid),
data = data,
REML = F
)
summary(MLM1)
jtools::summ(MLM1)
lmerTest::ranova(MLM1)

#random intercept and random slope model wit Level 2 predictor
MLM2 <- lme4::lmer(np_math ~ 1  +
                                sex + age + antipcu + achiever + dur +
                                antipcu*dur + achiever*dur +
                                (1 + antipcu + achiever|scid),
data = data,
REML = F
)
summary(MLM2)
jtools::summ(MLM2)
lmerTest::ranova(MLM2)

#recalculate effect size
#https://www.escal.site




################################################################################
# repeat analyses with comparison of 2019 and 2020 cohort
math3_reduced <- math3[which(cohort == "2019" | cohort == "2020"),]
read3_reduced <- read3[which(cohort == "2019" | cohort == "2020"),]

################################################################################
# math
# single-level (SL) models
# M0 intercept only model (i.e., without independent variables and covariates)
SLMM0_red <- lm(I(np_math9-np_math8) ~ 1,
data = math3_reduced
)
summary(SLMM0_red)
jtools::summ(SLMM0_red)
summary(SLMM0_red)[8]

# M1 model without covariates
SLMM1_red <- lm(I(np_math9-np_math8) ~ condition1,
data = math3_reduced
)
summary(SLMM1_red)
jtools::summ(SLMM1_red)
summary(SLMM1_red)[8]

# M2 model without covariates
SLMM2_red <- lm(I(np_math9-np_math8) ~ condition1 +                     #IV
    sex + age + atipcu_scale + ach_lo + ach_hi +                    #covariates
    atipcu_scale*condition1 + ach_lo*condition1 + ach_hi*condition1,#interaction
data = math3_reduced
)
summary(SLMM2_red)
jtools::summ(SLMM2_red)
summary(SLMM2_red)[8]

#read
# single-level (SL) models
# M0 intercept only model (i.e., without independent variables and covariates)
SLRM0_red <- lm(I(np_read9-np_read8) ~ 1,
data = read3
)
summary(SLRM0_red)
jtools::summ(SLRM0_red)
summary(SLRM0_red)[8]

# M1 model without covariates
SLRM1_red <- lm(I(np_read9-np_read8) ~ condition1,
data = read3_reduced
)
summary(SLRM1_red)
jtools::summ(SLRM1_red)
summary(SLRM1_red)[8]

# M2 model with covariates
SLRM2_red <- lm(I(np_read9-np_read8) ~ condition1 +                     #IV
    sex + age + atipcu_scale + ach_lo + ach_hi +                    #covariates
    atipcu_scale*condition1 + ach_lo*condition1 + ach_hi*condition1,#interaction
data = read3_reduced
)
summary(SLRM2_red)
jtools::summ(SLRM2_red)
summary(SLRM2_red)[8]

################################################################################


  #                            #  
 ###                          ### 
#####       End script       #####
