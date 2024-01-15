#' Plot Trending NFL Player Information
#'
#' Given the number of hours to look back, and a limit of how many players to return, display a
#' figure showing the top NFL additions and drops.
#'
#' @return Returns a plot containing information (name and count) about the NFL trending players.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, September 2023
#' @keywords players trending
#' @importFrom dplyr left_join
#' @importFrom plotly plot_ly layout subplot
#' @importFrom stats reorder
#' @importFrom scales comma
#' @export
#' @examples
#' \dontrun{get_trending_players("nfl", "add", 24, 25)}
#'
#' @param lookback_hours Number of hours to look back (numeric). Default is 24
#' @param limit Number of results you would like (numeric). Default is 10
#'
plot_trending_players <- function(lookback_hours = 24, limit = 10) {
  # Get trending additions
  add_df <- get_trending_players(sport = "nfl", type = "add", lookback_hours, limit)
  # Get trending drops
  drop_df <- get_trending_players(sport = "nfl", type = "drop", lookback_hours, limit)
  # Check if player data exists in temporary directory
  if(file.exists(paste0(tempdir(), "/nfl_data.RDS"))) {
    # If data exists, load it
    player_data <- readRDS(paste0(tempdir(), "/nfl_data.RDS"))
    # If data does not exist, inform user and get data, save it
  } else {
    message("Player data does not exist. Loading now before plotting. This will take some extra time.")
    plot_generate_nfl_player_data()
    player_data <- readRDS(paste0(tempdir(), "/nfl_data.RDS"))
  }
  # Bind player data to add_df and drop_df
  total_add_df <- dplyr::left_join(add_df, player_data, by = "player_id")
  total_drop_df <- dplyr::left_join(drop_df, player_data, by = "player_id")
  # Create user friendly column to replace player_id in plot
  total_add_df$name <- paste0(total_add_df$first_name, " ", total_add_df$last_name)
  total_drop_df$name <- paste0(total_drop_df$first_name, " ", total_drop_df$last_name)
  # Generate plot of adds
  add_plot <- plotly::plot_ly(data = total_add_df, 
                              x = ~count, 
                              y = ~stats::reorder(name, count),
                              text = ~scales::comma(count), 
                              textposition = "auto",
                              type = "bar",
                              marker = list(color = "rgb(144, 238, 144)",
                                            line = list(color = "rgb(0 ,0, 0)",
                                                        width = 1.5)),
                              name = "Adds")
  # Style plot of adds
  add_plot_fin <- plotly::layout(add_plot, 
                                   yaxis = list(title = "Name"),
                                   xaxis = list(title = "Number of Adds"))
  # Generate plot of drops
  drop_plot <- plotly::plot_ly(data = total_drop_df, 
                      x = ~count, 
                      y = ~stats::reorder(name, count),
                      text = ~scales::comma(count), 
                      textposition = "auto",
                      type = "bar",
                      marker = list(color = "rgb(255, 0, 0)",
                                    line = list(color = "rgb(0 ,0, 0)",
                                                width = 1.5)),
                      name = "Drops")
  # Style plot of drops
  drop_plot_fin <- plotly::layout(drop_plot,
                                  yaxis = list(title = "Name",
                                              side = "right"),
                                  xaxis = list(title = "Number of Drops"))
  # Create a subplot to display both figures
  fig <- plotly::subplot(add_plot_fin, drop_plot_fin)
  # Add title to subplot layout and position legend to top center
  fig_fin <- plotly::layout(fig,
                    title = paste0("<b>", " Top ", limit, " Trending Adds/Drops in Past ", lookback_hours, " Hours from ", Sys.time(), "</b>"),
                    legend = list(orientation = "h",
                                  xanchor = "center",
                                  x = 0.5,
                                  y = -0.1))
  # Return final subplot
  return(fig_fin)
}
