## Causal Inference Workshop 2022
## Session 4: Regression Models

# Set working directory depending on operating system
Orcs::setwdOS(
       lin = "~/uio/", win = "M:/",
       ext = "pc/Dokumenter/PhD/Teaching/MAE4051_Causal_Inference/Materials from Previous years/MAE4051H22_4_Regression/"
)

## STEP 1: Load data (PIRLS 2016 Germany)

# Install R package "EdSurvey" if not yet done so
# install.packages("EdSurvey", dependencies = T)
# Load "EdSurvey" package
library("EdSurvey")
# Suppress warnings for the rest of this R session
options(warn = - 1)

#             ### [RESEARCHERS NEED TO PREPARE PIRLS DATASET] ###

# Download 2016 PIRLS data from the IEA website
downloadPIRLS(
       root = getwd(), # Download data to the current working directory
       year = 2016
)
# Read Germany's 2016 PIRLS data into R
PIRLS2016DEU <- readPIRLS(
       path = paste0(getwd(),"/PIRLS/2016/"),
       countries = c("deu")
)
# Save Germany's data to .RData format for future use
save(PIRLS2016DEU, file = "PIRLS2016DEU.RData")


#             ### [LEARNERS ONLY NEED TO LOAD PIRLS DATASET] ###
# Read Germany's 2016 PIRLS data into R
load("PIRLS2016DEU.RData")





## STEP 2: Identify variables of interest
View(showCodebook(PIRLS2016DEU))

# Outcome: Reading achievement in Grade 4
showPlausibleValues(PIRLS2016DEU)
# "rrea" = 5 plausible values for overall reading
summary2(PIRLS2016DEU, variable = c("rrea"), weightVar = c("totwgt"))

# Treatment: Preschool attendance
summary2(PIRLS2016DEU, variable = c("asdhaps"), weightVar = c("totwgt"))

# Merge rare categories into a binary treatment variable
PIRLS2016DEUrec <- recode.sdf(PIRLS2016DEU,
       recode = list(
              asdhaps = list(
                     from = c(
                            "DID NOT ATTEND",
                            "1 YEAR OR LESS",
                            "2 YEARS"
                     ),
                     to = c("LESS THAN 3 YEARS")
              ),
              asdhaps = list(
                     from = c("OMITTED OR INVALID"),
                     to = NaN
              )
       )
)
summary2(PIRLS2016DEUrec, variable = c("asdhaps"), weightVar = c("totwgt"))

# Control variables:

# Highest parental education level (merge categories)
summary2(PIRLS2016DEUrec, variable = c("asdhedup"), weightVar = c("totwgt"))
PIRLS2016DEUrec <- recode.sdf(PIRLS2016DEUrec,
       recode = list(
              asdhedup = list(
                     from = c(
                            "POST-SECONDARY BUT NOT UNIVERSITY",
                            "UPPER SECONDARY",
                            "LOWER SECONDARY",
                            "SOME PRIMARY, LOWER SECONDARY OR NO SCHOOL"
                     ),
                     to = c("LOWER THAN UNIVERSITY")
              ),
              asdhedup = list(
                     from = c("OMITTED OR INVALID"),
                     to = NaN
              )
       )
)
summary2(PIRLS2016DEUrec, variable = c("asdhedup"), weightVar = c("totwgt"))

# Number of books at home (merge categories)
summary2(PIRLS2016DEUrec, variable = c("asbg04"), weightVar = c("totwgt"))
PIRLS2016DEUrec <- recode.sdf(PIRLS2016DEUrec,
       recode = list(
              asbg04 = list(
                     from = c(
                            "NONE OR VERY FEW (0-10 BOOKS)",
                            "ENOUGH TO FILL ONE SHELF (11-25 BOOKS)",
                            "ENOUGH TO FILL ONE BOOKCASE (26-100 BOOKS)"
                     ),
                     to = c("UP TO 100 BOOKS")
              ),
              asbg04 = list(
                     from = c(
                            "ENOUGH TO FILL TWO BOOKCASES (101-200 BOOKS)",
                            "ENOUGH TO FILL THREE OR MORE BOOKCASES (MORE THAN 200)"
                     ),
                     to = c("MORE THAN 100 BOOKS")
              ),
              asbg04 = list(
                     from = c("OMITTED OR INVALID"),
                     to = NaN
              )
       )
)
summary2(PIRLS2016DEUrec, variable = c("asbg04"), weightVar = c("totwgt"))

