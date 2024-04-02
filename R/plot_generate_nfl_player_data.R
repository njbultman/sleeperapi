#' Generate NFL Player Information for Plotting
#'
#' When using some of the plotting functions, it is
#' recommended to run this function before any plotting
#' begins to ensure the latest player information is present
#' with the package. Per Sleeper, gathering these data should
#' only be done once per day, which is why is not recommended
#' to implement a call to gather player information every time
#' a plot is generated. This function will refresh the latest
#' NFL player information and place it in the appropriate place
#' for the plotting functions to grab. Moreover, it will keep that
#' information stored for the duration of the R session.
#'
#' @return Returns a message stating if the data refresh was successful or not
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, September 2023
#' @keywords nfl players refresh data
#' @export
#' @examples
#' \dontrun{plot_generate_nfl_player_data()}
#'
plot_generate_nfl_player_data <- function() {
  # Gather all NFL player data in data frame
  nfl_data <- get_all_nfl_players(clean = TRUE)
  # Append date that data was gathered
  nfl_data$date <- Sys.Date()
  # Create a temporary file path that will be used to store the NFL player data
  tmp_path <- tempdir()
  # Save file to temporary file path
  saveRDS(nfl_data, file = paste0(tmp_path, "/nfl_data.RDS"))
  # Return message to user saying data generation was successful
  return(print("NFL data generation successful."))
}