test_that("Returns a ggplot2 plot", {
  expect_equal(class(plot_wl_nfp(688281863499907072)), c("gg", "ggplot"))
})
