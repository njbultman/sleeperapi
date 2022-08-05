# Unit tests for get_trending_players function

# Test 1: Valid inputs return a data frame
test_that("Valid inputs return data frame", {
  expect_equal(class(get_trending_players("nfl", "add", 24, 25)), "data.frame")
})

# Test 2: Invalid sport parameter informs user
test_that("Invalid sport parameter informs user", {
  expect_error(get_trending_players(2, "add", 24, 25), "sport parameter should be of character type")
})

# Test 3: Invalid type parameter informs user
test_that("Invalid type parameter informs user", {
  expect_error(get_trending_players("nfl", "fail", 24, 25), "type parameter should be 'add' or 'drop'")
})

# Test 4: Invalid lookback_hours parameter informs user
test_that("Invalid lookback_hours parameter informs user", {
  expect_error(get_trending_players("nfl", "add", "fail", 25), "lookback_hours parameter should be of numeric type")
})

# Test 5: Invalid limit parameter informs user
test_that("Invalid limit parameter informs user", {
  expect_error(get_trending_players("nfl", "add", 24, "fail"), "limit parameter should be of numeric type")
})

# Test 6: Zero length returned object informs user
test_that("Invalid inputs informs user", {
  expect_message(get_trending_players("nfl", "add", 24, 0), "No data was returned - are you sure all parameters were inputted correctly?")
})
