
import 'package:flutter/material.dart';

import 'package:audio_analyzer/FftPlot.dart';

class FftPlotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Frequency plot')),
      body: Center(
        child: SimpleScatterPlotChart.withRandomData(),
      ),
    );
  }
}