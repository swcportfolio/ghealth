import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/default_series_chart_data.dart';
import '../../utils/colors.dart';

class DefaultSeriesChart extends StatelessWidget {
  const DefaultSeriesChart(
      {super.key, required this.chartData, required this.dataType});
  final List<DefaultSeriesChartData> chartData;
  final dynamic dataType;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: false),

      /// X축 설정
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(fontSize: 10, color: Colors.black),
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
        labelRotation: 0,

      ),

      /// Y축 설정
      primaryYAxis: NumericAxis(
          minimum: 0,
          axisLine: const AxisLine(width: 1),
          majorGridLines: const MajorGridLines(
              width: 1, dashArray: <double>[1, 3], color: Colors.grey),
          majorTickLines: const MajorTickLines(size: 0),
      ),

      series: <ChartSeries<DefaultSeriesChartData, String>>[
        // Renders column chart
        ColumnSeries<DefaultSeriesChartData, String>(
          legendIconType: LegendIconType.seriesType,
          dataSource: chartData,
          xValueMapper: (DefaultSeriesChartData data, _) => data.x,
          yValueMapper: (DefaultSeriesChartData data, _) => data.y1,
          dataLabelMapper: (DefaultSeriesChartData data, _) => data.y1.toString(),
          color: mainColor,
          width: 0.3, // 기본 폭
          dataLabelSettings:  const DataLabelSettings(
              labelAlignment: ChartDataLabelAlignment.outer,
              isVisible: true,
              textStyle: TextStyle(fontSize: 11)),
        ),
      ],
      trackballBehavior: TrackballBehavior(enable: false, activationMode: ActivationMode.singleTap),
    );
  }
}