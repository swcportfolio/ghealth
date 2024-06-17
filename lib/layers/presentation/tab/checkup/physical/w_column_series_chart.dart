

import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/model/enum/physical_type.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../common/common.dart';
import '../../../../model/vo_column_series_chart.dart';

class ColumnSeriesChart extends StatelessWidget {
  final List<ColumnSeriesChartData> chartData;
  final PhysicalType type;

  const ColumnSeriesChart({
    super.key,
    required this.chartData,
    required this.type,
  });


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
          legendItemText: PhysicalType.vision == type
              ? '좌'
              : '최고 혈압',
          dataSource: chartData,
          xValueMapper: (ColumnSeriesChartData data, _) => data.x,
          yValueMapper: (ColumnSeriesChartData data, _) => data.y1,
          dataLabelMapper: (ColumnSeriesChartData data, _) => data.y1.toString(),
          color: Colors.orangeAccent,
          width: Branch.calculateChartWidthRatio(chartData.length), // 그래프 바 폭
          dataLabelSettings:  const DataLabelSettings(
              labelAlignment: ChartDataLabelAlignment.outer,
              isVisible: true,
              textStyle: TextStyle(fontSize: 12)),
        ),
        ColumnSeries<ColumnSeriesChartData, String>(
          legendIconType: LegendIconType.seriesType,
          legendItemText: PhysicalType.vision== type
              ? '우'
              : '최저 혈압',
          dataSource: chartData,
          xValueMapper: (ColumnSeriesChartData data, _) => data.x,
          yValueMapper: (ColumnSeriesChartData data, _) => data.y2,
          dataLabelMapper: (ColumnSeriesChartData data, _) => data.y2.toString(),
          width: Branch.calculateChartWidthRatio(chartData.length), // 그래프 바 폭
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
