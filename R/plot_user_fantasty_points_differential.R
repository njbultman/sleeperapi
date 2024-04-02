#' Plot User Fantasy Points Differential
#'
#' Given the league ID and display name, plot the current total fantasy
#' points for, against, and differential between the two together in one
#' bar chart.
#'
#' @return Returns a plot containing the total fantasy points
#'         differential by user.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, March 2024
#' @keywords league fantasy points user
#' @importFrom plotly plot_ly layout
#' @importFrom dplyr case_when
#' @importFrom tidyr pivot_longer
#' @export
#' @examples
#' \dontrun{plot_user_fantasy_points_differential(688281863499907072, "njbultman74")}
#' \dontrun{plot_user_fantasy_points_differential(688281863499907072, "datcommish", title = "test", tick_color = "green")}
#'
#' @param league_id League ID assigned by Sleeper (numeric).
#' @param display_name Display name created by user (string).
#' @param title Title for plot, which can include HTML formatting (string).
#' @param tick_color Font color, name or hex, for display names (string).
#'
plot_user_fantasy_points_differential <- function(league_id,
                                                  display_name,
                                                  title = paste0("<b>Fantasy Point Differential: ", display_name, "</b>"), # nolint
                                                  tick_color = "black") {
  # Check to see if title, display_name, and tick_color are strings
  if (!is.character(title) || !is.character(display_name) || !is.character(tick_color)) { # nolint
    # Error and inform user if all are not strings
    stop("Title, display name, and tick color must all be strings.")
  } else {
    # Obtain master plotting data frame from league ID
    master_df <- get_main_data(league_id)
    # If nothing is returned for master data frame, return nothing
    # A message already informs user of error in get_main_data function
    # Subset master_df for display name specified
    user_df <- master_df[master_df$display_name == display_name, ]
    # Create differential column
    user_df$fpts_differential <- user_df$fpts_total - user_df$fpts_against_total
    # Subset user_df to only necessary columns
    user_df_subset <- user_df[, c("display_name",
                                  "fpts_total",
                                  "fpts_against_total",
                                  "fpts_differential")]
    # Unpivot metrics
    user_df_long <- tidyr::pivot_longer(user_df_subset,
                                        -display_name)
    # Color the metrics
    user_df_long$color <- dplyr::case_when(user_df_long$name == "fpts_total" ~ "lightgreen", # nolint
                                           user_df_long$name == "fpts_against_total" ~ "#f68383", # nolint
                                           user_df_long$name == "fpts_differential" & user_df_long$value >= 0 ~ "lightgreen", # nolint
                                           TRUE ~ "#f68383")
    # Rename metrics
    user_df_long$name[user_df_long$name == "fpts_total"] <- "Total Fantasy Points" # nolint
    user_df_long$name[user_df_long$name == "fpts_against_total"] <- "Total Fantasy Points Against" # nolint
    user_df_long$name[user_df_long$name == "fpts_differential"] <- "Total Fantasy Points Differential" # nolint
    # Generate plot
    fig <- plotly::plot_ly(data = user_df_long,
                           x = ~value,
                           y = ~stats::reorder(name, value),
                           text = ~round(value, 2),
                           textposition = "auto",
                           insidetextanchor = "middle",
                           type = "bar",
                           orientation = 'h',
                           marker = list(color = user_df_long$color,
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