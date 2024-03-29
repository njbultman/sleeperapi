# Unit tests for the plot_trending_players_table function

# Test 1: Ensure limit is less than or equal to 50
test_that("limit is less than or equal to 50", {
  expect_error(plot_trending_players_table(lookback_hours = 24,
                                           limit = 51,
                                           font_color = "black"),
               "Limit should be less than or equal to 50")
})
