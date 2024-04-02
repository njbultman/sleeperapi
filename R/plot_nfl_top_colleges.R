#' Plot NFL Player College Information
#'
#' This function will generate a bar plot showing counts of NFL
#' players by college. The total number of colleges returned is
#' specified by the user.
#'
#' @return Returns a plot containing information about counts
#'         for NFL players by their college.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, March 2024
#' @keywords players college
#' @importFrom plotly plot_ly layout
#' @importFrom tidyr drop_na
#' @importFrom dplyr count top_n
#' @export
#' @examples
#' \dontrun{plot_nfl_player_college()}
#' \dontrun{plot_nfl_player_college(title = "TestTitle", tick_color = "green", number = 5)}
#'
#' @param title Title for plot. Default is "NFL Players by High School State" (string).
#' @param tick_color Color for tick labels. Default is black (string).
#' @param number Number of colleges to show. Default is 10 (numeric).
#'
plot_nfl_top_colleges <- function(title = "<b>NFL Players by High School State</b>", # nolint
                                  tick_color = "black",
                                  number = 10) {
  # Check if title and tick_color arguments are strings (throw error if not)
  if (class(title) != "character" || class(tick_color) != "character") {
    stop("Title and tick color arguments must be strings.")
  }
  # Check if number argument is numeric (throw error if not)
  if (class(number) != "numeric") {
    stop("Number argument must be numeric.")
  }
  # Check if player data exists in temporary directory
  if (file.exists(paste0(tempdir(), "/nfl_data.RDS"))) {
    # If data exists, load it
    player_data <- readRDS(paste0(tempdir(), "/nfl_data.RDS"))
    # If data does not exist, inform user and get data, save it
  } else {
    message("Player data does not exist. Loading before plotting.")
    plot_generate_nfl_player_data()
    player_data <- readRDS(paste0(tempdir(), "/nfl_data.RDS"))
  }
  # Filter for only players that have a non-null college
  player_data_filter <- tidyr::drop_na(player_data, college) # nolint
  # Count the number of records per college
  player_data_count <- dplyr::count(player_data_filter, college) # nolint
  # Get the top records by count as specified by the user
  player_data_top <- dplyr::top_n(player_data_count, n = number, wt = n) # nolint
  # Generate base plot
  fig <- plotly::plot_ly(data = player_data_top,
                         x = ~college,
                         y = ~n,
                         text = ~n,
                         textposition = "auto",
                         type = "bar",
                         marker = list(color = "rgb(144, 238, 144)",
                                       line = list(color = "rgb(0 ,0, 0)",
                                                   width = 1.5)))
  # Style plot
  fig_fin <- plotly::layout(fig,
                            title = title,
                            yaxis = list(title = "",
                                        tickfont = list(color = tick_color)), # nolint
                            xaxis = list(title = "",
                                        tickfont = list(color = tick_color), # nolint
                                        categoryorder = "total descending"),
                            plot_bgcolor  = "rgba(0, 0, 0, 0)",
                            paper_bgcolor = "rgba(0, 0, 0, 0)")
  # Return final plot
  return(fig_fin)
}