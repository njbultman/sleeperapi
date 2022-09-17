# sleeperapi

## R Package Wrapper Around 'Sleeper' (Fantasy Sports) API

### *Installation*
Install release version from CRAN:

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version-last-release/sleeperapi)](ttps://cran.r-project.org/package=sleeperapi)
[![downloads](https://cranlogs.r-pkg.org/badges/grand-total/sleeperapi)](https://www.r-pkg.org/services)
[![R-CMD-check](https://github.com/njbultman/sleeperapi/workflows/R-CMD-check/badge.svg)](https://github.com/njbultman/sleeperapi/actions) 
[![Codecov test coverage](https://codecov.io/gh/njbultman/sleeperapi/branch/main/graph/badge.svg)](https://codecov.io/gh/njbultman/sleeperapi?branch=main)

```R
install.packages("sleeperapi")
library(sleeperapi)
```

Install latest development version through GitHub via `devtools` package:

```R
install.packages("devtools") # If have not installed package already
library(devtools)
devtools::install_github("njbultman/sleeperapi")
```

### *Background*
Sleeper offers a free, non-authenticated read-only HTTP API for users to gather information from their platform. Their API [documentation](https://docs.sleeper.app/) goes into basic GET requests using terminal commands, but those wishing to use R might want a simpler way to gather the data they would like to analyze should they be unfamiliar with how to go about this in R. 

This package attempts to solve this issue through various functions that gather data from Sleeper's API into lists and data frames (well known objects for R users) just by knowing basics like league or user IDs. 

For example, using only the league ID that I am familiar with for the "Know It Alls" fantasy football league, I can easily call functions like `get_winner_playoff_bracket` or `get_league_drafts` to get the data in a readily usable object to jumpstart our analysis. By executing `get_winner_playoff_bracket(688281863499907072)`, it returns a nice data frame detailing everything that Sleeper's API provides us concerning the playoff bracket for the Know It Alls league.