# Unit tests for get_sport_state function

# Test 1: Invalid sport parameter type informs the user
test_that("Invalid sport type informs user", {
  expect_error(class(get_sport_state(1)), "sport parameter must be of type character")
})

