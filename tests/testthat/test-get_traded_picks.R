# Unit tests for get_traded_picks

# Test 1: Valid league ID returns a list
test_that("returns a list", {
  expect_equal(class(get_traded_picks(688281863499907072)), "list")
})

