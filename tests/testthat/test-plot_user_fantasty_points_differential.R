# Unit tests for plot_user_fantasy_points_differential function

# Test 1: Valid inputs return a plotly object
test_that("good function call returns plotly object", {
  expect_equal(class(plot_user_fantasy_points_differential(688281863499907072,
                                                      "njbultman74")
               ),
               c("plotly", "htmlwidget"))
})
