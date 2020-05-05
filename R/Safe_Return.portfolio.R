#' @title Safe_Return.portfolio
#' @description This provides a safe way to do portfolio return calculations.
#' It ensures the returns and weights are explicitly mapped.
#' It is thus a simple wrapper to PerformanceAnalytics::Return.portfolio making it safer.
#' See the following gist for a discussion on why this safety feature is essential: https://gist.github.com/Nicktz/a24ba1775d41aab85919c505ca1b9a0c
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#' @importFrom tbl2xts xts_tbl tbl_xts
#' @importFrom PerformanceAnalytics Return.portfolio
#' @param R xts of returns.
#' @param weights xts of weights.
#' @param lag_weights This function makes weights effective on the day it is given. The Return.Portfolio function defaults to having weights become effective only the following day after its specification. E.g. from the vignette:
#' Rebalancing periods can be thought of as taking effect immediately after the close of the bar. So, a March 31 rebalancing date will actually be in effect for April 1.
#' @param ... parameter inputs from PerformanceAnalytics::Return.portfolio.
#' @examples
#' \dontrun{
#' library(PerformanceAnalytics)
#' data(edhec)
#' data(weights) # rebalance at the beginning of the year to various weights through time
#' x <- Safe_Return.portfolio(edhec[,1:11], weights=weights, lag_weights = TRUE, verbose=TRUE)
#' }
#' @export
#'
Safe_Return.portfolio <- function( R, weights, lag_weights = TRUE, ... ) {

  # See: https://gist.github.com/Nicktz/a24ba1775d41aab85919c505ca1b9a0c
  if( !"xts" %in% class(R) ) stop("\n\nStock returns must be in xts format...\n\n")
  if( !"xts" %in% class(weights) ) stop("\n\nStock weights must be in xts format...\n\n")
  if(ncol(R) > ncol(weights)) stop("\n\nStocks in return dataframe R has more columns than stocks for weights input...\n\n")
  if(ncol(R) < ncol(weights)) stop("\n\nStocks in weights input has more columns than for Returns input R...\n\n")

  R <- R[,colnames(weights)] # Squares weight names with return names...
  if(!all.equal(names(R), names(weights))) stop("\n\nStock names not exactly the same for R and weights...\n\n Note that it requires EXACT similarity.\n\n")

  if(lag_weights){

    weights <- weights %>% tbl2xts::xts_tbl() %>% mutate(date = date - 1) %>% tbl2xts::tbl_xts()

  }

  Port <-
    PerformanceAnalytics::Return.portfolio(R = R, weights = weights, ...)

  Port

}
