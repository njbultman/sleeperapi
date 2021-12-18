#' Gather NFL Player Data
#'
#' Gather all information concerning NFL players. Per Sleeper, this be called once per day at most given
#' the amount of data that it returns (5MB).
#'
#' @return Returns a dataframe containing information about the NFL players.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, December 2021
#' @keywords nfl players
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @export
#' @examples
#' get_all_nfl_players()
#'
get_all_nfl_players <- function() {
  return(fromJSON(content(GET(paste0("https://api.sleeper.app/v1/players/nfl")), as = "text")))
}