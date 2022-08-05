# Unit tests for get_user_drafts function

# Test 1: valid inputs return data frame
test_that("Valid inputs return data frame", {
  expect_equal(class(get_user_drafts(688556535013502976, "nfl", 2021)), "data.frame")
})

# Test 2: Invalid input type for sport parameter informs user
test_that("Invalid input type for sport parameter informs user", {
  expect_error(get_user_drafts(688556535013502976, 2, 2021), "sport parameter must be of type character")
})

# Test 3: Invalid input type for season parameter informs user
test_that("Invalid input type for season parameter informs user", {
  expect_error(get_user_drafts(688556535013502976, "nfl", "fail"), "season parameter must be of type numeric")
})

# Test 4: If zero length list returned, inform user
test_that("If zero length list returned, inform user", {
  expect_message(get_user_drafts(-777, "nfl", 2021), "No data was returned - are you sure all parameters were inputted correctly?")
})
