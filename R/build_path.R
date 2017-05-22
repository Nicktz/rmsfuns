#' @title build_path
#' @description build_path builds the entire folder FilePath provided. If the FilePath does not exist, it builds it without error. It is effectively an extension to the base function dir.create.
#' @param FilePath A character string with the target folder path. This can be a vector of multiple paths, e.g.: FilePath <- paste0( "C:/TestFolder/", c("Subfolder1","Subfolder2"))
#' @param Silent True by default, if set to FALSE it shows the address of the folder just created. This is, however, saved if used as: Path <- build_path(FilePath), making the message largely redundant.
#' @return Path address just built.
#' @importFrom purrr map map_int
#' @examples
#' Path <- build_path("C:/Temp/data")
#' Pathmultiplecreate <- build_path(paste0("C:/Temp/data", c("XXX", "YYY")))
#' @export

build_path <- function(FilePath, Silent = TRUE) {

  PathBuilder <- function(FP) {
    if (!file.exists(FP)) {
      PathBuilder(dirname(FP))
      dir.create(FP)
    }
  }

  X <- FilePath[!file.path(FilePath) %>% map_int(dir.exists)] %>% map(PathBuilder)

  if(Silent == FALSE) {
    message(paste0(FilePath, " successfully created"))
  }

  FilePath
}
