#' @title load_pkg
#' @description load_pkg Loads a list of packages. If a package requires installation, the function will install it from CRAN. Function is a CRAN only wrapper.
#' @param packagelist Vector of packages to load into R
#' @import tidyverse
#' @import readr
#' @importFrom utils install.packages installed.packages
#' @examples
#' \donttest{packagelist <- c("purrr", "readr")
#' load_pkg(packagelist)}
#' @return Packages loaded into R
#' @export

load_pkg <- function(packagelist) {

# Function inspiration: http://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them

# Check if any package needs installation:

  PackagesNeedingInstall <- packagelist[!(packagelist %in% installed.packages()[,"Package"])]
  if(length(PackagesNeedingInstall)) install.packages(PackagesNeedingInstall)

# load packages into R:
  for (i in seq_along(packagelist) ) {
    library(packagelist[i], character.only = TRUE)
  }

}
