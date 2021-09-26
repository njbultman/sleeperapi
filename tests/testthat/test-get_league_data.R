test_that("returns a list", {
  expect_equal(class(get_league_data(688281863499907072)), "list")
})
