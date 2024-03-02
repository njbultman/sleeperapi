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
               "Title, display_name, and tick_color must all be strings.")
})

# Test 3: Invalid title type throws error
test_that("good function call returns plotly object", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       "njbultman74",
                                       title = 2),
               "Title, display_name, and tick_color must all be strings.")
})

# Test 4: Invalid tick_color type throws error
test_that("good function call returns plotly object", {
  expect_error(plot_user_waiver_budget(688281863499907072,
                                       "njbultman74",
                                       tick_color = TRUE),
               "Title, display_name, and tick_color must all be strings.")
})
