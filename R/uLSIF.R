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

  kernel_num <- min(kernel_num, nx)
  centers <- x[sample(nx, size = kernel_num), , drop = FALSE]

  opt_params <- uLSIF_search_sigma_and_lambda(x, y, centers, sigma,lambda, fold)

}
