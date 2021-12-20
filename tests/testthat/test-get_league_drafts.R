test_that("returns dataframe", {
  expect_equal(class(get_league_drafts(688281863499907072)), "data.frame")
})
