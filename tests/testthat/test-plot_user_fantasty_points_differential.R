# Unit tests for plot_user_fantasy_points_differential function

# Test 1: Valid inputs return a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_user_fantasy_points_differential(688281863499907072,
                                                           "njbultman74")
               ),
               c("plotly", "htmlwidget"))
})
# Test 2: Invalid title type returns error
test_that("bad title argument type throws error", {
  expect_error(plot_user_fantasy_points_differential(688281863499907072,
                                                     "njbultman74",
                                                     title = 1),
               "Title, display name, tick color, fill points for, and fill points against must all be strings.") # nolint
})
# Test 3: Invalid display name type returns error
test_that("bad display name argument type throws error", {
  expect_error(plot_user_fantasy_points_differential(688281863499907072,
                                                     "njbultman74",
                                                     display_name = 1),
               "Title, display name, tick color, fill points for, and fill points against must all be strings.") # nolint
})
# Test 4: Invalid tick color type returns error
test_that("bad tick color argument type throws error", {
  expect_error(plot_user_fantasy_points_differential(688281863499907072,
                                                     "njbultman74",
                                                     tick_color = 1),
               "Title, display name, tick color, fill points for, and fill points against must all be strings.") # nolint
})
# Test 5: Invalid fill points for type returns error
test_that("bad fill points for argument type throws error", {
  expect_error(plot_user_fantasy_points_differential(688281863499907072,
                                                     "njbultman74",
                                                     fill_points_for = TRUE),
               "Title, display name, tick color, fill points for, and fill points against must all be strings.") # nolint
})
# Test 6: Invalid fill points against type returns error
test_that("bad fill points against argument type throws error", {
  expect_error(plot_user_fantasy_points_differential(688281863499907072,
                                                     "njbultman74",
                                                     fill_points_against = as.factor("hi")), # nolint
               "Title, display name, tick color, fill points for, and fill points against must all be strings.") # nolint
})