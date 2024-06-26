% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_trending_players_table.R
\name{plot_trending_players_table}
\alias{plot_trending_players_table}
\title{Plot Trending NFL Player Information in Table}
\usage{
plot_trending_players_table(
  lookback_hours = 24,
  limit = 10,
  font_color = "inherit",
  drop_fill = "#f68383",
  add_fill = "lightgreen"
)
}
\arguments{
\item{lookback_hours}{Number of hours to look back (numeric).}

\item{limit}{Number of players returned for add/drop. Should be less than 50 (numeric).}

\item{font_color}{Font color, name or hex (string).}

\item{drop_fill}{Bar color, name or hex, for drops (string).}

\item{add_fill}{Bar color, name or hex, for adds (string).}
}
\value{
Returns a plot containing information (name and
        count) about the trending NFL players.
}
\description{
Given the number of hours to look back, and a limit of
how many players to return, display a figure showing the
top additions and drops in a table.
}
\examples{
\dontrun{plot_trending_players_table(lookback_hours = 24, limit = 10)}
\dontrun{plot_trending_players_table(lookback_hours = 24, limit = 10, font_color = "white")}

}
\author{
Nick Bultman, \email{njbultman74@gmail.com}, February 2024
}
\keyword{players}
\keyword{trending}
