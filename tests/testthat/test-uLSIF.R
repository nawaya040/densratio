context("uLSIF")

test_that("uLSIF", {
  set.seed(3)
  x <- rnorm(200, mean = 1, sd = 1/8)
  y <- rnorm(200, mean = 1, sd = 1/2)

  result <- uLSIF(x, y)

  alpha <- result$alpha
  sigma <- result$kernel_info$sigma
  lambda <- result$lambda

  expected_alpha <- c(0.08770412, 0.00000000, 0.07556255,
                      0.01371470, 0.00000000, 0.00000000)

  expect_equal(head(alpha), expected_alpha)
  expect_equal(sigma, 0.1)
  expect_equal(lambda, 1)
})