# Speaking German at home (Merge categories)
summary2(PIRLS2016DEUrec, variable = c("asbg03"), weightVar = c("totwgt"))
PIRLS2016DEUrec <- recode.sdf(PIRLS2016DEUrec,
       recode = list(
              asbg03 = list(
                     from = c("I ALWAYS SPEAK <LANGUAGE OF TEST> AT HOME"),
                     to = c("ALWAYS GERMAN")
              ),
              asbg03 = list(
                     from = c(
                            "I ALMOST ALWAYS SPEAK <LANGUAGE OF TEST> AT HOME",
                            "I SOMETIMES SPEAK <LANGUAGE OF TEST> AND SOMETIMES SPEAK ANOTHER LANGUAGE AT HOME",
                            "I NEVER SPEAK <LANGUAGE OF TEST> AT HOME"
                     ),
                     to = c("NOT (ALWAYS) GERMAN")
              ),
              asbg03 = list(
                     from = c("OMITTED OR INVALID"),
                     to = NaN
              )
       )
)
summary2(PIRLS2016DEUrec, variable = c("asbg03"), weightVar = c("totwgt"))





## STEP 3: Compare treatment and control groups in terms of control variables
# (Balance check)

# Parental education
summary2(
       PIRLS2016DEUrec,
       variable = c("asdhaps", "asdhedup"), weightVar = c("totwgt")
)
# OBSERVATION: Children with 3 years or more preschool attendance have,
# on average, more educated parents.

# Books at home
summary2(
       PIRLS2016DEUrec,
       variable = c("asdhaps", "asbg04"), weightVar = c("totwgt")
)
# OBSERVATION: Children with 3 years or more preschool attendance have,
# on average, more books at home.

# Speaking German at home
summary2(
       PIRLS2016DEUrec,
       variable = c("asdhaps", "asbg03"), weightVar = c("totwgt")
)
# OBSERVATION: Children with 3 years or more preschool attendance more often
# always speak German at home.





## STEP 4: Stepwise regressions

# Regression of reading achievement on preschool variable, no control variables
summary(lm.sdf(
       rrea ~ asdhaps,
       data = PIRLS2016DEUrec, weightVar = c("totwgt")
))
# OBSERVATION: Children with less than 3 years of preschool attendance
# score approximately 20 points lower (p < .001).

# Regression of reading achievement on preschool variable,
# controlling for parental education
summary(lm.sdf(
       rrea ~ asdhaps + asdhedup,
       data = PIRLS2016DEUrec, weightVar = c("totwgt")
))
# OBSERVATION: After controlling for parental education,
# children with less than 3 years of preschool attendance
# score only approximately 15 points lower (p < .001).

# Regression of reading achievement on preschool variable,
# controlling for parental education, and number of books at home
summary(lm.sdf(
       rrea ~ asdhaps + asdhedup + asbg04,
       data = PIRLS2016DEUrec, weightVar = c("totwgt")
))
# OBSERVATION: After controlling for both parental education and
# number of books at home, children with less than 3 years of preschool
# attendance score only approximately 10 points lower (p < .01).

# Regression of reading achievement on preschool variable,
# controlling for parental education, number of books at home, and
# language at home
summary(lm.sdf(
       rrea ~ asdhaps + asdhedup + asbg04 + asbg03,
       data = PIRLS2016DEUrec, weightVar = c("totwgt")
))
# OBSERVATION: After controlling for parental education, number of books
# at home, and language at home, children with less than 3 years of preschool
# attendance score only approximately 8 points lower (p < .01).


# OVERALL OBSERVATION:
# After including only three binary control variables,
# the 20-point reading advantage of children with at least 3 years of
# preschool attendance decreases to 8 points.


## What if we include more or other control variables?
## What if we specify treatment variable differently?
