# Tests for get_league_drafts function

# Test 1: Valid league ID returns a data frame
test_that("Valid league ID returns a data frame", {
  expect_equal(inherits(get_league_drafts(688281863499907072), "data.frame"), TRUE)
})

# Test 2: Invalid league ID returns a message informing user
test_that("Invalid league ID returns a message informing user", {
  expect_message(get_league_drafts(-777), "No data found - was the league ID entered correctly?")
})
