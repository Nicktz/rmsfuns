#' @title build_path
#' @description build_path builds the entire folder FilePath provided. If the FilePath does not exist, it builds it without error. It is effectively a user-friendly wrapper to the base function dir.create.
#' @param FilePath A character string with the target folder path
#' @param Silent True by default, if set to FALSE it shows the address of the folder just created.
#' @return Path address just built.
#' @examples build_path("C:/Temp/data")
#' @export

build_path <- function(FilePath, Silent = TRUE) {

  PathBuilder <- function(FP) {
    if (!file.exists(FP)) {
      PathBuilder(dirname(FP))
      dir.create(FP)
    }
  }


  if(!dir.exists(file.path(FilePath)) ) PathBuilder(FP = FilePath)

  if(Silent == FALSE) {
    message(paste0(FilePath, " successfully created"))
  }

  FilePath
}
