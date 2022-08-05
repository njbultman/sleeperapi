# Unit tests for get_user_leagues function

# Test 1: Valid inputs return a data frame
test_that("Valid inputs return a data frame", {
  expect_equal(class(get_user_leagues(688556535013502976)), "data.frame")
})

# Test 2: Invalid input type for sport parameter informs user
test_that("Invalid input type for sport parameter informs user", {
  expect_error(get_user_leagues(688556535013502976, sport = 2, season = 2021), "sport parameter must be of type character")
})

# Test 3: If zero length list returned, inform user
test_that("If zero length list returned, inform user", {
  expect_message(get_user_leagues(-777, sport = "nfl", season = "2021"), "No data was returned - are you sure all parameters were inputted correctly?")
})

