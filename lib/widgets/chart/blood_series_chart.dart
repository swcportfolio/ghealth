import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/enum/blood_type.dart';
import '../../data/models/blood_series_chart_data.dart';

class BloodSeriesChart extends StatelessWidget {
  const BloodSeriesChart(
      {super.key, required this.chartData,
        required this.bloodDataType,
        required this.plotBandValue,
      });

  /// 차트 데이터
  final List<BloodSeriesChartData> chartData;

  /// 마이데이터의 혈액 검사에 해당되는 데이터 타입  enum class
  final BloodDataType bloodDataType;

  /// 피검사 결과 참고치의 기준값
  /// 기준값을 통해 그래프의 빨강색 라인 기준선을 만들어 준다.
  final double plotBandValue;


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
          plotBands: bloodDataType == BloodDataType.hemoglobin //혈색소 범위 값일때
              ? <PlotBand>[
                  PlotBand(
                      start: Authorization().gender == 'M'? 13.0 : 12.0,
                      end: Authorization().gender == 'M'? 13.0 : 12.0,
                      borderColor: Colors.green,
                      borderWidth: 1,
                      dashArray: const [4, 5]),
                  PlotBand(
                      start: Authorization().gender == 'M'? 16.5 : 15.5,
                      end: Authorization().gender == 'M'? 16.5 : 15.5,
                      borderColor: Colors.green,
                      borderWidth: 1,
                      dashArray: const [4, 5])
                ]
              : <PlotBand>[
                  PlotBand(
                      start: plotBandValue,
                      end: plotBandValue,
                      borderColor: Colors.red,
                      borderWidth: 1,
                      dashArray: const [4, 5])
                ]),

      series: <ChartSeries<BloodSeriesChartData, String>>[
        // Renders column chart
        ColumnSeries<BloodSeriesChartData, String>(
          legendIconType: LegendIconType.seriesType,
          dataSource: chartData,
          xValueMapper: (BloodSeriesChartData data, _) => data.x,
          yValueMapper: (BloodSeriesChartData data, _) => data.y1,
          dataLabelMapper: (BloodSeriesChartData data, _) => data.y1.toString(),
          pointColorMapper: (BloodSeriesChartData data, _) => data.barColor,
          width: Etc.calculateChartWidthRatio(chartData.length), // 기본 폭
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