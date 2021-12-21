test_that("returns a data frame", {
  expect_equal(class(get_rosters(688281863499907072)), "data.frame")
})
