#' Wrapper to set the number of OpenBlas threads from within an R session, via 
#' openblas_set_num_threads(), for implicit parallelization. Alters the number 
#' of threads employed by OpenBlas for that session and child sessions. 
#'
#' @param threads Maximum number of threads to use for OpenBlas operations
#'
#' @examples
#' mat = matrix(seq_len(5e7),5e4,1e3)
#' 
#' set_num_threads(1)
#' system.time( crossprod(mat,mat) )
#' 
#' set_num_threads(2)
#' system.time( crossprod(mat,mat) )
#'
#' set_num_threads(4)
#' system.time( crossprod(mat,mat) )
#' 
#' @useDynLib OpenBlasThreads obt_set_num_threads
#' 
#' @export

set_num_threads = function(threads = parallel::detectCores()) {
  threads = as.integer(threads)
  
  stopifnot(length(threads) == 1)
  stopifnot(!is.na(threads))
  stopifnot(threads >= 1 &threads <= parallel::detectCores())
  
  invisible(
	  .Call("obt_set_num_threads", n=threads, PACKAGE="OpenBlasThreads")
  )
}

#' Get the number of allowed OpenBlas threads for current R session.
#'
#' @examples
#' get_num_threads()
#' set_num_threads(2)
#' get_num_threads()
#' 
#' @useDynLib OpenBlasThreads obt_get_num_threads
#' 
#' @export

get_num_threads = function() {
  threads = NA_integer_
  .Call("obt_get_num_threads", PACKAGE="OpenBlasThreads")
}