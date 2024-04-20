#' Plot League Streaks Table
#'
#' Given the league ID, generate a table showing display names
#' and their associated streaks (2W, 5L, etc.). Note that the font
#' color for the streaks are currently at zero or greater = green
#' and L = red. The font color argument is used for the headers.
#'
#' @return Returns a table containing display names and their streaks.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, January 2024
#' @keywords league information statistics
#' @importFrom plotly plot_ly
#' @importFrom dplyr arrange
#' @importFrom tidyr pivot_wider
#' @export
#' @examples
#' \dontrun{plot_league_streaks_table(688281863499907072)}
#' \dontrun{plot_league_streaks_table(688281863499907072, font_color = "red")}
#'
#' @param league_id League ID generated from Sleeper (numeric).
#' @param font_color Header font color, hex code or name. Default is "inherit" (string).
#' @param win_streak_font_color Font color, hex code or name, for teams with winning streak (string).
#' @param lose_streak_font_color Font color, hex code or name, for teams with losing streak (string).
#'
plot_league_streaks_table <- function(league_id,
                                      font_color = "inherit",
                                      win_streak_font_color = "lightgreen",
                                      lose_streak_font_color = "#f68383") {
  # Check if font_color is a string
  if (!is.character(font_color) || !is.character(win_streak_font_color) || !is.character(lose_streak_font_color)) { # nolint
    # Error and inform user if not a string
    stop("Font color and win/loss streak font color arguments must be strings.")
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
                      "'});$('.dataTables_info').css({'color': '",
                      font_color,
                      "'});$('.dataTables_filter').css({'color': '",
                      font_color,
                      "'});$('.dataTables_length').css({'color': '",
                      font_color,
                      "'});$('.dataTables_paginate').css({'color': '",
                      font_color,
                      "'})}")
      # If a data frame is returned, sort it by wins
      master_df_sort <- dplyr::arrange(master_df, -master_df$wins)
      # Generate coloring for streaks
      master_df_sort$streak_format <- ifelse(master_df_sort$streak_ranking < 0,
                                             paste0('<font color="', lose_streak_font_color, '">', # nolint
                                                    master_df_sort$streak,
                                                    "</font>"),
                                             paste0('<font color="',  win_streak_font_color, '">', # nolint
                                                    master_df_sort$streak,
                                                    "</font>"))
      master_df_sort_selection <- master_df_sort[, c("display_name", "streak_format")] # nolint
      master_df_pivot <- tidyr::pivot_wider(master_df_sort_selection,
                                            names_from = "display_name",
                                            values_from = "streak_format")
      # Generate and return table
      fig <- DT::datatable(master_df_pivot,
                           escape = FALSE,
                           options = list(pageLength = 10,
                                          initComplete = htmlwidgets::JS(js_dt)), # nolint
                           rownames = FALSE)
      return(fig)
    }
  }
}