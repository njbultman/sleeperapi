test_that("returns dataframe", {
  expect_equal(class(get_user_drafts(688556535013502976, "nfl", 2021)), "data.frame")
})
