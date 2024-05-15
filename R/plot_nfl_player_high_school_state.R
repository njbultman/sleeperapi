#' Plot NFL Player High School State Information
#'
#' This function will generate a plot showing counts of NFL
#' players by high school state. Colors can be manually defined
#' for high and low values of each state's count.
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
#' @param title Title for plot (string).
#' @param high_fill Fill color, name or hex, for high value states (string).
#' @param low_fill Fill color, name or hex, for low value states (string).
#'
plot_nfl_player_high_school_state <- function(title = "<b>NFL Players by High School State</b>",
                                              high_fill = "lightgreen",
                                              low_fill = "white") {
  # Check if font_color argument is a string (throw error if not)
  if (!is.character(title) || !is.character(high_fill) || !is.character(low_fill)) { # nolint
    stop("Title, high fill, and low fill arguments must be strings.")
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
  player_data_count <- dplyr::count(player_data, .data$high_school_state) # nolint
  # Generate base plot
  fig <- plotly::plot_geo(player_data_count, locationmode = "USA-states")

  # Define continuous color scale
  color_scale <- c(low_fill, high_fill)

  # Add trace for counts of high school states
  fig_2 <- plotly::add_trace(fig,
                             z = ~n,
                             locations = ~high_school_state,
                             color = ~n,
                             colors = color_scale)
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