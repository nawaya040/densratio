context("KLIEP")

test_that("KLIEP", {
  set.seed(1)
  x <- rnorm(200, mean = 1, sd = 1/8)
  y <- rnorm(200, mean = 1, sd = 1/2)

  result <- KLIEP(x, y)

  alpha <- result$alpha
  sigma <- result$kernel_info$sigma
  lambda <- result$lambda

  expected_alpha <- c(0.12049194, 0.11873354, 0.02361388,
                      0.00000000, 0.01495441, 0.11510380)

  expect_equal(head(alpha), matrix(expected_alpha))
  expect_equal(sigma, 0.0899)
})
