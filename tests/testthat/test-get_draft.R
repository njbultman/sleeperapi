# Unit tests for get_draft function

# Test 1: Invalid draft ID returns nothing
test_that("Invalid draft ID returns nothing", {
  expect_equal(get_draft(-777), NULL)
})
