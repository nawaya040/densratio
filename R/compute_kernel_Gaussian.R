compute_kernel_Gaussian <- function(x, centers, sigma) {
  apply(centers, 1, function(center) {
    apply(x, 1, function(row) {
      kernel_Gaussian(row, center, sigma)
    })
  })
}

kernel_Gaussian <- function(x, y, sigma) {
  exp(- euclid_distance(x, y) / (2 * sigma * sigma))
}

#' Compute Euclid Distance
#'
#' @param x a numeric vector.
#' @param y a numeric vector.
#'
#' @return euclid distance
euclid_distance <- function(x, y) {
  sqrt(sum((x - y) ^ 2))
}
