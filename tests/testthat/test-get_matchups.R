test_that("returns a data frame", {
  expect_equal(class(get_matchups(688281863499907072, 2)), "data.frame")
})