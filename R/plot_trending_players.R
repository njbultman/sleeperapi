#' Plot Trending NFL Player Information
#'
#' Given the number of hours to look back, a limit of
#' how many players to return, a color for labels, and a
#' title, display a figure showing the top NFL additions and drops.
#'
#' @return Returns a plot containing information (name and
#'         count) about the trending players.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, September 2023
#' @keywords players trending
#' @importFrom dplyr left_join
#' @importFrom plotly plot_ly layout subplot
#' @importFrom stats reorder
#' @importFrom scales comma
#' @export
#' @examples
#' \dontrun{plot_trending_players(lookback_hours = 24, limit = 10)}
#' \dontrun{plot_trending_players(lookback_hours = 24, limit = 10, tick_color = "white")}
#'
#' @param lookback_hours Number of hours to look back (numeric).
#' @param limit Number of results you would like (numeric).
#' @param tick_color Font color, name or hex, for display names (string).
#' @param title Plot title - default is "Trending Adds/Drops" (string).
#' @param drop_fill Bar color, name or hex, for drops (string).
#' @param add_fill Bar color, name or hex, for adds (string).
#'
plot_trending_players <- function(lookback_hours = 24,
                                  limit = 10,
                                  tick_color = "black",
                                  title = "Trending Adds/Drops",
                                  drop_fill = "#f68383",
                                  add_fill = "lightgreen") {
  # Verify that tick color and title are strings
  if (class(tick_color) != "character" || class(title) != "character" || class(drop_fill) != "character" || class(add_fill) != "character") { # nolint
    stop("Title, tick color, drop fill, and add fill must be strings.")
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
  # Generate plot of adds
  add_plot <- plotly::plot_ly(data = total_add_df,
                              x = ~count,
                              y = ~stats::reorder(name, count),
                              text = ~scales::comma(count),
                              textposition = "auto",
                              type = "bar",
                              marker = list(color = add_fill,
                                            line = list(color = "rgb(0 ,0, 0)",
                                                        width = 1.5)),
                              name = "Adds")
  # Style plot of adds
  add_plot_fin <- plotly::layout(add_plot,
                                 yaxis = list(title = "Name",
                                              tickfont = list(color = tick_color)), # nolint
                                 xaxis = list(title = "Number of Adds",
                                              tickfont = list(color = tick_color))) # nolint
  # Generate plot of drops
  drop_plot <- plotly::plot_ly(data = total_drop_df,
                               x = ~count,
                               y = ~stats::reorder(name, count),
                               text = ~scales::comma(count),
                               textposition = "auto",
                               type = "bar",
                               marker = list(color = drop_fill,
                                             line = list(color = "rgb(0 ,0, 0)",
                                                         width = 1.5)),
                               name = "Drops")
  # Style plot of drops
  drop_plot_fin <- plotly::layout(drop_plot,
                                  yaxis = list(title = "Name",
                                               side = "right",
                                               tickfont = list(color = tick_color)), # nolint
                                  xaxis = list(title = "Number of Drops",
                                               tickfont = list(color = tick_color)), # nolint
                                  legend = list(font = list(color = tick_color))) # nolint
  # Create a subplot to display both figures
  fig <- plotly::subplot(add_plot_fin, drop_plot_fin)
  # Add title to subplot layout and position legend to top center
  fig_fin <- plotly::layout(fig,
                            title = title,
                            legend = list(orientation = "h",
                                          xanchor = "center",
                                          x = 0.5,
                                          y = -0.1),
                            plot_bgcolor  = "rgba(0, 0, 0, 0)",
                            paper_bgcolor = "rgba(0, 0, 0, 0)")
  # Return final subplot
  return(fig_fin)
}
