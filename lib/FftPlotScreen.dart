
import 'package:flutter/material.dart';

import 'package:audio_analyzer/FftPlot.dart';

class FftPlotScreen extends StatelessWidget {

  final List<double> fftAmplitudes;

  FftPlotScreen({Key key, @required this.fftAmplitudes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Frequency plot')),
      body: Center(
        child: SimpleScatterPlotChart.withFftAmplitudes(this.fftAmplitudes),
      ),
    );
  }
}