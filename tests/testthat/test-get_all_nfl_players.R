# Unit tests for the get_all_nfl_players function

# Test 1: clean parameter = FALSE? Returns a list
test_that("returns list if clean is FALSE", {
  expect_equal(class(get_all_nfl_players(clean = FALSE)), "list")
})

# Test 2: clean parameter not of type logical? Throws an error
test_that("Throws error if clean is not of type logical", {
  expect_error(get_all_nfl_players(clean = "test"))
})
