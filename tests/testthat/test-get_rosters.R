# Unit tests for get_rosters function

# Test 1: Valid league ID returns a data frame
test_that("returns a data frame", {
  expect_equal(class(get_rosters(688281863499907072)), "data.frame")
})

# Test 2: Invalid league ID returns nothing and informs user
test_that("Invalid league ID informs user", {
  expect_message(get_rosters(-777), "League ID did not return any results. Did you enter the league ID correctly?")
})
