# Unit tests for plot_generate_nfl_player_data function

# Test 1: Clean function call returns message informing user it was successful
test_that("good function call informs user", {
  expect_equal(plot_generate_nfl_player_data(),
               "NFL data generation successful.")
})
