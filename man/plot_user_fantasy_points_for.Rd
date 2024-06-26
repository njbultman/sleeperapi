% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_user_fantasy_points_for.R
\name{plot_user_fantasy_points_for}
\alias{plot_user_fantasy_points_for}
\title{Plot User Fantasy Points For}
\usage{
plot_user_fantasy_points_for(
  league_id,
  display_name,
  title = "<b>Total Fantasy Points For by User</b>",
  tick_color = "black",
  user_fill = "#f68383",
  other_fill = "lightgrey"
)
}
\arguments{
\item{league_id}{League ID assigned by Sleeper (numeric).}

\item{display_name}{Display name created by user (string).}

\item{title}{Title for plot, which can include HTML formatting (string).}

\item{tick_color}{Font color, name or hex, for display names (string).}

\item{user_fill}{Bar color, name or hex, for display name specified (string).}

\item{other_fill}{Bar color, name or hex, for other display names (string).}
}
\value{
Returns a plot containing the total fantasy points for by user.
}
\description{
Given the league ID and display name, plot the current total fantasy
points for that user while also plotting the current total fantasy
points for the rest of the league, with the specified user's bar
colored in a different color than the others (assuming the colors
are not set to the same by the user).
}
\examples{
\dontrun{plot_user_fantasy_points_for(688281863499907072, "njbultman74")}

}
\author{
Nick Bultman, \email{njbultman74@gmail.com}, March 2024
}
\keyword{fantasy}
\keyword{league}
\keyword{points}
\keyword{user}
