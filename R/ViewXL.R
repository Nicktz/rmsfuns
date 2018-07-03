#' @title ViewXL
#' @description Views a data.frame or tbl_df object in excel, by saving it in R's temporary file directory (see: tempdir()). It will automatically open the excel sheet. User has the choice too of overriding the file location by setting the FilePath directly.
#' @param DataFrame This is the dataframe or tbl_df that will be displayed in excel
#' @param FilePath If left blank, tempfile will be used. If specified, the excel files will be saved in specified location.
#' @param FileName If specified to save csv file, this would be the name. If left blank and a FilePath has been specified, it would prompt the user to add a FileName.
#' @param ViewTempFile True by default, if False it will not open the excel file, but merely save it. Only useful if provided with a FilePath.
#' @param mac FALSE by default, set to TRUE if using a Mac, else the shell.exec will not work.
#' @return Chosen data frame or tbl_df opened directly in excel.
#' @importFrom readr write_csv
#' @examples
#' \donttest{df <- data.frame( date = seq(
#' as.Date("2012-01-01"),
#' as.Date("2015-08-18"),"day"),
#' x = rnorm(1326, 10,2))
#' ViewXL(df)}
#' @export

ViewXL <- function(DataFrame, FilePath, FileName, ViewTempFile = TRUE, mac = FALSE) {

  if ( missing(FilePath) ) {
    FilePath <- paste0(tempfile(), ".csv")
    write_csv(DataFrame,paste0(FilePath))
  }else{
    if(missing(FileName)) {

      FileName <- readline(cat("--------------- \n PROMPT: \n \n Please provide a csv filename to proceed... \n \n"))
      if(!grepl(".csv", FileName)) FileName <- paste0(FileName, ".csv")
    }

  build_path(file.path(FilePath))
  write_csv(DataFrame,paste0(FilePath, FileName))
}

  if(mac & ViewTempFile){
    shell.exec.mac <- function(x){
      # replacement for shell.exe (doesn't exist on Mac). Thanks Christiaan Bothma for picking this up.
      if (exists("shell.exec",where = "package:base"))
        return(base::shell.exec(x))
      comm <- paste("open",x)
      return(system(comm))
    }
    shell.exec.mac(paste0(FilePath))
  }

  if (mac == FALSE & ViewTempFile) {
    shell.exec(paste0(FilePath))
  }

}
