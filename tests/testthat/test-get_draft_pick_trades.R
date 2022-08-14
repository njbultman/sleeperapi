# Unit tests for the get_draft_pick_trades function

# Test 1: Valid draft ID with no trades returns a message informing user
test_that("Valid league ID with no trades returns user with message asking if any trades did occur in draft", {
  expect_message(get_draft_pick_trades(688281872463106048), "No data found - were there any trades in the draft?")
})

# Test 2: Invalid draft ID returns NULL
test_that("Invalid league ID returns message informing user", {
  expect_message(get_draft_pick_trades(-777), "No data found - was the draft ID entered correctly?")
})
