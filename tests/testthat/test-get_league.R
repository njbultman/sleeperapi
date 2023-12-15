# Unit tests for get_league function

# Test 1: Invalid league ID returns a message informing user
test_that("Invalid league ID prints a message informing user", {
  expect_message(get_league(-777), "League ID did not return any results. Did you enter the league ID correctly?")
})

# Test 2: Valid league ID returns a data frame
test_that("Valid league ID returns a data frame object", {
  expect_equal(class(get_league(688281863499907072)), "data.frame")
})
