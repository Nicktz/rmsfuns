#' @title CleanTempFolder
#' @description This function will clean all the Rtmp files created. This might take a while to clean if not done regularly. This can be used to clean the R temporary folder specifically when using ViewXL.
#' @return CLeaned R Temp Folder.
#' @param User Name. If left blank it will use the location defined by tempdir() in R. Else, manually define where temporary R files are stored.
#' @examples CleanTempFolder()
#' @export

CleanTempFolder <- function(RTempFileLocation) {

  if ( missing(RTempFileLocation)) {
    RTempFileLocation <- strsplit(gsub("([\\])", "_", tempdir()), "_")[[1]][3]
  }
  CheckGitHubConnection()

  if ( !dir.exists(file.path(paste0("C:/Users/",RTempFileLocation,"/AppData/Local/Temp")))) stop("Make sure that this temp path exists / the RTempFileLocation supplied is correct.")

  print(paste0("Files being cleaned. This might take a few minutes. Location: C:/Users/",RTempFileLocation,"/AppData/Local/Temp"))
  unlink( list.files(paste0("C:/Users/",RTempFileLocation,"/AppData/Local/Temp"), full.names = TRUE) %>% .[grepl("Rtmp",.)], recursive = TRUE)

}




