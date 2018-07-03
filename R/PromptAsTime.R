#' @title PromptAsTime
#' @description This changes Rstudio's prompt at the bottom to reflect time. Particularly useful for timing functions when executing long scripts.
#' @return The Prompter in Rstudio will now include the time.
#' @param On set On to TRUE (Add time to prompter) or FALSE (use default prompter).
#' @examples
#' \donttest{
#' PromptAsTime(TRUE)
#' x <- 100
#' Sys.sleep(3)
#' #' x*x
#' print(x)
#' }
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
