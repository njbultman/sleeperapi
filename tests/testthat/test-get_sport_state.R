# Unit tests for get_sport_state function

# Test 1: Invalid sport parameter type informs the user
test_that("Invalid sport type informs user", {
  expect_error(get_sport_state(1), "sport parameter must be of type character")
})
# Test 2: Valid function call returns list
test_that("valid function call returns list", {
  expect_equal(class(get_sport_state("nfl")), "list")
})
# Test 3: Invalid sport parameter errors and informs user
test_that("Invalid sport parameter informs user", {
  expect_error(get_sport_state("error"), "No data was returned. Was the sport correctly specified according to the API documentation?")
})

