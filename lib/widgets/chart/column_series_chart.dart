

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/column_series_chart_data.dart';
import '../../utils/constants.dart';

class ColumnSeriesChart extends StatelessWidget {
  const ColumnSeriesChart({super.key, required this.chartData, required this.dataType});
  final List<ColumnSeriesChartData> chartData;
  final ScreeningsDataType dataType;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true, position: LegendPosition.bottom),

      /// X축 설정
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(fontSize: 10, color: Colors.black),
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
        labelRotation: 0, //0
      ),

      /// Y축 설정
      primaryYAxis: NumericAxis(
          minimum: 0,
          axisLine: const AxisLine(width: 1),
          majorGridLines: const MajorGridLines(
              width: 1, dashArray: <double>[1, 3], color: Colors.grey),
          majorTickLines: const MajorTickLines(size: 0)),
      series: <ChartSeries<ColumnSeriesChartData, String>>[
        // Renders column chart
        ColumnSeries<ColumnSeriesChartData, String>(
          legendIconType: LegendIconType.seriesType,
          legendItemText: ScreeningsDataType.vision== dataType
              ? '좌'
              : '최고 혈압',
          dataSource: chartData,
          xValueMapper: (ColumnSeriesChartData data, _) => data.x,
          yValueMapper: (ColumnSeriesChartData data, _) => data.y1,
          dataLabelMapper: (ColumnSeriesChartData data, _) => data.y1.toString(),
          color: Colors.orangeAccent,
          width: 0.5, // 기본 폭
          dataLabelSettings:  const DataLabelSettings(
              labelAlignment: ChartDataLabelAlignment.outer,
              isVisible: true,
              textStyle: TextStyle(fontSize: 12)),
        ),
        ColumnSeries<ColumnSeriesChartData, String>(
          legendIconType: LegendIconType.seriesType,
          legendItemText: ScreeningsDataType.vision== dataType
              ? '우'
              : '최저 혈압',
          dataSource: chartData,
          xValueMapper: (ColumnSeriesChartData data, _) => data.x,
          yValueMapper: (ColumnSeriesChartData data, _) => data.y2,
          dataLabelMapper: (ColumnSeriesChartData data, _) => data.y2.toString(),
          width: 0.5, // 기본 폭
          color: Colors.lightBlue,
          dataLabelSettings:  const DataLabelSettings(
              labelAlignment: ChartDataLabelAlignment.outer,
              isVisible: true,
              textStyle: TextStyle(fontSize: 12)),
        ),
      ],
      trackballBehavior: TrackballBehavior(enable: false, activationMode: ActivationMode.singleTap),
    );
  }
}
