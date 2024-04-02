#' Plot User Waiver Budget
#'
#' Given the league ID and display name, plot the current waiver budget
#' for the user (meaning total waiver budget available versus how much
#' the user has remaining).
#'
#' @return Returns a plot containing the waiver budget status.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, January 2024
#' @keywords league rankings regular season
#' @importFrom plotly plot_ly layout
#' @export
#' @examples
#' \dontrun{plot_user_waiver_budget(688281863499907072, "njbultman74")}
#' \dontrun{plot_user_waiver_budget(688281863499907072, "datcommish", title = "test", tick_color = "green", budget_total_line_color = "red")}
#'
#' @param league_id League ID assigned by Sleeper (numeric).
#' @param display_name Display name created by user (string).
#' @param title Title for plot, which can include HTML formatting (string).
#' @param tick_color Font color, name or hex, for display names (string).
#' @param budget_total_line_color Font color, name or hex (string).
#'
plot_user_waiver_budget <- function(league_id,
                                    display_name,
                                    title = "<b> Waiver Budget</b>", # nolint
                                    tick_color = "black",
                                    budget_total_line_color = "black") {
  # Check to see if title, display_name, tick_color, and budget line color are strings
  if (!is.character(title) || !is.character(display_name) || !is.character(tick_color) || !is.character(budget_total_line_color)) { # nolint
    # Error and inform user if all are not strings
    stop("Title, display name, tick color, and budget line color must all be strings.")
  } else {
    # Obtain master plotting data frame from league ID
    master_df <- get_main_data(league_id)
    # If nothing is returned for master data frame, return nothing
    # A message already informs user of error in get_main_data function
    # Subset master_df to owner_id specified
    owner_df <- master_df[master_df["display_name"] == display_name, ]
    # Calcualte remaining waiver budget
    owner_df$waiver_budget_remaining <- owner_df$waiver_budget - owner_df$waiver_budget_used # nolint
    # Generate plot of regular season rankings
    fig <- plotly::plot_ly(data = owner_df,
                           x = ~display_name,
                           y = ~waiver_budget_remaining,
                           text = ~waiver_budget_remaining,
                           textposition = "auto",
                           insidetextanchor = "middle",
                           type = "bar",
                           marker = list(color = "#00ff00",
                                         line = list(color = "black",
                                                     width = 3)))
    # Style plot of regular season rankings
    fig_fin <- plotly::layout(fig,
                              title = title,
                              shapes = list(
                                list(
                                  type = "line",
                                  x0 = 0,
                                  x1 = 1,
                                  xref = "paper",
                                  y0 = owner_df$waiver_budget,
                                  y1 = owner_df$waiver_budget,
                                  line = list(color = budget_total_line_color)
                                )
                              ),
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