import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../common/util/branch.dart';
import '../../../../model/enum/blood_data_type.dart';
import '../../../../model/vo_blood_chart.dart';

class BloodSeriesChart extends StatelessWidget {

  /// 차트 데이터
  final List<BloodChartData> chartData;

  /// 마이데이터의 혈액 검사에 해당되는 데이터 타입  enum class
  final BloodDataType bloodDataType;

  /// 피검사 결과 참고치의 기준값
  /// 기준값을 통해 그래프의 빨강색 라인 기준선을 만들어 준다.
  final double plotBandValue;

  /// 임시 성별 데이터
  final String gender;

  const BloodSeriesChart({
    super.key,
    required this.chartData,
    required this.bloodDataType,
    required this.plotBandValue,
    required this.gender,
  });

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
                //TODO: Authorization().gender 임시
            PlotBand(
                start: gender == 'M'? 13.0 : 12.0,
                end: gender == 'M'? 13.0 : 12.0,
                borderColor: Colors.green,
                borderWidth: 1,
                dashArray: const [4, 5]),
            PlotBand(
                start: gender == 'M'? 16.5 : 15.5,
                end: gender == 'M'? 16.5 : 15.5,
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

      series: <ChartSeries<BloodChartData, String>>[
        // Renders column chart
        ColumnSeries<BloodChartData, String>(
          legendIconType: LegendIconType.seriesType,
          dataSource: chartData,
          xValueMapper: (BloodChartData data, _) => data.x,
          yValueMapper: (BloodChartData data, _) => data.y1,
          dataLabelMapper: (BloodChartData data, _) => data.y1.toString(),
          pointColorMapper: (BloodChartData data, _) => data.barColor,
          width: Branch.calculateChartWidthRatio(chartData.length), // 기본 폭
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