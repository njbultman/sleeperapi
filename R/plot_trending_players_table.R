#' Plot Trending NFL Player Information in Table
#'
#' Given the number of hours to look back, and a limit of
#' how many players to return, display a figure showing the
#' top additions and drops in a table.
#'
#' @return Returns a plot containing information (name and
#'         count) about the trending NFL players.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, February 2024
#' @keywords players trending
#' @importFrom dplyr left_join bind_rows
#' @importFrom DT datatable formatStyle styleEqual
#' @importFrom stats reorder
#' @importFrom scales comma
#' @importFrom htmlwidgets JS
#' @export
#' @examples
#' \dontrun{plot_trending_players_table(lookback_hours = 24, limit = 10)}
#' \dontrun{plot_trending_players_table(lookback_hours = 24, limit = 10, font_color = "white")}
#'
#' @param lookback_hours Number of hours to look back (numeric).
#' @param limit Number of players returned for add/drop. Should be less than 50 (numeric).
#' @param font_color Font color, name or hex (string).
#' @param drop_fill Bar color, name or hex, for drops (string).
#' @param add_fill Bar color, name or hex, for adds (string).
#'
plot_trending_players_table <- function(lookback_hours = 24,
                                        limit = 10,
                                        font_color = "inherit",
                                        drop_fill = "#f68383",
                                        add_fill = "lightgreen") {
  # Test to see if limit is greater than 50
  if (limit > 50) {
    # If it is, stop program and alert user
    stop("Limit should be less than or equal to 50")
  }
  # Test font_color, drop_fill and add_fill types (error if not string)
  if (!is.character(font_color)|| !is.character(drop_fill) || !is.character(add_fill)) { # nolint
    stop("Font color, drop fill, and add fill arguments must be strings")
  }
  # Get trending additions
  add_df <- get_trending_players(sport = "nfl",
                                 type = "add",
                                 lookback_hours,
                                 limit)
  # Get trending drops
  drop_df <- get_trending_players(sport = "nfl",
                                  type = "drop",
                                  lookback_hours,
                                  limit)
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
  # Bind player data to add_df and drop_df
  total_add_df <- dplyr::left_join(add_df, player_data, by = "player_id")
  total_drop_df <- dplyr::left_join(drop_df, player_data, by = "player_id")
  # Create user friendly column to replace player_id in plot
  total_add_df$name <- paste0(total_add_df$first_name,
                              " ",
                              total_add_df$last_name)
  total_drop_df$name <- paste0(total_drop_df$first_name,
                               " ",
                               total_drop_df$last_name)
  # Create column to identify adds/drops
  total_add_df$add_drop <- "Add"
  total_drop_df$add_drop <- "Drop"
  # Bind data together
  total_df <- dplyr::bind_rows(total_add_df, total_drop_df)
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
  fig <- DT::datatable(total_df[, c("name",
                                    "add_drop",
                                    "count",
                                    "age",
                                    "fantasy_positions",
                                    "depth_chart_order",
                                    "team",
                                    "years_exp")],
                       colnames = c("Name",
                                    "Add or Drop",
                                    "Count of Adds or Drops",
                                    "Age",
                                    "Position",
                                    "Depth Chart",
                                    "Team",
                                    "Years of Experience"),
                       options = list(pageLength = 100,
                                      initComplete = htmlwidgets::JS(js_dt)), # nolint
                       rownames = FALSE)
  # Add background color (green or red) based on add/drop value
  fig_fin <- DT::formatStyle(fig,
    "add_drop",
    backgroundColor = DT::styleEqual(c("Add", "Drop"),
      c(add_fill, drop_fill)
    )
  )
  # Return final subplot
  return(fig_fin)
}