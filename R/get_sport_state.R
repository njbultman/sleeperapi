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
#' \dontrun{get_sport_state("nfl")}
#'
#' @param sport Sport that you would like to query (nfl, nba, lcs, etc.) (character)
#'
get_sport_state <- function(sport) {
  # Check if class of the sport parameter is of type character
  if(!is.character(sport)) {
    # If type is not character, inform user and halt function
    stop("sport parameter must be of type character")
  } else {
    # If type is character, execute query given character object specified for sport parameter
    x <- jsonlite::fromJSON(httr::content(httr::GET(paste0("https://api.sleeper.app/v1/state/", sport)), as = "text"))
  }
  # Check if returned object is NULL
  if(is.null(x)) {
    # If NULL, inform user and return nothing
    message("No data was returned. Was the sport correctly specified according to the API documentation?")
  } else {
    # If not NULL, return the object (list)
    return(x)
  }
}
