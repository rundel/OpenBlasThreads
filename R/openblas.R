set_num_threads = function(threads) {
  threads = as.integer(threads)
  
  stopifnot(length(threads) == 1)
  stopifnot(!is.na(threads))
  stopifnot(theads >= 1 &threads <= parallel::detectCores())
  
	.C("set_blas", ipt=threads, PACKAGE="OpenBlasThreads")
}
