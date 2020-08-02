import 'package:path/path.dart' as path;
import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'dart:core';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
// https://pub.dev/packages/flutter_audio_recorder
import 'package:path_provider/path_provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fft/fft.dart';

class AudioAnalyzer {

    var _recorder;
    var _file;
    var _assetsAudioPlayer;

    makeFile() async {
        final directory = await getApplicationDocumentsDirectory();
        final appPath = directory.path;
        _file = path.join(appPath, 'audio_analyzer_record.wav');
    }

    start() async {
        if (_file == null) {
            await makeFile();
        }

        bool hasPermission = await FlutterAudioRecorder.hasPermissions;

        if (!hasPermission) {
            throw new Exception('Invalid permissions for the FlutterAudioRecorder');
        }

        var file = File(_file);
        file.delete();
        // https://pub.dev/packages/flutter_audio_recorder
        // https://developer.android.com/ndk/guides/audio/sampling-audio
        // 48 can be used for high notes.
        // A sample rate of 16K is enough based on the Nyquist-Shanonn theroem
        // see here a table: https://en.wikipedia.org/wiki/Scientific_pitch_notation
        // the octave 9 is not reachable with 16K as sample rate
        // And the human ear can hear up to 20KHz
        // https://www.sciencedirect.com/topics/engineering/nyquist-theorem
        _recorder = FlutterAudioRecorder(_file, audioFormat: AudioFormat.WAV, sampleRate: 48000);
        await _recorder.initialized;

        await _recorder.start();
        //var recording = await _recorder.current(channel: 0);
    }

    stop() async {
        if (_recorder != null) {
            var result = await _recorder.stop();
            print(result.path);
        }
        if (_assetsAudioPlayer != null) {
            _assetsAudioPlayer.stop();
        }
    }

    play() async {
        _assetsAudioPlayer = AssetsAudioPlayer();

        _assetsAudioPlayer.open(
            Audio.file(_file),
        );

        _assetsAudioPlayer.play();
    }


    analyze() async {
        if (_file == null) {
            await makeFile();
        }
        var fft = await computeFFT();
    }

    // In the README, we have an adb command to download the wav
    // the we can parse the header in python
    // python wav parser
    // https://gist.github.com/eerwitt/ba51e181d50de6555a2ae613a558c0b6
    // the WAV
    // http://soundfile.sapp.org/doc/WaveFormat/
    // http://www.topherlee.com/software/pcm-tut-wavformat.html

    // windowing makes a more periodic signal
    // https://download.ni.com/evaluation/pxi/Understanding%20FFTs%20and%20Windowing.pdf
    computeFFT() async {
        // the header has 44 bytes, which makes 22 16-bit integers
        // we know each byte has 2 bytes
        Uint8List bytes = await new File(_file).readAsBytes();
        int lengthBytes = bytes.length - 44;
        // the Hann function wants a sample with size equal to a power of 2
        // https://stackoverflow.com/questions/466204/rounding-up-to-next-power-of-2/24844826
        var powerOf2 = pow(2, (log(lengthBytes)/log(2)).ceil())/2;
        int extra = (lengthBytes - powerOf2) ~/ 2;

        ByteBuffer buffer = bytes.buffer;
        var samplesOn2Bytes = buffer.asUint16List().skip(22 + extra);
        List<int> samples = new List<int>.from(samplesOn2Bytes);

        var windowPackage = new Window(WindowType.HANN);
        var window = windowPackage.apply(samples);
        var fft = new FFT().Transform(window);
        return fft;
    }

    // "In an fft frequency plot, the highest frequency is the sampling frequency fs and the lowest frequency is fs/N where N is the number of fft points. "
    // https://www.researchgate.net/post/How_can_I_define_the_frequency_resolution_in_FFT_And_what_is_the_difference_on_interpreting_the_results_between_high_and_low_frequency_resolution
    // The Nyquist-Shannon theorem says that we have an accuracy up to sample rate / 2.
}