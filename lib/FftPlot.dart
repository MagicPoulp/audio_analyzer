// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Scatter plot chart example
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomNumericComboChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  CustomNumericComboChart(this.seriesList, {this.animate,});

  factory CustomNumericComboChart.withFftAmplitudes(List<double> fftAmplitudes, samplingRate) {
    var numPoints = fftAmplitudes.length;
    var frequencyStep = samplingRate / numPoints;
    // Due to the Nyquist-Shannon theorem, we must discard frequencies up to half the sampling rate
    // this is hard-coded, the domain space could be dynamic
    List<double> fftAmplitudesTrimmed = List.from(fftAmplitudes.getRange(0, numPoints ~/ 2));
    List<charts.Series<num, num>> series = [new charts.Series<num, num>(
      id: '',
      colorFn: (_amplitude, _) {
        return charts.MaterialPalette.green.shadeDefault;
      },
      domainFn: (num _amplitude, i) => (i + 1) * frequencyStep,
      measureFn: (num amplitude, _i) => amplitude,
      //radiusPxFn: (num _amplitude, _i) => 2,
      //data: [1.1, 2.2, 3.3],
      data: fftAmplitudesTrimmed,
    )];

    return new CustomNumericComboChart(
      series,
      // Disable animations for image tests.
      animate: false,
    );
  }

  /*
  Compared to C4, the pitch of a note is given by 440*2^((n-9)/12)
  https://en.wikipedia.org/wiki/Scientific_pitch_notation
  However, most clarinets, and orchestras tune A4 to 442Hz.
  SO the frequency is equal to 442 * 2^((n-9)/12)
  It corresponds to the table below for 4420Hz.
  https://pages.mtu.edu/~suits/notefreq442.html
  */
  // https://google.github.io/charts/flutter/example/combo_charts/numeric_line_bar
  @override
  Widget build(BuildContext context) {
    // a LineChart is faster but a Combo Chart looks better
    // since the PanAndZoomBehaviour only works in a LineCHart, we use it.
    //return new charts.NumericComboChart(
    //return new charts.BarChart(
    return new charts.LineChart(
      seriesList,
      animate: animate,
      domainAxis: new charts.NumericAxisSpec(
        /*
        tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
        tickFormatterSpec: charts.BasicNumericTickFormatterSpec.fromNumberFormat(
            NumberFormat.compact()
        ),
        showAxisLine: false,
        */
        viewport: new charts.NumericExtents(0, 2000),
      ),
      // use control and mouse to zoom in and out
      // here is how to show touches in the Android emulator, but it is not needed
      // https://medium.theuxblog.com/enabling-show-touches-in-android-screen-recordings-for-user-research-cc968563fcb9
      behaviors: [new charts.SlidingViewport(), new charts.PanAndZoomBehavior()],
    );
  }
}

class SlidingViewportOnSelection extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SlidingViewportOnSelection(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SlidingViewportOnSelection.withSampleData() {
    return new SlidingViewportOnSelection(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      behaviors: [
        // Add the sliding viewport behavior to have the viewport center on the
        // domain that is currently selected.
        new charts.SlidingViewport(),
        // A pan and zoom behavior helps demonstrate the sliding viewport
        // behavior by allowing the data visible in the viewport to be adjusted
        // dynamically.
        new charts.PanAndZoomBehavior(),
      ],
      // Set an initial viewport to demonstrate the sliding viewport behavior on
      // initial chart load.
      domainAxis: new charts.OrdinalAxisSpec(
          viewport: new charts.OrdinalViewport('2018', 4)),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
      new OrdinalSales('2018', 33),
      new OrdinalSales('2019', 80),
      new OrdinalSales('2020', 21),
      new OrdinalSales('2021', 77),
      new OrdinalSales('2022', 8),
      new OrdinalSales('2023', 12),
      new OrdinalSales('2024', 42),
      new OrdinalSales('2025', 70),
      new OrdinalSales('2026', 77),
      new OrdinalSales('2027', 55),
      new OrdinalSales('2028', 19),
      new OrdinalSales('2029', 66),
      new OrdinalSales('2030', 27),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}