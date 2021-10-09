test_that("Returns nothing", {
  expect_message(get_avatar_picture("c751b27d9158c1dd41bd33dc7e4bcdde", type = "full"), NA)
})
