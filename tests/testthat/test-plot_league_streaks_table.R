# Unit tests for plot_league_streaks_table function

# Test 1: ensure font_color input is a string
test_that("ensure font_color argument is a string", {
  expect_error(plot_league_streaks_table(688281863499907072,
                                         font_color = 2),
               "Font color argument must be a string.")
})
# Test 2: good function call returns a data table
test_that("good function call returns a data table", {
  expect_equal(class(plot_league_streaks_table(688281863499907072)),
               c("datatables", "htmlwidget"))
})
