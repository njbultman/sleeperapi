#' Gather Sport State
#'
#' Given a sport abbreviation (NFL, NBA, etc.), return information about the current sport state.
#'
#' @return Returns a list containing information about the sport state.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, December 2021
#' @keywords sport state
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @export
#' @examples
#' get_sport_state("nfl")
#'
#' @param sport Sport that you would like to query (nfl, nba, lcs, etc.) (string)
#'
get_sport_state <- function(sport) {
  return(fromJSON(content(GET(paste0("https://api.sleeper.app/v1/state/", sport)), as = "text")))
}