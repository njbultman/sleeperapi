#' Plot NFL Player Information in Table
#'
#' This function will generate a table containing general
#' information (name, age, college, etc.) concerning all
#' the NFL players that Sleeper can get data on.
#'
#' @return Returns a plot containing information (name and
#'         count) about the NFL trending players.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, March 2024
#' @keywords players general
#' @importFrom DT datatable
#' @importFrom htmlwidgets JS
#' @export
#' @examples
#' \dontrun{plot_nfl_player_data_table()}
#' \dontrun{plot_nfl_player_data_table(font_color = "green")}
#'
#' @param font_color Font color, name or hex. Default is "inherit" (string).
#'
plot_nfl_player_data_table <- function(font_color = "inherit") {
  # Check if font_color argument is a string (throw error if not)
  if (class(font_color) != "character") {
    stop("Font color argument must be a string.")
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
  # Generate javascript based on font_color specified
      js_dt <- paste0("function(settings, json) {$(this.api().table().body()).css({'color': '",  # nolint
                      font_color,
                      "'});$(this.api().table().header()).css({'color': '",
                      font_color,
                      "'});$('.dataTables_info').css({'color': '",
                      font_color,
                      "'});$('.dataTables_filter').css({'color': '",
                      font_color,
                      "'});$('.dataTables_length').css({'color': '",
                      font_color,
                      "'});$('.dataTables_paginate').css({'color': '",
                      font_color,
                      "'})}")
  # Generate base table
  fig <- DT::datatable(player_data[, c("full_name",
                                       "team",
                                       "years_exp",
                                       "fantasy_positions",
                                       "depth_chart_order",
                                       "status",
                                       "age",
                                       "height",
                                       "number",
                                       "college",
                                       "high_school",
                                       "birth_state")],
                       colnames = c("Name",
                                    "Team",
                                    "Years Exp",
                                    "Position(s)",
                                    "Depth Chart",
                                    "Status",
                                    "Age",
                                    "Height",
                                    "Number",
                                    "College",
                                    "High School",
                                    "Birth State"),
                       options = list(pageLength = 20,
                                      initComplete = htmlwidgets::JS(js_dt)), # nolint
                       rownames = FALSE)
  # Return final subplot
  return(fig)
}