# audio_analyzer

A program to record sound.

## Getting Started

to activate host input in the emulator:
to open the Extended controls window, click More Emulator extended controls icon in the emulator panel
then open the Microphone tab

# adb debugging

how to list files with adb:

```
adb shell su 0 "ls -l /data/data/com.prototype.audio_analyzer/app_flutter/"
```

to fetch the file (which requires root)

```
adb root
adb pull /data/data/com.prototype.audio_analyzer/app_flutter/audio_analyzer_record.wav
```

# details

This 100% free tool allows to display the frequencies of a periodic sound, especially from a music instrument. The scale is zoomable and slidable outside the screen. It displays the Fast Fourier transform with marks on the grid for each note (A4, A4#, etc). The human hear can hear from 20Hz to 20KHz.

One can choose the sampling rate (16K, 48K), and the diapason (orchestra, scientific). The human hear can hear from 20Hz to 20KHz. And half the sampling rate determines the highest accurate frequency. The Nyquist-Shannon theorem ensures a precise representation of a FFT up to half the sampling rate.

The quality of the calculations is very high because a C library FFW3 (free for non-commercial use) is used for exact FFT calculations. The WAV file format maximizes the quality because it is not compressed.

The results are amazing for clarinet sounds in the voice register. For example, playing an A5 it shows a very pure A5 note with its small A6 extra harmonic, all pure from 0Hz to A6. Phone microphones are of high quality.

More testing is needed but recording imprecision seems to happen. It seems that the electronics of the phone alters very high frequencies. And noise reduction mechanisms also reduce the purity of the sound for all registers. Edges of recordings sound abrupt, but seems due to the player library.

The source code lies here, with an MIT license. It was made in Flutter.
tag v1
https://github.com/MagicPoulp/audio_analyzer
