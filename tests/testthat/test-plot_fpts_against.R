test_that("Returns a ggplot2 plot", {
  expect_equal(class(plot_fpts_against(688281863499907072)), c("gg", "ggplot"))
})
