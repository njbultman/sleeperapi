test_that("returns dataframe", {
  expect_equal(class(get_loser_playoff_bracket(688281863499907072)), "data.frame")
})
