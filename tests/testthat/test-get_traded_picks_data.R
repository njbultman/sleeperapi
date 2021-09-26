test_that("returns a list", {
  expect_equal(class(get_traded_picks_data(688281863499907072)), "list")
})
