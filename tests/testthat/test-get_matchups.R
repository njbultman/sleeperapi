# Unit tests for get_matchups function

# Test 1: Valid league ID and week returns a data frame
test_that("returns a data frame", {
  expect_equal(inherits(get_matchups(688281863499907072, 2), "data.frame"), TRUE)
})

# Test 2: Invalid week type informs user
test_that("invalid week type informs user and returns nothing", {
  expect_error(get_matchups(688281863499907072, "2"), "week paramater must be numeric")
})

# Test 3: Valid league ID and valid week returns a list, so need to inform user
test_that("Valid league ID and invalid week informs user", {
  expect_message(get_matchups(688281863499907072, 25), "No data found. Was the week entered a valid week in terms of your season settings?")
})

# Test 4: Invalid league ID and valid week returns null, so need to inform user
test_that("Valid league ID and invalid week informs user", {
  expect_message(get_matchups(-777, 2), "No data found. Was the league ID entered correctly?")
})
