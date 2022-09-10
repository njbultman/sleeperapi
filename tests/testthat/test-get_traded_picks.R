# Unit tests for get_traded_picks

# Test 1: Valid league ID returns a list
test_that("returned object length of zero informs user", {
  expect_message(class(get_traded_picks(-777)), "No data found but still returning empty list. Was league ID entered correctly and are traded picks known to be there?")
})

