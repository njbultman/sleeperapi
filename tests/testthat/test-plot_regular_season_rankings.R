# Unit tests for the plot_regular_season_rankings function

# Test 1: ensure title and tick color inputs are strings
test_that("ensure title and tick color both are strings", {
  expect_error(plot_regular_season_rankings(688281863499907072,
                                            title = 1,
                                            tick_color = 2),
               "Title and tick_color must both be strings.")
})
