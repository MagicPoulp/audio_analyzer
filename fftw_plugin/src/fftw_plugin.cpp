
#include <fftw3.h>

#include "fftw_plugin.h"

// https://flutter.dev/docs/development/platform-integration/c-interop
// http://www.fftw.org/fftw2_doc/fftw_2.html
int fft() {
     fftw_complex in[N], out[N];
     fftw_plan p;

     p = fftw_create_plan(N, FFTW_FORWARD, FFTW_ESTIMATE);

     fftw_one(p, in, out);

     fftw_destroy_plan(p);
     return 0;
}
