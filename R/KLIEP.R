#' Estimate Density Ratio p(x)/p(y) by KLIEP (Kullback-Leibler Importance Estimation Procedure)
#'
#' @param x numeric vector or matrix as data from numerator.
#' @param y numeric vector or matrix as data from denominator.
#' @param sigma positive scalar as Gaussian kernel bandwidth.
#' @param kernel_num positive integer as number of kernels.
#' @param fold positive integer as fold number for cross validation.
#'
#' @export
KLIEP <- function(x, y, sigma = "auto", kernel_num = 100, fold = 5) {
  if(is.vector(x)) x <- matrix(x)
  if(is.vector(y)) y <- matrix(y)
  if(sigma == "auto") sigma <- 0

  d <- ncol(x)
  nx <- nrow(x)
  dy <- ncol(y)

  if(d != dy) {
    stop(sprintf("Dimension of x is %d and dimension of y is %d. The dimensions must be same.", d, dy))
  }

  kernel_num <- min(kernel_num, nx)
  centers <- x[sample(nx, size = kernel_num), , drop = FALSE]

  if(sigma <= 0) {
    sigma <- KLIEP_search_sigma(x, y, centers, fold)
  }

  phi_x <- compute_kernel_Gaussian(x, centers, sigma)
  phi_y <- compute_kernel_Gaussian(y, centers, sigma)

  alpha <- KLIEP_optimize_alpha(phi_x, phi_y)

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
  class(result) <- c("KLIEP", "list")
  result
}
