# Unit tests for plot_nfl_player_high_school_state function

# Test 1: Verify that title input is a string
test_that("verify that title input is string", {
  expect_error(plot_nfl_player_high_school_state(2),
               "Title argument must be a string.")
})
