#' Gather Trending Player Information
#'
#' Given a sport and type (add or drop), return the top trending players for that selection. More specifically, the player
#' ID and count are returned in a data frame, allowing one to see which players have been added/dropped the most
#' given the particular lookback period (default lookback period of one day).
#'
#' @return Returns a data frame containing information (player ID and count) about the trending players.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, December 2021
#' @keywords players trending
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @export
#' @examples
#' \dontrun{get_trending_players("nfl", "add", 24, 25)}
#'
#' @param sport Sport that you would like to query (nfl, nba, etc.) (character)
#' @param type Either "add" or "drop" (character)
#' @param lookback_hours Number of hours to look back (numeric). Default is 24
#' @param limit Number of results you would like (numeric). Default is 25
#'
get_trending_players <- function(sport, type, lookback_hours = 24, limit = 25) {
  # Check if sport parameter is of type character
  if(!is.character(sport)) {
    # If sport parameter is of type character, message user
    stop("sport parameter should be of character type")
    # Check if type parameter is "add" or "drop"
  } else if(type != "add" && type != "drop") {
    # If not "add" or "drop" inform user
    stop("type parameter should be 'add' or 'drop'")
    # Check if lookback_hours parameter is of type numeric
  } else if(!is.numeric(lookback_hours)) {
    # If not numeric, inform user
    stop("lookback_hours parameter should be of numeric type")
    # Check if limit parameter is of type numeric
  } else if (!is.numeric(limit)) {
    # If not numeric, inform user
    stop("limit parameter should be of numeric type")
  }
  # Execute query to API given inputs specified
  x <- jsonlite::fromJSON(httr::content(httr::GET(paste0("https://api.sleeper.app/v1/players/", sport, "/trending/", type, "?lookback_hours=", lookback_hours, "&limit=", limit)), as = "text"))
  # Check if length of returned object is zero
  if(length(x) == 0) {
    # If length is zero, inform user and return nothing
    message("No data was returned - are you sure all parameters were inputted correctly?")
  } else {
    # If length is not zero, return object (data frame)
    return(x)
  }
}
