# Unit tests for plot_league_information_table function

# Test 1: Verify that font color input is a string
test_that("verify that font color input is string", {
  expect_error(plot_league_information_table(688281863499907072,
                                             font_color = 2),
               "Font color argument must be a string.")
})
