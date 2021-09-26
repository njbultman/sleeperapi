test_that("returns a data frame", {
  expect_equal(class(get_user_leagues(688556535013502976)), "data.frame")
})
