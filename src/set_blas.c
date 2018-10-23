#include <R.h>
#include <Rinternals.h>

extern void openblas_set_num_thread(int);	
extern int  openblas_get_num_thread(void);

SEXP obt_set_num_threads(SEXP n) {
	openblas_set_num_threads(INTEGER(n));
  return R_NilValue;
}

SEXP obt_get_num_threads() {
  SEXP n = PROTECT(allocVector(INTSXP, 1));
  INTEGER(n)[0] = openblas_get_num_threads();
  UNPROTECT(1);
  
  return n;
}
