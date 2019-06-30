#' Estimate Density Ratio p(x)/q(y) by uLSIF (unconstrained Least-Square Importance Fitting)
#'
#' @param x numeric vector or matrix. Data from a numerator distribution p(x).
#' @param y numeric vector or matrix. Data from a denominator distribution q(y).
#' @param sigma positive numeric vector. Search range of Gaussian kernel bandwidth.
#' @param lambda positive numeric vector. Search range of regularization parameter.
#' @param kernel_num positive integer. Number of kernels.
#' @param verbose logical(default TRUE).
#'
#' @return uLSIF object that contains a function to compute estimated density ratio.
#'
#' @export
uLSIF <- function(x, y,
                  sigma = 10 ^ seq(-3, 1, length.out = 9),
                  lambda = 10 ^ seq(-3, 1, length.out = 9),
                  kernel_num = 100, verbose = TRUE) {

  params <- alist(x1 = x, x2 = y,
                  sigma = sigma, lambda = lambda, alpha = 0,
                  kernel_num = kernel_num, verbose = verbose)
  result <- do.call(RuLSIF, params)
  class(result) <- c("uLSIF", class(result))
  result
}
