#' Plot NFL Player High School State Information
#'
#' This function will generate a plot showing counts of NFL
#' players by high school state. More color means more NFL players
#' are from that state.
#'
#' @return Returns a plot containing information about counts
#'         for NFL players by their high school state.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, March 2024
#' @keywords players high school state
#' @importFrom plotly plot_geo add_trace layout hide_colorbar
#' @importFrom stringr str_extract str_replace
#' @importFrom dplyr count
#' @export
#' @examples
#' \dontrun{plot_nfl_player_high_school_state()}
#' \dontrun{plot_nfl_player_high_school_state(title = "Test")}
#'
#' @param title Title for plot. Default is "NFL Players by High School State" (string).
#'
plot_nfl_player_high_school_state <- function(title = "<b>NFL Players by High School State</b>") {
  # Check if font_color argument is a string (throw error if not)
  if (class(title) != "character") {
    stop("Title argument must be a string.")
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
  # Get player high school state
  player_data$high_school_state <- stringr::str_extract(player_data$high_school,
                                                        "\\(.*?\\)")
  # Remove parentheses from high school state column
  player_data$high_school_state <- stringr::str_replace(player_data$high_school_state, # nolint: line_length_linter.
                                                        pattern = "\\(",
                                                        replacement = "")
  player_data$high_school_state <- stringr::str_replace(player_data$high_school_state, # nolint
                                                        pattern = "\\)",
                                                        replacement = "")
  # If high school state found is greater than two characters, replace with NA
  player_data$high_school_state <- ifelse(nchar(player_data$high_school_state) > 2, # nolint
                                          NA,
                                          player_data$high_school_state)
  player_data_count <- dplyr::count(player_data, high_school_state) # nolint
  # Generate base plot
  fig <- plotly::plot_geo(player_data_count, locationmode = "USA-states")
  # Add trace for counts of high school states
  fig_2 <- plotly::add_trace(fig,
                             z = ~n,
                             locations = ~high_school_state,
                             color = ~n,
                             colors = "Greens")
  # Refine layout
  fig_3 <- plotly::layout(fig_2,
                          title = title,
                          geo = list(
                                     scope = "usa",
                                     projection = list(type = "albers usa"),
                                     showlakes = TRUE,
                                     lakecolor = "rgba(0, 0, 0, 0)",
                                     bgcolor = "rgba(0, 0, 0, 0)"),
                          plot_bgcolor  = "rgba(0, 0, 0, 0)",
                          paper_bgcolor = "rgba(0, 0, 0, 0)")
  # Hide colorbar
  fig_fin <- plotly::hide_colorbar(fig_3)
  # Return final subplot
  return(fig_fin)
}