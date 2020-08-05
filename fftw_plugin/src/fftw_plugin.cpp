
#include <fftw3.h>

#include "fftw_plugin.h"

// https://flutter.dev/docs/development/platform-integration/c-interop
// http://www.fftw.org/fftw3_doc/Complex-One_002dDimensional-DFTs.html
extern "C"
int fft() {
    int N = 10;
    fftw_complex *in, *out;
    fftw_plan p;

    in = (fftw_complex*) fftw_malloc(sizeof(fftw_complex) * N);
    out = (fftw_complex*) fftw_malloc(sizeof(fftw_complex) * N);
    p = fftw_plan_dft_1d(N, in, out, FFTW_FORWARD, FFTW_ESTIMATE);

    fftw_execute(p);

    fftw_destroy_plan(p);
    fftw_free(in);
    fftw_free(out);
    return 0;
}
