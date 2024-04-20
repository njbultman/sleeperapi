# Unit tests for plot_league_information_table function

# Test 1: Verify that font color input is a string
test_that("verify that font color input is string", {
  expect_error(plot_league_information_table(688281863499907072,
                                             font_color = 2),
               "Font color, win/loss color, and fantasy points for/against arguments must be strings.") # nolint
})
# Test 2: Verify that good function call returns a data table
test_that("verify that good function call returns a data table", {
  expect_equal(class(plot_league_information_table(688281863499907072)),
               c("datatables", "htmlwidget"))
})
# Test 3: Verify that win/loss fill input is a string
test_that("verify that win/loss fill input is string", {
  expect_error(plot_league_information_table(688281863499907072,
                                             win_loss_fill = 2),
               "Font color, win/loss color, and fantasy points for/against arguments must be strings.") # nolint
})
# Test 4: Verify that fantasy points for input is a string
test_that("verify that fantasy points for fill input is string", {
  expect_error(plot_league_information_table(688281863499907072,
                                             fpts_for_fill = TRUE),
               "Font color, win/loss color, and fantasy points for/against arguments must be strings.") # nolint
})
# Test 5: Verify that fantasy points against input is a string
test_that("verify that fantasy points against fill input is string", {
  expect_error(plot_league_information_table(688281863499907072,
                                             fpts_against_fill = TRUE),
               "Font color, win/loss color, and fantasy points for/against arguments must be strings.") # nolint
})
