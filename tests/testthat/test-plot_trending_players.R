# Unit tests for plot_trending_players function

# Test 1: Good function call returns plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_trending_players()),
               c("plotly", "htmlwidget"))
})
# Test 2: Check that error thrown if tick color not string
test_that("good function call returns plotly object", {
  expect_error(plot_trending_players(tick_color = 3),
               "Title and tick color must be strings.")
})
