# Unit tests for plot_trending_players function

# Test 1: Good function call returns plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_trending_players()),
               c("plotly", "htmlwidget"))
})
