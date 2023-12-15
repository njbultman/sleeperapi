# Tests for get_league_drafts function

# Test 1: Invalid league ID returns a message informing user
test_that("Invalid league ID returns a message informing user", {
  expect_message(get_league_drafts(-777), "No data found - was the league ID entered correctly?")
})

# Test 2: Valid league ID returns a data frame
test_that("Valid league ID returns a data frame", {
  expect_equal(class(get_league_drafts(688281863499907072)), "data.frame")
})