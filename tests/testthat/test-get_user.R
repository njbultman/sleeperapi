# Unit tests for get_user function

# Test 1: valid user ID returns a list
test_that("Valid user ID returns a list", {
  expect_equal(class(get_user(688556535013502976)), "list")
})

# Test 2: Invalid user ID informs user
test_that("Invalid user ID informs user", {
  expect_message(get_user(-777), "No data returned - are you sure the user ID was specified correctly?")
})
