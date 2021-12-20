test_that("returns list", {
  expect_equal(class(get_sport_state("nfl")), "list")
})
