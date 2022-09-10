# Unit tests for get_user function

# Test 1: Invalid user ID informs user
test_that("Invalid user ID informs user", {
  expect_message(get_user(-777), "No data returned - are you sure the user ID was specified correctly?")
})
