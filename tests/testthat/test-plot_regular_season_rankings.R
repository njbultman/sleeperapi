# Unit tests for the plot_regular_season_rankings function

# Test 1: ensure title and tick color inputs are strings
test_that("ensure title and tick color both are strings", {
  expect_error(plot_regular_season_rankings(688281863499907072,
                                            title = 1,
                                            tick_color = 2),
               "Title and tick color must both be strings.")
})
# Test 2: Good function call returns a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_regular_season_rankings(688281863499907072)),
               c("plotly", "htmlwidget"))
})