#' Plot User Weekly Matchups
#'
#' Given the league ID and display name, plot the total points scored by
#' week for the display name and colored by whether the result was a win
#' or a loss. The x-axis labels show the opposing display name for that
#' specific week.
#'
#' @return Returns a plot containing the display name's weekly matchups.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, May 2024
#' @keywords league user weekly matchups
#' @importFrom plotly plot_ly layout
#' @importFrom stringr str_replace_all
#' @importFrom stats reorder
#' @importFrom dplyr bind_rows
#' @export
#' @examples
#' \dontrun{plot_user_weekly_matchups(688281863499907072, "datcommish")}
#'
#' @param league_id League ID assigned by Sleeper (numeric).
#' @param display_name Display name created by user (string).
#' @param title Title for plot, which can include HTML formatting (string).
#' @param tick_color Font color, name or hex, for weeks (string).
#' @param win_fill Fill color, name or hex, for wins (string).
#' @param lose_fill Fill color, name or hex, for losses (string).
#'
plot_user_weekly_matchups <- function(league_id,
                                      display_name,
                                      title = paste0("<b>", display_name, ": Weekly Matchups, Filled by Win/Loss</b>"), # nolint
                                      tick_color = "inherit",
                                      win_fill = "lightgreen",
                                      lose_fill = "#f68383") {
  # Check to see if title, display_name, tick_color, and win/lose fill are strings # nolint
  if (!is.character(title) || !is.character(display_name) || !is.character(tick_color) || !is.character(win_fill) || !is.character(lose_fill)) { # nolint
    # Error and inform user if all are not strings
    stop("Title, display name, tick color, and win/lose fill must all be strings.") # nolint
  } else {
    # Obtain weekly matchups at team level
    weekly_matchups_df <- get_weekly_matchups(league_id, type = "team")
    # Filter to only include display name specified
    owner_df_1 <- weekly_matchups_df[weekly_matchups_df$display_name.x == display_name,  # nolint
                                     c("week", "display_name.x",
                                       "display_name.y", "team_name.x",
                                       "team_name.y", "tot_points.x",
                                       "tot_points.y", "win_loss.x",
                                       "win_loss.y")]
    names(owner_df_1) <- stringr::str_replace_all(names(owner_df_1), "\\.x", "")
    names(owner_df_1) <- stringr::str_replace_all(names(owner_df_1), "\\.y", ".rival") # nolint
    owner_df_2 <- weekly_matchups_df[weekly_matchups_df$display_name.y == display_name,  # nolint
                                     c("week", "display_name.x",
                                       "display_name.y", "team_name.x",
                                       "team_name.y", "tot_points.x",
                                       "tot_points.y", "win_loss.x",
                                       "win_loss.y")]
    names(owner_df_2) <- stringr::str_replace_all(names(owner_df_2), "\\.y", "")
    names(owner_df_2) <- stringr::str_replace_all(names(owner_df_2), "\\.x", ".rival") # nolint
    owner_df <- dplyr::bind_rows(owner_df_1, owner_df_2)
    # Arrange by week
    owner_df <- owner_df[order(owner_df$week),]
    # Add X-axis label for plot
    owner_df$label <- paste0("Week ", owner_df$week,
                             ": vs. ", owner_df$display_name.rival)
    # Create color mappings
    owner_df$color <- ifelse(owner_df$win_loss == "W",
                             win_fill,
                             lose_fill)
    # Generate plot of regular season rankings
    fig <- plotly::plot_ly(data = owner_df,
                           x = ~stats::reorder(label, week),
                           y = ~tot_points,
                           text = ~tot_points,
                           textposition = "auto",
                           insidetextanchor = "middle",
                           type = "bar",
                           marker = list(color = owner_df$color,
                                         line = list(color = "black",
                                                     width = 3)))
    # Style plot of regular season rankings
    fig_fin <- plotly::layout(fig,
                              title = title,
                              yaxis = list(title = "",
                                           tickfont = list(color = tick_color)),
                              xaxis = list(title = "",
                                           tickfont = list(color = tick_color)),
                              plot_bgcolor  = "rgba(0, 0, 0, 0)",
                              paper_bgcolor = "rgba(0, 0, 0, 0)")
    # Return figure
    return(fig_fin)
  }
}