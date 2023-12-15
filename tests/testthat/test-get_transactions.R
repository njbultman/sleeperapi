# Unit tests for get_transactions function

# Test 1: Invalid round type throws error
test_that("Invalid round type throws error", {
  expect_error(get_transactions(688281863499907072, "2"), "round parameter must be of type numeric")
})

# Test 2: Valid league ID and round returns a data frame
test_that("Valid league ID and round returns a data frame", {
  expect_equal(class(get_transactions(688281863499907072, 2)), "data.frame")
})
