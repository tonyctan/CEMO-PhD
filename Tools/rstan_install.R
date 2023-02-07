# 0. Remove old packages
remove.packages(c("StanHeaders", "rstan"))
if (file.exists(".RData")) file.remove(".RData")

# 1. Install Rstan
install.packages("V8", dependencies = TRUE)
install.packages(
    c("coda", "mvtnorm", "devtools", "loo", "dagitty", "shape"),
    dependencies = TRUE
)
install.packages("rstan",
    repos = "https://cloud.r-project.org/", dependencies = TRUE
)

# 2. Install CmdStan
install.packages("cmdstanr",
    repos = c("https://mc-stan.org/r-packages/", getOption("repos"))
)
cmdstanr::install_cmdstan(
    dir = NULL,
    cores = getOption("mc.cores", parallel::detectCores()),
    quiet = FALSE,
    overwrite = FALSE,
    timeout = 1200,
    version = NULL,
    release_url = NULL,
    cpp_options = list(),
    check_toolchain = TRUE
)
cmdstanr::set_cmdstan_path(path = "~/.cmdstan/cmdstan-2.31.0")

# 3. Compile packages using all cores
Sys.setenv(MAKEFLAGS = paste0("-j", parallel::detectCores()))
install.packages("rstan",
    repos = c("https://mc-stan.org/r-packages/", getOption("repos"))
)
install.packages("StanHeaders",
    repos = c("https://mc-stan.org/r-packages/", getOption("repos"))
)

# 4. Install rethinking
devtools::install_github("rmcelreath/rethinking")

# 5. Rstanarm
Sys.setenv(MAKEFLAGS = "-j2")
Sys.setenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS" = "true")
remotes::install_github("stan-dev/rstanarm", INSTALL_opts = "--no-multiarch", force = TRUE)




# If fails, try this:
remove.packages("rstan")
if (file.exists(".RData")) file.remove(".RData")
Sys.setenv(DOWNLOAD_STATIC_LIBV8 = 1) # only necessary for Linux without the nodejs library / headers
install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)
# Verify installation
example(stan_model, package = "rstan", run.dontrun = TRUE)
