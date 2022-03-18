# Remember to install these packages first:
# sudo apt-get install cargo
# sudo apt-get install jags

# Install glmmADMB
install.packages("R2admb")
install.packages("glmmADMB",
    repos=c("http://glmmadmb.r-forge.r-project.org/repos", getOption("repos")),
    type="source"
)

# Install packages required by Bayes Rules!
install.packages(c("bayesrules","tidyverse","janitor","rstanarm","bayesplot","tidybayes","broom.mixed","modelr","e1071","forcats"),dependencies = T)

# Every time when Rstan is called in:
library("rstan")
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

# Run an example
example(stan_model, package = "rstan", run.dontrun = TRUE)
