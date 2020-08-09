
#ifndef AUDIO_ANALYZER_FFTW_PLUGIN_H
#define AUDIO_ANALYZER_FFTW_PLUGIN_H

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int transform(short int* inData, int length, float* outData);

#endif //AUDIO_ANALYZER_FFTW_PLUGIN_H
