# Unit tests for get_matchups function

# Test 1: Invalid week type informs user
test_that("invalid week type informs user and returns nothing", {
  expect_error(get_matchups(688281863499907072, "2"), "week paramater must be numeric")
})

# Test 2: Valid league ID and matchup week returns a data frame
test_that("Valid league ID and matchup week returns a data frame", {
  expect_equal(class(get_matchups(688281863499907072, 2)), "data.frame")
})
