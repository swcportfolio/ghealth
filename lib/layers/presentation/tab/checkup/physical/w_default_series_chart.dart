import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../../../main.dart';
import '../../../../model/vo_default_serises_chart.dart';

class DefaultSeriesChart extends StatelessWidget {

  final List<DefaultSeriesChartData> chartData;
  final dynamic type;

  const DefaultSeriesChart({
        super.key,
        required this.chartData,
        required this.type,
  });


  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: false),

      /// X축 설정
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(fontSize: 10, color: AppColors.blackTextColor),
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
        labelRotation: 0,

      ),

      /// Y축 설정
      primaryYAxis: NumericAxis(
        minimum: 0,
        axisLine: const AxisLine(width: 1),
        majorGridLines: const MajorGridLines(
            width: 1,
            dashArray: <double>[1, 3],
            color: AppColors.grey,
        ),
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
          color: AppColors.primaryColor,
          width: Branch.calculateChartWidthRatio(chartData.length), // 그래프 바 폭
          dataLabelSettings:  const DataLabelSettings(
              labelAlignment: ChartDataLabelAlignment.outer,
              isVisible: true,
              textStyle: TextStyle(fontSize: AppDim.fontSizeXSmall)),
        ),
      ],
      trackballBehavior: TrackballBehavior(enable: false, activationMode: ActivationMode.singleTap),
    );
  }
}