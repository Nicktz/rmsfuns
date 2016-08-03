#' @title ViewXL
#' @description Views a data.frame or tbl_df object in excel, by saving it in R's temporary file directory (see: tempdir()). It will automatically open the excel sheet. User has the choice too of overriding the file location by setting the FilePath directly.
#' @param DataFrame This is the dataframe or tbl_df that will be displayed in excel
#' @param FilePath If left blank, tempfile will be used. If specified, the excel files will be created.
#' @param ViewTempFile True by default, if False it will not open the excel file, but merely save it. Only useful if provided with a FilePath.
#' @return Chosen data frame or tbl_df opened directly in excel.
#' @examples ViewXL(data.frame)
#' @export

ViewXL <- function(DataFrame, FilePath, ViewTempFile = TRUE) {

  library(readr)

  if ( missing(FilePath) ) {
    FilePath <- paste0(tempfile(), ".csv")
    write_csv(DataFrame,paste0(FilePath))
  }else{
    build_path(file.path(FilePath,FolderName))
    write_csv(DataFrame,paste0(FilePath))
  }
  if (ViewTempFile) {
    shell.exec(paste0(FilePath))
  }
}
