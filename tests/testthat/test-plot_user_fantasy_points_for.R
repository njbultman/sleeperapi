# Unit tests for plot_user_fantasy_points_for function

# Test 1: Valid inputs return a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_user_fantasy_points_for(688281863499907072,
                                                  "njbultman74")
               ),
               c("plotly", "htmlwidget"))
})
# Test 2: Invalid title type returns error
test_that("bad title argument type throws error", {
  expect_error(plot_user_fantasy_points_for(688281863499907072,
                                            "njbultman74",
                                            title = 1),
               "Title, display name, tick color, user fill, and other fill must all be strings.") # nolint
})
# Test 3: Invalid display name type returns error
test_that("bad display name argument type throws error", {
  expect_error(plot_user_fantasy_points_for(688281863499907072,
                                            "njbultman74",
                                            display_name = 1),
               "Title, display name, tick color, user fill, and other fill must all be strings.") # nolint
})
# Test 4: Invalid tick color type returns error
test_that("bad tick color argument type throws error", {
  expect_error(plot_user_fantasy_points_for(688281863499907072,
                                            "njbultman74",
                                            tick_color = 1),
               "Title, display name, tick color, user fill, and other fill must all be strings.") # nolint
})
# Test 5: Invalid user fill type returns error
test_that("bad user fill argument type throws error", {
  expect_error(plot_user_fantasy_points_for(688281863499907072,
                                            "njbultman74",
                                            user_fill = TRUE),
               "Title, display name, tick color, user fill, and other fill must all be strings.") # nolint
})
# Test 6: Invalid other fill type returns error
test_that("bad other fill argument type throws error", {
  expect_error(plot_user_fantasy_points_for(688281863499907072,
                                            "njbultman74",
                                            other_fill = as.factor(2)),
               "Title, display name, tick color, user fill, and other fill must all be strings.") # nolint
})