#' Gather Trending Player Information
#'
#' Given a sport and type (add or drop), return the top trending players for that selection. More specifically, the player
#' ID and count are returned in a dataframe, allowing one to see which players have been added/dropped the most
#' given the particular lookback period (default lookback period of one day).
#'
#' @return Returns a dataframe containing information (player ID and count) about the trending players.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, December 2021
#' @keywords players trending
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @export
#' @examples
#' get_trending_players("nfl", "add", 24, 25)
#'
#' @param sport Sport that you would like to query (nfl, nba, etc.) (string)
#' @param type Either "add" or "drop"
#' @param lookback_hours Number of hours to look back (integer). Default is 24
#' @param limit Number of results you would like (integer). Default is 25
#'
get_trending_players <- function(sport, type, lookback_hours = 24, limit = 25) {
  return(fromJSON(content(GET(paste0("https://api.sleeper.app/v1/players/", sport, "/trending/", type, "?lookback_hours=", lookback_hours, "&limit=", limit)), as = "text")))
}