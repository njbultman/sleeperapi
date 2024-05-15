#' Plot User Weekly Players
#'
#' Given the league ID and display name, plot the total points scored by
#' week for each player ever associated with the display name.
#'
#' @return Returns a plot containing the display name's weekly players
#'         and their respective points for each week.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, May 2024
#' @keywords league user weekly matchups players
#' @importFrom plotly plot_ly layout
#' @importFrom stringr str_replace_all
#' @importFrom dplyr left_join summarize group_by bind_rows
#' @importFrom stats reorder
#' @importFrom rlang .data
#' @export
#' @examples
#' \dontrun{plot_user_weekly_players(688281863499907072, "datcommish")}
#'
#' @param league_id League ID assigned by Sleeper (numeric).
#' @param display_name Display name created by user (string).
#' @param title Title for plot, which can include HTML formatting (string).
#' @param tick_color Font color, name or hex, for players (string).
#'
plot_user_weekly_players <- function(league_id,
                                     display_name,
                                     title = paste0("<b>", display_name, ": Player Points by Week</b>"), # nolint
                                     tick_color = "inherit") {
  # Check to see if title, display_name, tick_color, and win/lose fill are strings # nolint
  if (!is.character(title) || !is.character(display_name) || !is.character(tick_color)) { # nolint
    # Error and inform user if all are not strings
    stop("Title, display name, and tick color must all be strings.") # nolint
  } else {
    # Obtain weekly matchups at team level
    weekly_players_df <- get_weekly_matchups(league_id, type = "player")
    # Filter to only include display name specified
    owner_df_1 <- weekly_players_df[weekly_players_df$display_name.x == display_name,  # nolint
                                    c("week", "display_name.x",
                                      "display_name.y", "team_name.x",
                                      "team_name.y", "starters_points.x",
                                      "starters_points.y", "tot_team_points.x",
                                      "tot_team_points.y", "team_win_loss.x",
                                      "team_win_loss.y", "full_name.x",
                                      "full_name.y")]
    names(owner_df_1) <- stringr::str_replace_all(names(owner_df_1), "\\.x", "")
    names(owner_df_1) <- stringr::str_replace_all(names(owner_df_1), "\\.y", ".rival") # nolint
    owner_df_2 <- weekly_players_df[weekly_players_df$display_name.y == display_name,  # nolint
                                    c("week", "display_name.x",
                                      "display_name.y", "team_name.x",
                                      "team_name.y", "starters_points.x",
                                      "starters_points.y", "tot_team_points.x",
                                      "tot_team_points.y", "team_win_loss.x",
                                      "team_win_loss.y", "full_name.x",
                                      "full_name.y")]
    names(owner_df_2) <- stringr::str_replace_all(names(owner_df_2), "\\.y", "")
    names(owner_df_2) <- stringr::str_replace_all(names(owner_df_2), "\\.x", ".rival") # nolint
    owner_df <- dplyr::bind_rows(owner_df_1, owner_df_2)
    # Arrange by week
    owner_df <- owner_df[order(owner_df$week),]
    # Add X-axis label for plot
    owner_df$label <- paste0("Week ", owner_df$week)
    # Get total points by player
    tot_player_points <- dplyr::summarize(dplyr::group_by(owner_df, .data$full_name), tot_player_points = sum(.data$starters_points)) # nolint
    owner_df <- dplyr::left_join(owner_df, tot_player_points, by = "full_name")
    # Get color palette
    color_palette <- colorRampPalette(RColorBrewer::brewer.pal(11, "Spectral"))(max(owner_df$week)) # nolint
    # Generate plot of player points by week
    fig <- plotly::plot_ly(data = owner_df,
                           x = ~stats::reorder(full_name, -tot_player_points),
                           y = ~starters_points,
                           color = ~stats::reorder(label, week),
                           colors = color_palette,
                           type = "bar")
    # Style plot of regular season rankings
    fig_fin <- plotly::layout(fig,
                              barmode = "stack",
                              title = title,
                              yaxis = list(title = "",
                                           tickfont = list(color = tick_color)),
                              xaxis = list(title = "",
                                           tickfont = list(color = tick_color)),
                              legend = list(font = list(color = tick_color)),
                              plot_bgcolor  = "rgba(0, 0, 0, 0)",
                              paper_bgcolor = "rgba(0, 0, 0, 0)")
    # Return figure
    return(fig_fin)
  }
}