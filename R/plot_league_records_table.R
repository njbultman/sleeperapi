#' Plot League Records Table
#'
#' Given the league ID, generate a table showing team
#' names and their associated records.
#'
#' @return Returns a table containing team names and their associated records.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, December 2023
#' @keywords league records statistics
#' @importFrom DT datatable styleColorBar styleInterval formatStyle
#' @importFrom grDevices colorRampPalette
#' @importFrom dplyr arrange
#' @importFrom RColorBrewer brewer.pal
#' @export
#' @examples
#' \dontrun{plot_league_records_table(688281863499907072)}
#'
#' @param league_id League ID generated from Sleeper (numeric).
#' @param font_color Font color, hex code or name. Default is "inherit" (string).
#'
plot_league_records_table <- function(league_id, font_color = "inherit") {
  # Obtain master plotting data frame from league ID
  master_df <- get_main_data(league_id)
  # If nothing is returned for master data frame, return nothing
  # A message already informs user of error in plot_generate_master_data
  if (is.null(master_df)) {
    return(NULL)
  } else {
    # If a data frame is returned, sort it by wins
    master_df_sort <- dplyr::arrange(master_df, -master_df$wins)
    # Generate quantiles for wins, losses, and ties
    brkswins <- quantile(master_df_sort$wins, probs = seq(0.05, 0.95, 0.05), na.rm = TRUE) # nolint
    clrswins <- grDevices::colorRampPalette(RColorBrewer::brewer.pal(name = "RdYlGn", n = 11))(length(brkswins) + 1) # nolint
    brkslosses <- quantile(master_df_sort$losses, probs = seq(0.05, 0.95, 0.05), na.rm = TRUE) # nolint
    clrslosses <- rev(grDevices::colorRampPalette(RColorBrewer::brewer.pal(name = "RdYlGn", n = 11))(length(brkslosses) + 1)) # nolint
    # Generate javascript based on font_color specified
    js_dt <- paste0("function(settings, json) {$(this.api().table().body()).css({'color': '",  # nolint
                    font_color,
                    "'});$(this.api().table().header()).css({'color': '",
                    font_color,
                    "'});$('.dataTables_info').css({'color': '",
                    font_color,
                    "'});$('.dataTables_filter').css({'color': '",
                    font_color,
                    "'});$('.dataTables_length').css({'color': '",
                    font_color,
                    "'});$('.dataTables_paginate').css({'color': '",
                    font_color,
                    "'})}")
    # Generate and return base table
    fig <- DT::datatable(master_df_sort[, c("team_name",
                                            "display_name",
                                            "record",
                                            "wins",
                                            "losses",
                                            "ties",
                                            "fpts_total",
                                            "fpts_against_total",
                                            "streak")],
      colnames = c("Team Name",
                   "Display Name",
                   "Record",
                   "Wins",
                   "Losses",
                   "Ties",
                   "Fantasy Points For",
                   "Fantasy Points Against",
                   "Streak"),
      options = list(pageLength = 100,
                     initComplete = htmlwidgets::JS(js_dt)),
      rownames = FALSE,
    )
    # Add green color bar to total fantasy points column
    fig_2 <- DT::formatStyle(fig, "fpts_total",
                             background = DT::styleColorBar(range(master_df_sort$fpts_total), "lightgreen"), # nolint
                             backgroundSize = "98% 88%",
                             backgroundRepeat = "no-repeat",
                             backgroundPosition = "center")
    # Add red color bar to total fantasy points against column
    fig_3 <- DT::formatStyle(fig_2, "fpts_against_total",
                             background = DT::styleColorBar(range(master_df_sort$fpts_total), "#ee5050"), # nolint
                             backgroundSize = "98% 88%",
                             backgroundRepeat = "no-repeat",
                             backgroundPosition = "center")
    # Add shaded green colors based on wins for column of wins
    fig_4 <- DT::formatStyle(fig_3, "wins",
                             backgroundColor = DT::styleInterval(brkswins, clrswins) # nolint
    )
    # Add shaded red colors based off losses for column of losses
    fig_fin <- DT::formatStyle(fig_4, "losses",
                               backgroundColor = DT::styleInterval(brkslosses, clrslosses) # nolint
    )
    return(fig_fin)
  }
}