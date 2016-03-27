#' Estimate Density Ratio p_nu(x)/p_de(y)
#'
#' @param x numeric vector or matrix as data from a numerator distribution p_nu(x).
#' @param y numeric vector or matrix as data from a denominator distribution p_de(y).
#' @param method "uLSIF"(default) or "KLIEP".
#' @param sigma positive numeric vector as a search range of Gaussian kernel bandwidth.
#' @param lambda positive numeric vector as a search range of regularization parameter for uLSIF.
#' @param kernel_num positive integer as number of kernels.
#' @param fold positive integer as fold number for cross validation for KLIEP.
#'
#' @export
densratio <- function(x, y, method = c("uLSIF", "KLIEP"),
                      sigma = "auto", lambda = "auto",
                      kernel_num = 100, fold = 5) {
  method <- match.arg(method)
  cl <- match.call()

  params <- alist(x = x, y = y, kernel_num = kernel_num)
  if(sigma != "auto") params <- c(params, alist(sigma = sigma))

  if(method == "uLSIF") {
    if(lambda != "auto") params <- c(params, alist(lambda = lambda))
    result <- do.call(uLSIF, params)
  } else {
    params <- c(params, alist(fold = fold))
    result <- do.call(KLIEP, params)
  }

  cl[["method"]] <- method
  result$call <- cl
  class(result) <- c("densratio", class(result))
  result
}
