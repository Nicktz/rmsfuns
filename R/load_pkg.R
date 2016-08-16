#' @title load_pkg
#' @description load_pkg Loads a list of packages. If a package requires installation, the function will install it from CRAN.
#' @param packagelist Vector of packages to load into R
#' @examples load_pkg(c("ggplot2", "dplyr"))
#' @return Packages loaded into R
#' @export

load_pkg <- function(packagelist) {

# Function inspiration: http://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them

# Check if any package needs installation:
  PackagesNeedingInstall <- packagelist[!(packagelist %in% installed.packages()[,"Package"])]
  if(length(PackagesNeedingInstall)) install.packages(PackagesNeedingInstall)

# load packages into R:
  # load packages into R:
  lapply(packagelist, library, character.only = TRUE, quietly = T)

}
