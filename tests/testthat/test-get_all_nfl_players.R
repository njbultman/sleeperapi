# Unit tests for the get_all_nfl_players function

# Test 1: clean parameter not of type logical? Throws an error
test_that("Throws error if clean is not of type logical", {
  expect_error(get_all_nfl_players(clean = "test"))
})
