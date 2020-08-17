
import 'package:flutter/material.dart';

import 'package:audio_analyzer/FftPlot.dart';

class FftPlotScreen extends StatelessWidget {

  final List<double> fftAmplitudes;
  final int samplingRate;

  FftPlotScreen({Key key, @required this.fftAmplitudes, @required this.samplingRate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Frequency plot')),
      body: Center(
        child: CustomNumericComboChart.withFftAmplitudes(this.fftAmplitudes, this.samplingRate),
      ),
    );
  }
}