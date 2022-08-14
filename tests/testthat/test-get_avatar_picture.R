# Unit tests for the get_avatar_picture function

# Test 1: Valid User ID returns nothing (picture will be displayed in IDE)
test_that("Returns nothing", {
  expect_message(get_avatar_picture("c751b27d9158c1dd41bd33dc7e4bcdde", type = "full"), NA)
})

# Test 2: Error thrown if invalid type is specified
test_that("Returns error if invalid type specified", {
  expect_error(get_avatar_picture("c751b27d9158c1dd41bd33dc7e4bcdde", type = "invalid"), "Invalid value entered for type: can only be 'full' or 'thumbnail'")
})
