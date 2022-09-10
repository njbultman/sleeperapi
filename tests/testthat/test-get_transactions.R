# Unit tests for get_transactions function

# Test 1: Invalid round type throws error
test_that("invalid round type throws error", {
  expect_error(get_transactions(688281863499907072, "2"), "round parameter must be of type numeric")
})
