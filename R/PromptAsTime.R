#' @title PromptAsTime
#' @description This changes Rstudio's prompt at the bottom to reflect time. Useful for timing functions with ease.
#' @return The Prompter in Rstudio will now include the time.
#' @param Set On to TRUE (Add time to prompter) or FALSE (use default prompter).
#' @examples PromptAsTime(TRUE)
#' @export

PromptAsTime <- function(On) {

  if (On) {
    updatePromptTimer <- function(...) {options(prompt = paste(Sys.time(),"> ")); return(TRUE)}
    addTaskCallback(updatePromptTimer)
  } else {
    updatePromptTimer <- function(...) {options(prompt = "> "); return(TRUE)}
    addTaskCallback(updatePromptTimer)
  }

}
