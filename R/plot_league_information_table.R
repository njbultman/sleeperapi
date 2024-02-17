#' Plot League Information Table
#'
#' Given the league ID, generate a table showing team names and
#' their associated statistics (wins, losses, points for/against, etc.).
#'
#' @return Returns a table containing team names and
#'         their associated statistics.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, January 2024
#' @keywords league information statistics
#' @importFrom DT datatable formatStyle styleInterval styleColorBar
#' @importFrom dplyr arrange
#' @importFrom stats quantile
#' @importFrom grDevices colorRampPalette
#' @importFrom RColorBrewer brewer.pal
#' @export
#' @examples
#' \dontrun{plot_league_information_table(688281863499907072)}
#' \dontrun{plot_league_information_table(688281863499907072, font_color = "#ee5050")}
#'
#' @param league_id League ID generated from Sleeper (numeric).
#' @param font_color Font color, hex code or name. Default is "black" (string).
#'
plot_league_information_table <- function(league_id, font_color = "black") {
  # Check if font_color is a string
  if (!is.character(font_color)) {
    # Error and inform user if not a string
    stop("Font color argument must be a string.")
  } else {
    # Obtain master plotting data frame from league ID
    master_df <- get_main_data(league_id)
    # If nothing is returned for master data frame, return nothing
    # A message already informs user of error in plot_generate_master_data
    if (is.null(master_df)) {
      return(NULL)
    } else {
      # Generate javascript based on font_color specified
      js_dt <- paste0("function(settings, json) {$(this.api().table().body()).css({'color': '",  # nolint
                      font_color,
                      "'});$(this.api().table().header()).css({'color': '",
                      font_color,
                      "'})}")
      # If a data frame is returned, sort it by wins
      master_df_sort <- dplyr::arrange(master_df, -master_df$wins)
      # Generate breaks & colors for wins & losses
      brkswins <- stats::quantile(master_df_sort$wins,
                                  probs = seq(0.05, 0.95, 0.05),
                                  na.rm = TRUE)
      clrswins <- grDevices::colorRampPalette(RColorBrewer::brewer.pal(name = "RdYlGn", n = 11))(length(brkswins) + 1) # nolint
      brkslosses <- stats::quantile(master_df_sort$losses,
                                    probs = seq(0.05, 0.95, 0.05),
                                    na.rm = TRUE)
      clrslosses <- rev(grDevices::colorRampPalette(RColorBrewer::brewer.pal(name = "RdYlGn", n = 11))(length(brkslosses) + 1)) # nolint
      # Create base table
      fig <- DT::datatable(master_df_sort[, c("team_name",
                                              "display_name",
                                              "record",
                                              "wins",
                                              "losses",
                                              "ties",
                                              "fpts_total",
                                              "fpts_against_total")],
                           colnames = c("Team Name",
                                        "Display Name",
                                        "Record",
                                        "Wins",
                                        "Losses",
                                        "Ties",
                                        "Fantasy Points For",
                                        "Fantasy Points Against"),
                           options = list(pageLength = 100,
                                          initComplete = htmlwidgets::JS(js_dt),
                                          dom = "t"),
                           rownames = FALSE)
      # Format fantasy points (green bar with height based on points)
      fig_format1 <- DT::formatStyle(fig,
                                     "fpts_total",
                                     background = DT::styleColorBar(range(master_df_sort$fpts_total), # nolint
                                                                    "lightgreen"), # nolint
                                     backgroundSize = "98% 88%",
                                     backgroundRepeat = "no-repeat",
                                     backgroundPosition = "center")
      # Format fantasy points against (red bar with height based on points)
      fig_format2 <- DT::formatStyle(fig_format1,
                                     "fpts_against_total",
                                     background = DT::styleColorBar(range(master_df_sort$fpts_total), # nolint
                                                                    "#ee5050"),
                                     backgroundSize = "98% 88%",
                                     backgroundRepeat = "no-repeat",
                                     backgroundPosition = "center")
      # Format wins based on number of them (more = green, less = red)
      fig_format3 <- DT::formatStyle(fig_format2,
                                     "wins",
                                     backgroundColor = DT::styleInterval(brkswins, clrswins)) # nolint
      # Format losses based on number of them (more = red, less = green)
      fig_fin_format <- DT::formatStyle(fig_format3,
                                        "losses",
                                        backgroundColor = DT::styleInterval(brkslosses, clrslosses)) # nolint
      # Return final table object
      return(fig_fin_format)
    }
  }
}