# Unit tests for get_transactions function

# Test 1: Valid league ID and round return a data frame
test_that("returns a data frame", {
  expect_equal(class(get_transactions(688281863499907072, 2)), "data.frame")
})

# Test 2: Invalid round type throws error
test_that("invalid round type throws error", {
  expect_error(get_transactions(688281863499907072, "2"), "round parameter must be of type numeric")
})

# Test 3: Invalid league ID informs user and returns nothing
test_that("valid league ID informs user", {
  expect_message(get_transactions(-777, 2), "No data found. Were the league ID and round entered correctly?")
})
