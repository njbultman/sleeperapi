test_that("returns dataframe", {
  expect_equal(class(get_trending_players("nfl", "add", 24, 25)), "data.frame")
})
