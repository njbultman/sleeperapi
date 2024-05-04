# Unit tests for plot_user_weekly_players function

# Test 1: Valid inputs return a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_user_weekly_players(688281863499907072,
                                               "njbultman74")
               ),
               c("plotly", "htmlwidget"))
})
# Test 2: Invalid display name type throws error
test_that("bad display name argument type throws error", {
  expect_error(plot_user_weekly_players(688281863499907072,
                                        2),
               "Title, display name, and tick color must all be strings.") # nolint
})
# Test 3: Invalid tick color type throws error
test_that("bad tick color argument type throws error", {
  expect_error(plot_user_weekly_players(688281863499907072,
                                        display_name = "njbultman74",
                                        tick_color = TRUE),
               "Title, display name, and tick color must all be strings.") # nolint
})