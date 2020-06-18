import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
// https://pub.dev/packages/flutter_audio_recorder
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class AudioAnalyzer {
    start() async {
        final directory = await getApplicationDocumentsDirectory();
        final appPath = directory.path;
        final file = path.join(appPath, 'audio_analyzer_record.wav');

        bool hasPermission = await FlutterAudioRecorder.hasPermissions;

        if (!hasPermission) {
            throw new Exception('Invalid permissions for the FlutterAudioRecorder');
        }
        var recorder = FlutterAudioRecorder(file, audioFormat: AudioFormat.WAV, sampleRate: 16000);
        await recorder.initialized;

        await recorder.start();
        var recording = await recorder.current(channel: 0);
    }
}