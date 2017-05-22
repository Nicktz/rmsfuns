#' @title CleanTempFolder
#' @description This function will clean all the csv files created using ViewXL in the temp folder. This might take a while to clean if not done regularly.
#' @return Cleaned R Temp Folder.
#' @examples CleanTempFolder()
#' @export

CleanTempFolder <- function() {

    List <-
      list.files(tempdir(), recursive = TRUE, full.names = TRUE)
    unlist( List[ grepl(".csv", List) ], recursive = TRUE)

}




