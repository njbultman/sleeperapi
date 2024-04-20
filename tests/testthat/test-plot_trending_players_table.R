# Unit tests for the plot_trending_players_table function

# Test 1: Ensure limit is less than or equal to 50
test_that("limit is less than or equal to 50", {
  expect_error(plot_trending_players_table(lookback_hours = 24,
                                           limit = 51,
                                           font_color = "black"),
               "Limit should be less than or equal to 50")
})
# Test 2: good function call returns a data table
test_that("good function call returns data table", {
  expect_equal(class(plot_trending_players_table()),
               c("datatables", "htmlwidget"))
})
# Test 3: Ensure font color is type character
test_that("bad font color argument type throws error", {
  expect_error(plot_trending_players_table(lookback_hours = 24,
                                           limit = 10,
                                           font_color = 1),
               "Font color, drop fill, and add fill arguments must be strings")
})
# Test 4: Ensure drop fill is type character
test_that("bad drop fill argument type throws error", {
  expect_error(plot_trending_players_table(lookback_hours = 24,
                                           limit = 10,
                                           drop_fill = 1),
               "Font color, drop fill, and add fill arguments must be strings")
})
# Test 5: Ensure add fill is type character
test_that("bad add fill argument type throws error", {
  expect_error(plot_trending_players_table(lookback_hours = 24,
                                           limit = 10,
                                           add_fill = 1),
               "Font color, drop fill, and add fill arguments must be strings")
})