# Unit tests for plot_user_weekly_matchups function

# Test 1: Valid inputs return a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_user_weekly_matchups(688281863499907072,
                                               "njbultman74")
               ),
               c("plotly", "htmlwidget"))
})
# Test 2: Invalid display name type throws error
test_that("bad display name argument type throws error", {
  expect_error(plot_user_weekly_matchups(688281863499907072,
                                         2),
               "Title, display name, tick color, and win/lose fill must all be strings.") # nolint
})
# Test 3: Invalid tick color type throws error
test_that("bad tick color argument type throws error", {
  expect_error(plot_user_weekly_matchups(688281863499907072,
                                         display_name = "njbultman74",
                                         tick_color = 2),
               "Title, display name, tick color, and win/lose fill must all be strings.") # nolint
})
# Test 4: Invalid win fill type throws error
test_that("bad win fill argument type throws error", {
  expect_error(plot_user_weekly_matchups(688281863499907072,
                                         display_name = "njbultman74",
                                         win_fill = 2),
               "Title, display name, tick color, and win/lose fill must all be strings.") # nolint
})
# Test 5: Invalid win fill type throws error
test_that("bad lose fill argument type throws error", {
  expect_error(plot_user_weekly_matchups(688281863499907072,
                                         display_name = "njbultman74",
                                         lose_fill = TRUE),
               "Title, display name, tick color, and win/lose fill must all be strings.") # nolint
})
