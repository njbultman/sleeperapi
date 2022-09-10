# Unit tests for the get_draft_pick_trades function

# Test 1: Invalid draft ID returns NULL
test_that("Invalid league ID returns message informing user", {
  expect_message(get_draft_pick_trades(-777), "No data found - was the draft ID entered correctly?")
})
