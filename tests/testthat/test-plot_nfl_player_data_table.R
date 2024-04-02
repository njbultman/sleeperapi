# Unit tests for plot_nfl_player_data_table function

# Test 1: Verify that font color input is a string
test_that("verify that font color input is string", {
  expect_error(plot_nfl_player_data_table(2),
               "Font color argument must be a string.")
})
# Test 2: good function call returns a data table
test_that("good function call returns data table", {
  expect_equal(class(plot_nfl_player_data_table()),
               c("datatables", "htmlwidget"))
})
