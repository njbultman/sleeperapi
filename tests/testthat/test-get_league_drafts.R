# Tests for get_league_drafts function

# Test 1: Invalid league ID returns a message informing user
test_that("Invalid league ID returns a message informing user", {
  expect_message(get_league_drafts(-777), "No data found - was the league ID entered correctly?")
})
