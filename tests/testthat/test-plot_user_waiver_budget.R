# Unit tests for plot_user_waiver_budget function

# Test 1: Valid inputs return a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_user_waiver_budget(688281863499907072,
                                             "njbultman74")
               ),
               c("plotly", "htmlwidget"))
})

# Test 2: Invalid display name type throws error
test_that("good function call returns plotly object", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       2),
               "Title, display_name, tick_color, and budget line color must all be strings.") # nolint
})

# Test 3: Invalid title type throws error
test_that("good function call returns plotly object", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       "njbultman74",
                                       title = 2),
               "Title, display_name, tick_color, and budget line color must all be strings.") # nolint
})

# Test 4: Invalid tick_color type throws error
test_that("good function call returns plotly object", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       "njbultman74",
                                       tick_color = TRUE),
               "Title, display_name, tick_color, and budget line color must all be strings.") # nolint
})

# Test 5: Invalid tick_color type throws error
test_that("good function call returns plotly object", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       "njbultman74",
                                       budget_total_line_color = 7),
               "Title, display_name, tick_color, and budget line color must all be strings.") # nolint
})
