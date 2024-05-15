#' Plot User Fantasy Points For
#'
#' Given the league ID and display name, plot the current total fantasy
#' points for that user while also plotting the current total fantasy
#' points for the rest of the league, with the specified user's bar
#' colored in a different color than the others (assuming the colors
#' are not set to the same by the user).
#'
#' @return Returns a plot containing the total fantasy points for by user.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, March 2024
#' @keywords league fantasy points user
#' @importFrom plotly plot_ly layout
#' @export
#' @examples
#' \dontrun{plot_user_fantasy_points_for(688281863499907072, "njbultman74")}
#'
#' @param league_id League ID assigned by Sleeper (numeric).
#' @param display_name Display name created by user (string).
#' @param title Title for plot, which can include HTML formatting (string).
#' @param tick_color Font color, name or hex, for display names (string).
#' @param user_fill Bar color, name or hex, for display name specified (string).
#' @param other_fill Bar color, name or hex, for other display names (string).
#'
plot_user_fantasy_points_for <- function(league_id,
                                         display_name,
                                         title = "<b>Total Fantasy Points For by User</b>", # nolint
                                         tick_color = "black",
                                         user_fill = "#f68383",
                                         other_fill = "lightgrey") {
  # Check to see if title, display name, and tick color are strings
  if (!is.character(title) || !is.character(display_name) || !is.character(tick_color) || !is.character(user_fill) || !is.character(other_fill)) { # nolint
    # Error and inform user if all are not strings
    stop("Title, display name, tick color, user fill, and other fill must all be strings.") # nolint
  } else {
    # Obtain master plotting data frame from league ID
    master_df <- get_main_data(league_id)
    # If nothing is returned for master data frame, return nothing
    # A message already informs user of error in get_main_data function
    # Create a vector for the colors
    master_df$color <- ifelse(master_df$display_name == display_name,
                              user_fill,
                              other_fill)
    # Generate plot of total fantasy points for
    fig <- plotly::plot_ly(data = master_df,
                           x = ~stats::reorder(display_name, -fpts_total),
                           y = ~fpts_total,
                           text = ~fpts_total,
                           textposition = "auto",
                           insidetextanchor = "middle",
                           type = "bar",
                           marker = list(color = master_df$color,
                                         line = list(color = "black",
                                                     width = 3)))
    # Style plot
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