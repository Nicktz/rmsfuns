#' @title dateconverter
#' @description dateconverter makes it easy to create a date vector in R. It offers a simple wrapper using xts functionality to create a vector of dates between a given Start and End date, and then correcting for the chosen frequency transformation.
#' @param StartDate A valid as.Date object. This can be given as ymd("2000-01-01") or as.Date("2000-01-01")
#' @param EndDate True by default, if set to FALSE it shows the address of the folder just created. This is, however, saved if used as: Path <- build_path(FilePath), making the message largely redundant.
#' @param Transform This is the days that you want returned. Options include:
#' alldays: All calendar days between the start and end date
#' calendarEOM: Last calendar day of each month between the start and end date
#' weekdays: All weekdays between the start and end date (mon - fri)
#' weekdayEOW: All last weekdays between the start and end date
#' weekdayEOM: All last weekdays of the month between the start and end date
#' weekdayEOQ: All last weekdays of the quarter between the start and end date
#' weekdayEOY: All last weekdays of the year between the start and end date
#' @return Path address just built.
#' @import xts
#' @importFrom zoo index
#' @importFrom magrittr %>%
#' @examples
#' dateconverter(as.Date("2000-01-01"),
#' as.Date("2017-01-01"), "weekdays")
#' dateconverter(as.Date("2000-01-01"),
#' as.Date("2017-01-01"), "calendarEOM")
#' dateconverter(as.Date("2000-01-01"),
#' as.Date("2017-01-01"), "weekdayEOW")
#' dateconverter(as.Date("2000-01-01"),
#' as.Date("2017-01-01"), "weekdayEOM")
#' dateconverter(as.Date("2000-01-01"),
#' as.Date("2017-01-01"), "weekdayEOQ")
#' dateconverter(as.Date("2000-01-01"),
#' as.Date("2017-01-01"), "weekdayEOY")
#' dateconverter(as.Date("2000-01-01"),
#' as.Date("2017-01-01"), "alldays")
#' @export

dateconverter <- function(StartDate, EndDate, Transform) {

  if( class(StartDate) != "Date" ) stop("Please provide a valid as.Date object for the Start Date")
  if( class(EndDate) != "Date" ) stop("Please provide a valid as.Date object for the End Date")

  if (Transform == "alldays") {
    vectordates <-
      seq(StartDate, EndDate, by = "1 day")

  } else

    if (Transform == "calendarEOM") {

      D <- as.Date(seq(StartDate, EndDate, by = "1 day"))
      vectordates <-
        as.xts(data.frame("X" = rep(1, length(D))),
               order.by = D)
      vectordates <-
        vectordates[endpoints(vectordates,'months')] %>% index()

    } else

      if (Transform == "weekdays") {

        D <- as.Date(seq(StartDate, EndDate, by = "1 day"))
        vectordates <-
        as.xts(data.frame("X" = rep(1, length(D))),
               order.by = D)
        vectordates <-
          vectordates[.indexwday(vectordates) %in% 1:5] %>% index()

      } else

        if (Transform == "weekdayEOW") {
          D <- as.Date(seq(StartDate, EndDate, by = "1 day"))
          vectordates <-
            as.xts(data.frame("X" = rep(1, length(D))),
                   order.by = D)
          vectordates <-
            vectordates[.indexwday(vectordates) %in% 1:5]
          vectordates <-
            vectordates[endpoints(vectordates,'weeks')] %>% index()

        } else

          if (Transform == "weekdayEOM") {
            D <- as.Date(seq(StartDate, EndDate, by = "1 day"))
            vectordates <-
              as.xts(data.frame("X" = rep(1, length(D))),
                     order.by = D)
            vectordates <-
              vectordates[.indexwday(vectordates) %in% 1:5]
            vectordates <-
              vectordates[endpoints(vectordates,'months')] %>% index()

          }  else

            if (Transform == "weekdayEOQ") {

              D <- as.Date(seq(StartDate, EndDate, by = "1 day"))
              vectordates <-
                as.xts(data.frame("X" = rep(1, length(D))),
                       order.by = D)
              vectordates <-
                vectordates[.indexwday(vectordates) %in% 1:5]

              vectordates <-
                vectordates[endpoints(vectordates,'quarters')] %>% index()

            } else

              if (Transform == "weekdayEOY") {

                D <- as.Date(seq(StartDate, EndDate, by = "1 day"))
                vectordates <-
                  as.xts(data.frame("X" = rep(1, length(D))),
                         order.by = D)
                vectordates <-
                  vectordates[.indexwday(vectordates) %in% 1:5]

                vectordates <-
                  vectordates[endpoints(vectordates,'years')] %>% index()

              } else
                stop(cat("Invalid Transform Input. \n Available options are: \n AllDays ; calendarEOM ; weekdays ; weekdayEOW ; weekdayEOM ; weekdayEOQ ; weekdayEOY") )

  vectordates

}
