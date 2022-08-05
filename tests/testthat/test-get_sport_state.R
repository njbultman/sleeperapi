# Unit tests for get_sport_state function

# Test 1: Valid sport string returns a list
test_that("Valid sport string returns list", {
  expect_equal(class(get_sport_state("nfl")), "list")
})

# Test 2: Invalid sport parameter type informs the user
test_that("Invalid sport type informs user", {
  expect_error(class(get_sport_state(1)), "sport parameter must be of type character")
})

# Test 3: Invalid sport string informs user and returns nothing
test_that("Invalid sport string informs user", {
  expect_message(get_sport_state("notasport"), "No data was returned. Was the sport correctly specified according to the API documentation?")
})

