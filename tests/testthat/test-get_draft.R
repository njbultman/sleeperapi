# Unit tests for get_draft function

# Test 1: Proper draft ID returns a list
test_that("proper draft ID returns list", {
  expect_equal(class(get_draft(688281872463106048)), "list")
})

# Test 2: Invalid draft ID informs user
test_that("Invalid draft ID informs user", {
  expect_message(get_draft(-777), "No data returned - are you sure the league ID was entered correctly?")
})

# Test 3: Invalid draft ID returns nothing
test_that("Invalid draft ID returns nothing", {
  expect_equal(get_draft(-777), NULL)
})
