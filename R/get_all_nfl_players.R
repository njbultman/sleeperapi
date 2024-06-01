#' Gather NFL Player Data
#'
#' Gather all information concerning NFL players in list or data frame. Per Sleeper, this should be called once 
#' per day at most given the amount of data that it returns. By modifying the 'clean' parameter, either a
#' data frame will be returned or a list. When 'clean' is TRUE, a data frame will be returned. Note that while
#' most data is returned for the data frame, metadata will not be due to its dynamic nature. For example, 
#' metadata can be data frames on their own, so attempting to put them in a single data frame is not feasible. 
#' One might notice that a metadata column is present, but this is not properly cleanded since there could be NULLs, 
#' rookie years, injury overrides, or other miscellaneous columns that could add additional explanatory information. 
#' If either of these pieces will be problematic for you, it is recommended to keep 'clean' set to FALSE and parse 
#' the default list as you see fit.
#' 
#' @return Returns a list or data frame containing information about the NFL players.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, December 2021
#' @keywords nfl players
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr bind_rows
#' @importFrom purrr map_depth
#' @export
#' @examples
#' \dontrun{get_all_nfl_players(clean = FALSE)}
#' \dontrun{get_all_nfl_players(clean = TRUE)}
#'
#' @param clean Specifies whether a data frame or the default list will be returned (logical)
#'
get_all_nfl_players <- function(clean = FALSE) {
  # Check if clean parameter is logical
  if (!is.logical(clean)) {
    # If not logical, inform user and halt the function
    stop("Parameter 'clean' must be logical (TRUE or FALSE)")
  }
  # Send request to API
  x <- jsonlite::fromJSON(httr::content(httr::GET(paste0("https://api.sleeper.app/v1/players/nfl")), as = "text"))
  # Check if parameter 'clean' is FALSE. If so, return default list
  if (clean == FALSE) {
    return(x)
  # If parameter 'clean' is TRUE, go through cleaning process to prepare data frame
  } else if (clean == TRUE) {
    # Find unique lengths of lists within list and sort in descending order
    dist_lengths <- sort(unique(sapply(x, length)), decreasing = TRUE)
    # Convert all NULLs to NA (for preservation when using the unlist function later)
    x_null_to_na <- purrr::map_depth(x, 2, ~ifelse(is.null(.x), NA, .x))
    # Instantiate master data frame
    df_master <- data.frame()
    # Loop through differing list lengths
    for (i in dist_lengths) {
      # Obtain matrix of specific lists by length and append all records together
      x_mat <- do.call(rbind, Filter(function(x) length(x) == i, x_null_to_na))
      # Unlist matrix to obtain list
      list_temp <- apply(x_mat, MARGIN = 2, FUN = unlist, use.names = FALSE)
      # Check for NULL list objects
      test <- try(unlist(apply(list_temp, MARGIN = 2, FUN = is.null)),
                  silent = TRUE)
      if (inherits(test, "try-error")) {
        # Filter list and remove objects where only NULL
        list_temp <- Filter(Negate(is.null), list_temp)
      }
      # Convert list to data frame, keep strings as is (no factors)
      df_temp <- data.frame(list_temp, stringsAsFactors = FALSE)
      # Check if "active" column is in data frame
      if (any(names(df_temp) == "active")) {
        # Ensure "active" column is a character vector
        df_temp$active <- as.character(df_temp$active)
      }
      # Bind rows to master data frame
      df_master <- dplyr::bind_rows(df_master, df_temp)
    }
    # Return cleaned master data frame
    return(df_master)
  }
}
