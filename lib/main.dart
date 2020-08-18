import 'package:audio_analyzer/FftPlotScreen.dart';
import 'package:flutter/material.dart';
import 'package:audio_analyzer/AudioAnalyzer.dart';

void main() {
  runApp(AudioAnalyzerApp());
}

class AudioAnalyzerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audio analyzer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Audio analyzer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 16000 is also a good choice
  // since above 8K is very high
  // but 48K covers up to 20K which is the maximum that can be heard
  static int get samplingRate => 48000;
  AudioAnalyzer _audioAnalyzer = new AudioAnalyzer(samplingRate: samplingRate);

  void _autoRecordAfterDelay() {
    _audioAnalyzer.autoRecordAfterDelay();
  }

  void _start() {
    _audioAnalyzer.start();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  void _stop() {
    _audioAnalyzer.stop();
  }

  void _play() {
    _audioAnalyzer.play();
  }

  void _analyze() async {
    List<double> fftAmplitudes = await _audioAnalyzer.analyze();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FftPlotScreen(fftAmplitudes: fftAmplitudes, samplingRate: samplingRate,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              child:
                Text(
                  'Record a sound and analyze its frequencies',
                  style: TextStyle(fontSize: 18),
                ),
            ),
            DiapasonMyStatefulWidget(),
            SamplingRateMyStatefulWidget(),
            SizedBox(height: 10),
            new RaisedButton(
                onPressed: _autoRecordAfterDelay,
                child: new Text('Wait 5s and record for 6s'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new RaisedButton(
                  onPressed: _start,
                  child: new Text('Start'),
                ),
                new RaisedButton(
                  onPressed: _stop,
                  child: new Text('Stop'),
                ),
                new RaisedButton(
                  onPressed: _play,
                  child: new Text('Play'),
                ),

              ]
            ),
            SizedBox(height: 10),
            new RaisedButton(
              onPressed: _analyze,
              child: new Text('Analyze'),
            ),
          ],
          ),
        ),
    );
  }
}


enum Diapason { scientific, orchestra }

class DiapasonMyStatefulWidget extends StatefulWidget {
  DiapasonMyStatefulWidget({Key key}) : super(key: key);

  @override
  _DiapasonMyStatefulWidgetState createState() => _DiapasonMyStatefulWidgetState();
}

// source for radio buttons:
// https://api.flutter.dev/flutter/material/Radio-class.html
class _DiapasonMyStatefulWidgetState extends State<DiapasonMyStatefulWidget> {
  Diapason _diapason = Diapason.orchestra;

  Widget build(BuildContext context) {
    return Row(
      // the spacing is broken due to the ListTile
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(width: 20),
        Text('Diapason:', style: TextStyle(fontSize: 16)),
        Flexible(child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          title: const Text('440Hz'),
          leading: Radio(
            value: Diapason.scientific,
            groupValue: _diapason,
            onChanged: (Diapason value) {
              setState(() {
                _diapason = value;
              });
            },
          ),
        )),
        Flexible(child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          title: const Text('442Hz'),
          leading: Radio(
            value: Diapason.orchestra,
            groupValue: _diapason,
            onChanged: (Diapason value) {
              setState(() {
                _diapason = value;
              });
            },
          ),
        )),
      ],
    );
  }
}

enum SamplingRate { rate16K, rate48K }

class SamplingRateMyStatefulWidget extends StatefulWidget {
  SamplingRateMyStatefulWidget({Key key}) : super(key: key);

  @override
  _SamplingRateMyStatefulWidget createState() => _SamplingRateMyStatefulWidget();
}

// source for radio buttons:
// https://api.flutter.dev/flutter/material/Radio-class.html
class _SamplingRateMyStatefulWidget extends State<SamplingRateMyStatefulWidget> {
  SamplingRate _rate = SamplingRate.rate48K;

  Widget build(BuildContext context) {
    return Row(
      // the spacing is broken due to the ListTile
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(width: 20),
        Text('Sampling rate:', style: TextStyle(fontSize: 16)),
        Flexible(child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          title: const Text('16K'),
          leading: Radio(
            value: SamplingRate.rate16K,
            groupValue: _rate,
            onChanged: (SamplingRate value) {
              setState(() {
                _rate = value;
              });
            },
          ),
        )),
        Flexible(child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          title: const Text('48K'),
          leading: Radio(
            value: SamplingRate.rate48K,
            groupValue: _rate,
            onChanged: (SamplingRate value) {
              setState(() {
                _rate = value;
              });
            },
          ),
        )),
      ],
    );
  }
}
