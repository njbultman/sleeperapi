# Unit tests for get_user_leagues function

# Test 1: Invalid input type for sport parameter informs user
test_that("Invalid input type for sport parameter informs user", {
  expect_error(get_user_leagues(688556535013502976, sport = 2, season = 2021), "sport parameter must be of type character")
})

# Test 2: Valid inputs return a data frame
test_that("Valid inputs return a data frame", {
  expect_equal(class(get_user_leagues(688556535013502976, sport = "nfl", season = 2021)), "data.frame")
})