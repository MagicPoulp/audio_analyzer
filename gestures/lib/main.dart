import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestures/my_painter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter gestures',
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter gestures'),
      debugShowCheckedModeBanner: false,
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

  var baseScaleFactor = 1.0;
  var scaleFactor = 1.0;
  var previousPosX = 0.0;
  var previousPosY = 0.0;
  var x = 0.0;
  var y = 0.0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body:
        GestureDetector(
          // https://stackoverflow.com/questions/55440184/flutter-gesturedetector-how-to-pinch-in-out-or-zoom-in-out-text-using-two-finge
          onScaleStart: (details) {
            baseScaleFactor = scaleFactor;
            previousPosX = details.localFocalPoint.dx;
            previousPosY = details.localFocalPoint.dy;
          },
          onScaleUpdate: (details) {
            if (details.scale != 1) {
              scaleFactor = baseScaleFactor * details.scale;
              //debugPrint("--> scale" + details.scale.toString());
            } else {
              var deltaX = details.localFocalPoint.dx - previousPosX;
              var deltaY = details.localFocalPoint.dy - previousPosY;
              previousPosX = details.localFocalPoint.dx;
              previousPosY = details.localFocalPoint.dy;
              x += deltaX;
              y += deltaY;
            }
            setState(() {
            });
          },
          child:
            Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 0,
                  child:
                    CustomPaint(
                      painter: MyPainter(scaleFactor, x, y),
                      child: Container(),
                    ),
                ),
              ],
          )
        ),
    );
  }
}
