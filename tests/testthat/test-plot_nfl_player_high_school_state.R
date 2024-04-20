# Unit tests for plot_nfl_player_high_school_state function

# Test 1: Verify that title input is a string
test_that("verify that title input is string", {
  expect_error(plot_nfl_player_high_school_state(2),
               "Title, high fill, and low fill arguments must be strings.")
})
# Test 2: Good function call returns a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_nfl_player_high_school_state()),
               c("plotly", "htmlwidget"))
})
# Test 3: Verify that high fill input is a string
test_that("verify that high fill input is string", {
  expect_error(plot_nfl_player_high_school_state(high_fill = TRUE),
               "Title, high fill, and low fill arguments must be strings.")
})
# Test 4: Verify that low fill input is a string
test_that("verify that high fill input is string", {
  expect_error(plot_nfl_player_high_school_state(high_fill = as.factor("test")),
               "Title, high fill, and low fill arguments must be strings.")
})
