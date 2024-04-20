# Unit tests for the plot_league_dashboard function

# Test 1: Invalid league ID throws error
test_that("invalid league ID throws error", {
  expect_error(plot_league_dashboard(-777),
               "Dashboard generation halted due to invalid league ID.") # nolint
})
