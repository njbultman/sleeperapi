#' Gather NFL Player Data
#'
#' Gather all information concerning NFL players in list or data frame. Per Sleeper, this should be called once 
#' per day at most given the amount of data that it returns. By modifying the 'clean' parameter, either a
#' data frame will be returned or a list. When 'clean' is TRUE, a data frame will be returned. Note that while
#' most data is returned for the data frame, metadata will not be due to its dynamic nature. For example, 
#' metadata can be data frames on their own, so attempting to put them in a single data frame is not feasible. 
#' Moreover, some data in an observation is concatenated together to ensure each piece of an observation fits 
#' into its appropriate column within the observation of the data frame. For example, a player can have multiple
#' positions listed, so these would be concatenated together in a single column for that observation. If either 
#' of these pieces will be problematic for you, it is recommended to keep 'clean' set to FALSE and parse the 
#' default list as you see fit. Lastly, note that when 'clean' is TRUE, the transformation process to go from
#' a list to a data frame does take some time, so do not worry if the function is taking a while to run.
#'
#' @return Returns a list or data frame containing information about the NFL players.
#' @author Nick Bultman, \email{njbultman74@@gmail.com}, December 2021
#' @keywords nfl players
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom plyr rbind.fill
#' @export
#' @examples
#' \dontrun{get_all_nfl_players(clean = FALSE)}
#' \dontrun{get_all_nfl_players(clean = TRUE)}
#' 
#' @param clean Specifies whether a data frame or the default list will be returned (logical)
#'
get_all_nfl_players <- function(clean = FALSE) {
  # Check if clean parameter is logical
  if(!is.logical(clean)) {
    # If not logical, inform user and halt the function
    stop("Parameter 'clean' must be logical (TRUE or FALSE)")
  }
  # Send request to API
  x <- jsonlite::fromJSON(httr::content(httr::GET(paste0("https://api.sleeper.app/v1/players/nfl")), as = "text"))
  # Check if parameter 'clean' is FALSE. If so, return default list
  if(clean == FALSE) {
    return(x)
  # If parameter 'clean' is TRUE, go through cleaning process to prepare data frame
  } else if(clean == TRUE) {
  # Loop through list of data to get variable names - store in data frame
  num_vars_lists <- as.data.frame(sapply(x, function(x) length(names(x))))
  # Rename new column created in data frame
  names(num_vars_lists) <- "len"
  # Find maximum amount of variables returned out of each list element in larger list
  index_max_vars <- which(num_vars_lists$len == max(num_vars_lists$len))[1]
  # Store largest vector of names for data frame that will ultimately be returned
  df_names <- names(x[[index_max_vars]])
  # Create final empty data frame to be returned - including instantiating column names
  df <- data.frame(matrix(ncol = length(df_names), nrow = 0))
  names(df) <- df_names
  # Loop through each list within the list to extract data
  for(list in x) {
    # Set metadata to NULL - given dynamic nature of metadata, not feasible currently to put into data frame
    list[['metadata']] <- NULL
    # Loop through each embedded list of values and concatenate values that will be placed into data frame observation
    for(val in 1:length(list)) {
      list[[val]] <- paste0(list[[val]], collapse = ",")
    }
    # Convert NULL to NA
    list[sapply(list, is.null)] <- NA
    # Bind observation in loop to final data frame
    df <- plyr::rbind.fill(df, as.data.frame(list, stringsAsFactors = FALSE))
  }
  # Return final data frame
  return(df)
  }
}
