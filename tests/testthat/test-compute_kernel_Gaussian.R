context("compute_kernel_Gaussian")

test_that("euclid_distance", {
  set.seed(3)
  x <- rnorm(30)
  y <- rnorm(1)
  act <- euclid_distance(x, y)

  expect_equal(act, 7.590585, tolerance = 1e-6)
})
