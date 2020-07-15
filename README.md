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
