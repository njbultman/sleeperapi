#' Plot League Information Table
#'
#' Given the league ID, generate a table showing team names and their associated statistics (wins, losses, points for/against, etc.)
#'
#' @return Returns a table containing team names and their associated records.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, December 2023
#' @keywords league records statistics
#' @importFrom plotly plot_ly
#' @importFrom dplyr arrange
#' @export
#' @examples
#' \dontrun{plot_league_records_table(688281863499907072)}
#'
#' @param league_id League ID generated from Sleeper (numeric).
#'
plot_league_records_table <- function(league_id) {
    # Obtain master plotting data frame from league ID
    master_df <- plot_generate_master_data(league_id)
    # If nothing is returned for master data frame, return nothing
    # A message already informs user of error in plot_generate_master_data
    if(is.null(master_df)) {
        return(NULL)
    } else {
        # If a data frame is returned, sort it by rank_fpts
        master_df_sort <- dplyr::arrange(master_df, rank_fpts)
        # Generate and return table
        fig <- plotly::plot_ly(
            type = "table",
            header = list(
                values = c("<b>Team Name </b>",
                            "<b>Display Name</b>",
                            "<b>Division</b>", 
                            "<b>Record</b>",
                            "<b>Wins</b>",
                            "<b>Losses</b>",
                            "<b>Ties</b>",
                            "<b>Total Fantasy Points For</b>",
                            "<b>Total Fantasy Points Against</b>",
                            "<b>Streak</b>"),
                align = c("center", "center"),
                fill = list(color = c("#01092e", "#01092e")),
                font = list(color = "white")
            ),
            cells = list(
                values = rbind(master_df_sort$team_name,
                                master_df_sort$display_name,
                                master_df_sort$division, 
                                master_df_sort$record,
                                master_df_sort$wins,
                                master_df_sort$losses,
                                master_df_sort$ties,
                                master_df_sort$fpts_total,
                                master_df_sort$fpts_against_total,
                                master_df_sort$streak),
                align = c("center", "center"),
                fill = list(color = c("#213251", "#213251")),
                font = list(color = "white")
            ))
        return(fig)
    }
}