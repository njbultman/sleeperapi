#' Plot Regular Season League Rankings
#'
#' Given the league ID, plot the regular season league rankings. This is
#' done by assigning positive points to wins and negative points to losses
#' and then also adding in fantasy points for. The calculation can be seen
#' in the get_main_data function.
#'
#' @return Returns a plot containing the regular season league rankings.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, January 2024
#' @keywords league rankings regular season
#' @importFrom plotly plot_ly layout
#' @importFrom stats reorder
#' @export
#' @examples
#' \dontrun{plot_regular_season_rankings(688281863499907072)}
#' \dontrun{plot_regular_season_rankings(688281863499907072, title = "test", tick_color = "red")}
#'
#' @param league_id League ID assigned by Sleeper (numeric).
#' @param title Title for plot, which can include HTML formatting (string).
#' @param tick_color Font color, name or hex, for display names (string).
#'
plot_regular_season_rankings <- function(league_id,
                                         title = "<b>Regular Season Rankings</b>", # nolint
                                         tick_color = "black") {
  # Check to see if title and tick_color both strings
  if (!is.character(title) || !is.character(tick_color)) {
    # Error and inform user if both not strings
    stop("Title and tick color must both be strings.")
  } else {
    # Obtain master plotting data frame from league ID
    master_df <- get_main_data(league_id)
    # If nothing is returned for master data frame, return nothing
    # A message already informs user of error in get_main_data function
    # Generate base plot
    fig <- plotly::plot_ly(data = master_df,
                           x = ~rank_fpts,
                           y = ~stats::reorder(display_name, -rank_fpts),
                           text = ~rank_fpts,
                           textposition = "auto",
                           insidetextanchor = "middle",
                           type = "bar",
                           marker = list(color = ~-rank_fpts,
                                         colorscale = "YlOrRd",
                                         line = list(color = "rgb(0 ,0, 0)",
                                                     width = 1.5)),
                           orientation = "h")
    # Style plot
    fig_fin <- plotly::layout(fig,
                              title = title,
                              yaxis = list(title = "",
                                           tickfont = list(color = tick_color)),
                              xaxis = list(title = "", 
                                           visible = FALSE),
                              plot_bgcolor  = "rgba(0, 0, 0, 0)",
                              paper_bgcolor = "rgba(0, 0, 0, 0)")
    # Return figure
    return(fig_fin)
  }
}