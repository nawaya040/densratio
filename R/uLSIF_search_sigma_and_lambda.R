uLSIF_search_sigma_and_lambda <- function(x, y, centers, sigma_list, lambda_list, fold) {

  n_min <- min(nrow(x), nrow(y))

  score <- Inf
  sigma_new <- 0
  lambda_new <- 0
  for (sigma in sigma_list) {
    phi_x <- compute_kernel_Gaussian(x, centers, sigma)
    phi_y <- compute_kernel_Gaussian(y, centers, sigma)


  }

}
