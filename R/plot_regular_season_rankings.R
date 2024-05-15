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
#' @importFrom dplyr arrange
#' @importFrom rlang .data
#' @export
#' @examples
#' \dontrun{plot_regular_season_rankings(688281863499907072)}
#' \dontrun{plot_regular_season_rankings(688281863499907072, title = "test", tick_color = "red")}
#'
#' @param league_id League ID assigned by Sleeper (numeric).
#' @param title Title for plot, which can include HTML formatting (string).
#' @param tick_color Font color, name or hex, for display names (string).
#' @param rank_high_fill Bar color, name or hex, for highest rank (string).
#' @param rank_low_fill Bar color, name or hex, for lowest rank (string).
#'
plot_regular_season_rankings <- function(league_id,
                                         title = "<b>Regular Season Rankings</b>", # nolint
                                         tick_color = "black",
                                         rank_high_fill = "lightgreen",
                                         rank_low_fill = "#f68383") {
  # Check to see if title, tick_color, rank_high_fill, and rank_low_fill both strings # nolint
  if (!is.character(title) || !is.character(tick_color) || !is.character(rank_high_fill) || !is.character(rank_low_fill)) { # nolint
    # Error and inform user if both not strings
    stop("Title, tick color, rank high fill, and rank low fill types must be strings") # nolint
  } else {
    # Obtain master plotting data frame from league ID
    master_df <- get_main_data(league_id)
    # If nothing is returned for master data frame, return nothing
    # A message already informs user of error in get_main_data function
    # Order data frame by rank_pts
    master_df_sort <- dplyr::arrange(master_df, .data$rank_fpts) # nolint
    # Generate colors for plot
    colors_rank <- colorRampPalette(c(rank_high_fill, rank_low_fill))
    # Generate base plot
    fig <- plotly::plot_ly(data = master_df_sort,
                           x = ~rank_fpts,
                           y = ~stats::reorder(display_name, -rank_fpts),
                           text = ~rank_fpts,
                           textposition = "auto",
                           insidetextanchor = "middle",
                           type = "bar",
                           marker = list(color = colors_rank(nrow(master_df_sort)), # nolint
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