# Unit tests for plot_user_waiver_budget function

# Test 1: Valid inputs return a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_user_waiver_budget(688281863499907072,
                                             "njbultman74")
               ),
               c("plotly", "htmlwidget"))
})
# Test 2: Invalid display name type throws error
test_that("bad display name argument type throws error", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       2),
               "Title, display name, tick color, budget line color, and fill color must all be strings.") # nolint
})
# Test 3: Invalid title type throws error
test_that("bad title argument type throws error", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       "njbultman74",
                                       title = 2),
               "Title, display name, tick color, budget line color, and fill color must all be strings.") # nolint
})
# Test 4: Invalid tick color type throws error
test_that("bad tick color argument type throws error", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       "njbultman74",
                                       tick_color = TRUE),
               "Title, display name, tick color, budget line color, and fill color must all be strings.") # nolint
})
# Test 5: Invalid budget total line color type throws error
test_that("bad budget total line color argument type throws error", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       "njbultman74",
                                       budget_total_line_color = 7),
               "Title, display name, tick color, budget line color, and fill color must all be strings.") # nolint
})
# Test 6: Invalid fill color type throws error
test_that("bad fill color argument type throws error", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       "njbultman74",
                                       fill_color = TRUE),
               "Title, display name, tick color, budget line color, and fill color must all be strings.") # nolint
})
