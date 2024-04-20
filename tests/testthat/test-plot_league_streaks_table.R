# Unit tests for plot_league_streaks_table function

# Test 1: ensure font_color input is a string
test_that("ensure font_color argument is a string", {
  expect_error(plot_league_streaks_table(688281863499907072,
                                         font_color = 2),
               "Font color and win/loss streak font color arguments must be strings.") # nolint
})
# Test 2: good function call returns a data table
test_that("good function call returns a data table", {
  expect_equal(class(plot_league_streaks_table(688281863499907072)),
               c("datatables", "htmlwidget"))
})
# Test 3: ensure win_streak_font_color input is a string
test_that("ensure win_streak_font_color argument is a string", {
  expect_error(plot_league_streaks_table(688281863499907072,
                                         win_streak_font_color = TRUE),
               "Font color and win/loss streak font color arguments must be strings.") # nolint
})
# Test 4: ensure lose_streak_font_color input is a string
test_that("ensure lose_streak_font_color argument is a string", {
  expect_error(plot_league_streaks_table(688281863499907072,
                                         lose_streak_font_color = TRUE),
               "Font color and win/loss streak font color arguments must be strings.") # nolint
})
