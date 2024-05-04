# Unit tests for the get_weekly_matchups function

# Test 1: Invalid data type to the type argument throws an error
test_that("verify that invalid data type throws an error", {
  expect_error(get_weekly_matchups(688281863499907072, type = 1),
               'Type argument should be "all", "team", or "player.')
})
# Test 2: Bad league ID throws an error
test_that("bad league ID throws an error", {
  expect_error(get_weekly_matchups(-777),
               "No matchup data present for this league ID.")
})
# Test 3: Good function call with "all" type returns list
test_that("good function call with 'all' type returns list", {
  expect_equal(class(get_weekly_matchups(688281863499907072, type = "all")),
               "list")
})
# Test 4: Good function call with "team" type returns data.frame
test_that("good function call with 'team' type returns list", {
  expect_equal(class(get_weekly_matchups(688281863499907072, type = "team")),
               "data.frame")
})
# Test 5: Good function call with "player" type returns data.frame
test_that("good function call with 'player' type returns list", {
  expect_equal(class(get_weekly_matchups(688281863499907072, type = "player")),
               "data.frame")
})
