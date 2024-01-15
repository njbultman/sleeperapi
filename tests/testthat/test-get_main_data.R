# Unit tests for get_main_data function

# Test 1: Valid league ID returns a data frame
test_that("Valid league ID returns a data frame", {
  expect_equal(class(get_main_data(688281863499907072)), "data.frame")
})

# Test 2: Invalid league ID prints a message informing user
test_that("Invalid league ID prints a message informing user", {
  expect_message(get_main_data(-777), "League ID did not return any results. Did you enter the league ID correctly?")
})
