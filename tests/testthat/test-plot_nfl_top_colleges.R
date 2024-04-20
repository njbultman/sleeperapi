# Unit tests for plot_nfl_top_colleges function

# Test 1: Verify that title input is a string
test_that("verify that title input is string", {
  expect_error(plot_nfl_top_colleges(title = 2),
               "Title, tick color, and fill color arguments must be strings.")
})
# Test 2: Good function call returns a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_nfl_top_colleges()),
               c("plotly", "htmlwidget"))
})
# Test 3: Verify that tick_color input is a string
test_that("verify that tick color input is string", {
  expect_error(plot_nfl_top_colleges(tick_color = 2),
               "Title, tick color, and fill color arguments must be strings.")
})
# Test 4: Verify that fill_color input is a string
test_that("verify that fill color input is string", {
  expect_error(plot_nfl_top_colleges(fill_color = TRUE),
               "Title, tick color, and fill color arguments must be strings.")
})
# Test 5: Verify that number input is numeric
test_that("verify that number input is numeric", {
  expect_error(plot_nfl_top_colleges(number = "hi"),
               "Number argument must be numeric.")
})
