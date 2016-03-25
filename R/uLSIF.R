#' Estimate Density Ratio p(x)/p(y) by uLSIF (unconstrained Least-Square Importance Fitting)
#'
#' @param x numeric vector or matrix as data from numerator.
#' @param y numeric vector or matrix as data from denominator.
#' @param sigma positive scalar as Gaussian kernel bandwidth.
#' @param lambda positive scalar as regularization parameter.
#' @param kernel_num positive integer as number of kernels.
#' @param fold positive integer as fold number for cross validation.
#'
#' @export
uLSIF <- function(x, y,
                  sigma = 10 ^ seq(-3, 1, length.out = 9),
                  lambda = 10 ^ seq(-3, 1, length.out = 9),
                  kernel_num = 100, fold = 0) {

  if(is.vector(x)) x <- matrix(x)
  if(is.vector(y)) y <- matrix(y)

  d <- ncol(x)
  nx <- nrow(x)
  dy <- ncol(y)
  ny <- nrow(y)

  kernel_num <- min(kernel_num, nx)
  centers <- x[sample(nx, size = kernel_num), , drop = FALSE]

  opt_params <- uLSIF_search_sigma_and_lambda(x, y, centers, sigma, lambda)
  sigma <- opt_params$sigma
  lambda <- opt_params$lambda

  phi_x <- compute_kernel_Gaussian(x, centers, sigma)
  phi_y <- compute_kernel_Gaussian(y, centers, sigma)
  H <- crossprod(phi_y) / ny
  h <- colMeans(phi_x)
  alpha <- solve(H + diag(lambda, kernel_num, kernel_num)) %*% h
  alpha[alpha < 0] <- 0

  result <- list(alpha = alpha,
                 x_density_ratio = phi_x %*% alpha,
                 y_density_ratio = phi_y %*% alpha,
                 kernel_info = list(
                   kernel = "Gaussian RBF",
                   kernel_num = kernel_num,
                   sigma = sigma,
                   centers = centers
                 ),
                 compute_density_ratio = function(x) {
                   if(is.vector(x)) x <- matrix(x)
                   phi_x <- compute_kernel_Gaussian(x, centers, sigma)
                   phi_x %*% alpha
                 }
  )
  class(result) <- c("uLSIF", "list")
  result
}
