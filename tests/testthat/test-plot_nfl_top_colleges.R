# Unit tests for plot_nfl_top_colleges function

# Test 1: Verify that title input is a string
test_that("verify that title input is string", {
  expect_error(plot_nfl_top_colleges(title = 2),
               "Title and tick color arguments must be strings.")
})
# Test 2: Good function call returns a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_nfl_top_colleges()),
               c("plotly", "htmlwidget"))
})
