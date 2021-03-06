#' Plot a matrix
#'
#' plot_matrix is a R variant of Matlab's \code{spy} function.
#'
#' @param A A matrix
#' @return a ggplot object
#' @author David Kahle \email{david.kahle@@gmail.com}
#' @export
#' @examples
#'
#' # the no-three-way interaction configuration
#' A <- kprod(ones(1,3), diag(3), ones(3))
#' plot_matrix(A)
#' plot_matrix(markov(A))
#'
plot_matrix <- function(A){
  x <- NULL; rm(x)
  y <- NULL; rm(y)

  low <- if(any(A < 0)){
    low <- "blue"; high <- "red"
    fillScale <- scale_fill_gradient2(
      low = "blue", mid = "grey80",
      high = "red", midpoint = 0, guide = FALSE, space = "Lab"
    )
  } else {
    fillScale <- scale_fill_gradient(
      low = "white", high = "black", guide = FALSE
    )
  }
  df <- expand.grid(x = 1:ncol(A), y = 1:nrow(A))
  B <- t(A)
  df$A <- as.integer(B[,ncol(B):1])
  qplot(x, y, data = df, fill = A, geom = "tile") +
    fillScale +
    theme_bw() + coord_equal() +
    scale_x_continuous(expand = c(0,0)) +
    scale_y_continuous(expand = c(0,0)) +
    theme(
      line = element_blank(), text = element_blank(),
      plot.margin = grid::unit(c(0, 0, 0, 0), "lines")
    )
}
