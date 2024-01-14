# Unit tests for the get_avatar_picture function

# Test 1: Error thrown if invalid type is specified
test_that("Returns error if invalid type specified", {
  expect_error(get_avatar_picture("c751b27d9158c1dd41bd33dc7e4bcdde", type = "invalid", keep_image = FALSE), "Invalid value entered for type: can only be 'full' or 'thumbnail'")
})

# Test 2: Informs user that file was deleted if keep_image is FALSE
test_that("Returns error if invalid type specified", {
  expect_message(get_avatar_picture("c751b27d9158c1dd41bd33dc7e4bcdde", type = "full", keep_image = FALSE), "File successfully removed from temporary location.")
})

# Test 3: Informs user that file was not deleted if keep_image is TRUE
test_that("Returns error if invalid type specified", {
  expect_message(get_avatar_picture("c751b27d9158c1dd41bd33dc7e4bcdde", type = "thumbnail", keep_image = TRUE), regexp = "Temporary file not deleted. It can be found at*")
})

