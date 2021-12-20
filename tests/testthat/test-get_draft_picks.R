test_that("returns dataframe", {
  expect_equal(class(get_draft_picks(688281872463106048)), "data.frame")
})
