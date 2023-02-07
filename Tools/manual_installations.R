wget http://gis-bigdata.uni-muenster.de/pebesma/src/contrib/starsdata_0.0-1.tar.gz
R CMD INSTALL starsdata_0.0-1.tar.gz

wget https://cran.r-project.org/contrib/main/00Archive/RandomFieldsUtils/RandomFieldsUtils_1.2.5.tar.gz
R CMD INSTALL RandomFieldsUtils_1.2.5.tar.gz
wget https://cran.r-project.org/src/contrib/Archive/RandomFields/RandomFields_3.3.14.tar.gz
R CMD INSTALL RandomFields_3.3.14.tar.gz

wget https://cran.r-project.org/src/contrib/Archive/graph/graph_1.30.0.tar.gz
R CMD INSTALL graph_1.30.0.tar.gz

wget https://cran.r-project.org/src/contrib/Archive/openNLPmodels.en/openNLPmodels.en_0.0-4.tar.gz
R CMD INSTALL openNLPmodels.en_0.0-4.tar.gz

wget https://cran.r-project.org/src/contrib/Archive/RClone/RClone_1.0.3.tar.gz
R CMD INSTALL RClone_1.0.3.tar.gz

devtools::install_github("geocompr/geocompkg")
devtools::install_github("josherrickson/rrelaxiv@*release")

BiocManager::install("Rgraphviz")
BiocManager::install("rhdf5")
BiocManager::install("M3C")
BiocManager::install("snpStats")
BiocManager::install("globaltest")
BiocManager::install("Biostrings")
BiocManager::install("Biobase")
BiocManager::install("seqLogo")

install.packages("starsdata", repos = "http://gis-bigdata.uni-muenster.de/pebesma", type = "source") 

################
# Windows Only #
################

# Install RDCOMClient
install.packages("RDCOMClient", repos = "http://www.omegahat.net/R", type = "win.binary")
# Install rcom
options(install.packages.check.source = "no")
install.packages(
    c("rscproxy","rcom"),
    repos="http://www.autstat.com/download",
    lib=.Library,type="win.binary"
)
library(rcom)
installstatconnDCOM()
comRegisterRegistry()
# Install R2wd
install.packages("R2wd",dependencies)
