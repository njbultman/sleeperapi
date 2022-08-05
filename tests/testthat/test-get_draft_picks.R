# Unit tests for the get_draft_picks function

# Test 1: Valid draft ID returns a data frame
test_that("Valid draft ID returns a data frame", {
  expect_equal(class(get_draft_picks(688281872463106048)), "data.frame")
})

# Test 2: Invalid draft ID returns a message informing user
test_that("Invalid league ID returns a list", {
  expect_message(get_draft_picks(-777), "No data found - was the draft ID entered correctly?")
})
