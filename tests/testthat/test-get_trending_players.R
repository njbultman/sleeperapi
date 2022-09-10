# Unit tests for get_trending_players function

# Test 1: Invalid sport parameter informs user
test_that("Invalid sport parameter informs user", {
  expect_error(get_trending_players(2, "add", 24, 25), "sport parameter should be of character type")
})

# Test 2: Invalid type parameter informs user
test_that("Invalid type parameter informs user", {
  expect_error(get_trending_players("nfl", "fail", 24, 25), "type parameter should be 'add' or 'drop'")
})

# Test 3: Invalid lookback_hours parameter informs user
test_that("Invalid lookback_hours parameter informs user", {
  expect_error(get_trending_players("nfl", "add", "fail", 25), "lookback_hours parameter should be of numeric type")
})

# Test 4: Invalid limit parameter informs user
test_that("Invalid limit parameter informs user", {
  expect_error(get_trending_players("nfl", "add", 24, "fail"), "limit parameter should be of numeric type")
})

