Introduction
============

![](https://cranlogs.r-pkg.org/badges/rmsfuns?color=brightgreen)
![](https://cranlogs.r-pkg.org/badges/grand-total/rmsfuns?color=brightgreen)

This package contains several helper functions for use in data
manipulation, folder creation and viewing purposes. See examples of such
functions below.

build\_path
-----------

This function builds the entire folder path provided by the user. If the
path does not exist, it builds it without error. It is effectively a
user-friendly wrapper to the base function dir.create.

    library(rmsfuns)
    build_path("C:/Temp/data")

Can also be used to build a vector of paths:

    library(rmsfuns)
    Path <- build_path(paste0("C:/Temp/data/", c("SubFolder1", "SubFolder2", "SubFolder3"))
    print(Path)

ViewXL
------

This function makes it easy to quickly view any R object or dataframe in
excel. A random file is created in R’s temporary folder location (see
tempdir() to find your location). The excel file location can also be
overridden using the FilePath command. IMPORTANT: if using a mac, set
mac = TRUE in the command (equal to FALSE by default).

    library(rmsfuns)
    df <- data.frame(date = 
    seq(as.Date("2012-01-01"),
    as.Date("2015-08-18"),"day"), 
    x = rnorm(1326, 10,2))

    ViewXL(df)
    # ViewXL(df, mac = TRUE) if using a mac

To clean the R temporary file folder (done periodically if using ViewXL
often - especially with large excel files), use CleanTempFolder:

    library(rmsfuns)
    CleanTempFolder()

dateconverter
-------------

The dateconverter function makes it easy to create a date vector in R.
It offers a simple wrapper using xts functionality to create a vector of
dates between a given Start and End date, and then correcting for the
chosen frequency transformation.

It can do the following transformations between given Start and End
Dates:

alldays ; calendarEOM ; weekdays ; weekdayEOW ; weekdayEOM ; weekdayEOQ
; weekdayEOY

    library(rmsfuns)
    dates <- dateconverter(as.Date("2000-01-01"), as.Date("2017-01-01"), "alldays") 
    dates <- dateconverter(as.Date("2000-01-01"), as.Date("2017-01-01"), "weekdays") 
    dates <- dateconverter(as.Date("2000-01-01"), as.Date("2017-01-01"), "calendarEOM")
    dates <- dateconverter(as.Date("2000-01-01"), as.Date("2017-01-01"), "weekdayEOW")
    dates <- dateconverter(as.Date("2000-01-01"), as.Date("2017-01-01"), "weekdayEOM")
    dates <- dateconverter(as.Date("2000-01-01"), as.Date("2017-01-01"), "weekdayEOQ")
    dates <- dateconverter(as.Date("2000-01-01"), as.Date("2017-01-01"), "weekdayEOY")

PromptAsTime
------------

To change R’s prompt to reflect the time, use the PromptAsTime function.
This can be used as a simple means of timing long calculations without
using sys.time() commands. This can be very useful if running, e.g.,
many functions overnight, and later viewing the time taken on multiple
calculations.

To set the timer on, type:

    PromptAsTime(TRUE)

The time for each command will now be shown in Rstudio’s prompt.

This is particularly useful for when you want to see, after running a
code script in Rstudio, what the duration of each line was. E.g., run
the following in your Rstudio console:

    PromptAsTime(TRUE)
    x <- 100
    Sys.sleep(3) 
    x*x
    print(x)
    PromptAsTime(FALSE)

You can then see in the prompt that the Sys.sleep(3) call lasted 3
seconds.

Safe\_Return.portfolio
----------------------

This function provides a safe alternative to do portfolio return
calculations using PerformanceAnalytics::Return.portfolio.

See this gist for where the function fails:
<a href="https://gist.github.com/Nicktz/a24ba1775d41aab85919c505ca1b9a0c" class="uri">https://gist.github.com/Nicktz/a24ba1775d41aab85919c505ca1b9a0c</a>

### Problems with PerformanceAnalytics::Return.portfolio

-   For starters, the resulting xts starts on the second day - i.e. it
    produces weights and returns from the day after the initial weights
    are provided.

    -   E.g. from the vignette it states: “Rebalancing periods can be
        thought of as taking effect immediately after the close of the
        bar. So, a March 31 rebalancing date will actually be in effect
        for April 1.”

    -   In most applications this does not fit with my own personal
        workflow. If it fit yours, simply set lag\_weights = FALSE.

-   Second (and most frustratingly) - the function is order dependent.

    -   Thus it does not square stock X, Y and Z for R and weight
        inputs, but rather considers column orders.

    -   This is extremely dangerous - and can easily cause unintended
        mistakes to enter your calculations.

To solve both the above issues - instead use this safer wrapper. The
function works otherwise exactly like that of
PerformanceAnalytics::Return.portfolio

#### Example

See the gist:
<a href="https://gist.github.com/Nicktz/a24ba1775d41aab85919c505ca1b9a0c" class="uri">https://gist.github.com/Nicktz/a24ba1775d41aab85919c505ca1b9a0c</a>

load\_pkg
---------

This function loads a vector of packages into R, and installs the
package if it has not yet been installed.

    Packages <- c("xts", "dplyr")
    load_pkg(Packages)
