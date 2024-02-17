# Unit tests for the plot_league_records_table function

# Test 1: if league ID is bad, ensure NULL is returned
test_that("bad league ID returns null", {
  expect_equal(plot_league_records_table(-777),
               NULL)
})
# Test 2: if league ID is bad, message informing user
test_that("bad league ID informs user", {
  expect_message(plot_league_records_table(-777),
                 "League ID did not return any results. Did you enter the league ID correctly?")
})
