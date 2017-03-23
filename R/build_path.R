#' @title build_path
#' @description build_path builds the entire folder FilePath provided. If the FilePath does not exist, it builds it without error. It is effectively a user-friendly wrapper to the base function dir.create.
#' @param FilePath A character string/vector or list object with the target folder path
#' @param Silent True by default, if set to FALSE it shows the address of the folder just created.
#' @return Path address just built.
#' @examples
#' build_path("C:/Temp/data")
#' build_path(paste0("C:/Temp/", c("data", "img", "output")))
#' build_path(paste0("C:/Temp/", list("data", "img", "output")))
#' @export

build_path <- function(FilePath, Silent = TRUE) {

  PathBuilder <- function(FP) {
    if (!file.exists(FP)) {
      PathBuilder(dirname(FP))
      dir.create(FP)
    }
  }

  if(is.list(FilePath)) FilePath <- unlist(FilePath)

  for(i in 1:length(FilePath)){
    if(!dir.exists(file.path(FilePath[i]))){
      PathBuilder(FP = FilePath[i])
      if(Silent == FALSE) {
        message(paste0(FilePath[i], " - successfully created"))
      }
    } else {
      if(Silent == FALSE) {
        message(paste0(FilePath[i], " - alread exists, not created"))
      }
    }
  }

}
