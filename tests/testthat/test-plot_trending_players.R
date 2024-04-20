# Unit tests for plot_trending_players function

# Test 1: Good function call returns plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_trending_players()),
               c("plotly", "htmlwidget"))
})
# Test 2: Check that error thrown if tick color not string
test_that("bad tick color argument type returns error", {
  expect_error(plot_trending_players(tick_color = 3),
               "Title, tick color, drop fill, and add fill must be strings.")
})
# Test 3: Check that error thrown if drop fill not string
test_that("bad drop fill argument type returns error", {
  expect_error(plot_trending_players(drop_fill = 3),
               "Title, tick color, drop fill, and add fill must be strings.")
})
# Test 4: Check that error thrown if add fill not string
test_that("bad add fill argument type returns error", {
  expect_error(plot_trending_players(add_fill = TRUE),
               "Title, tick color, drop fill, and add fill must be strings.")
})
