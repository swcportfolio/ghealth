import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/colors.dart';
import '../view/health/health_view.dart';
import 'frame.dart';

/// 파이 그래프 테스트
final List<ChartData2> chartData2 = [
  ChartData2('A', 90),
];

class HealthCircularChart extends StatelessWidget {
  const HealthCircularChart({
    super.key,
    required this.mainValue,
    required this.targetValue,
    required this.type,
  });

  /// 실제 수면시간, 실제 걸음
  final String mainValue;

  /// 목표 수면시간, 목표 걸음
  final String targetValue;

  /// 수집된 건강 데이터 타입
  final HealthDataType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(width: 2.0, color: Colors.grey.shade200)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  children: [
                    Image.asset(
                        type == HealthDataType.sleep
                            ? 'images/sleeping.png'
                            : 'images/footstep.png',
                        height: 25,
                        width: 25
                    ),
                    const Gap(10),
                    Frame.myText(
                        text: type == HealthDataType.sleep
                            ? '수면'
                            : '걸음 수',
                        fontSize: 1.3,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 220,
                    width: 220,
                    child:
                     SfCircularChart(annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Frame.myText(
                                text: mainValue,
                                fontSize: 1.4,
                                fontWeight: FontWeight.bold,
                                  color: type == HealthDataType.sleep
                                      ? mainColor
                                      : Colors.orangeAccent
                              ),

                              Container(
                                width: 90,
                                height: 1,
                                color: Colors.grey.shade300,
                                margin: const EdgeInsets.symmetric(vertical: 5)
                              ),

                              Frame.myText(
                                text: targetValue,
                                fontSize: 1.4,
                              ),
                              const Gap(15),

                              Frame.myText(
                                text: type == HealthDataType.sleep
                                    ? '목표 수면 시간'
                                    : '목표 걸음 수',
                                fontSize: 1.0)
                          ]
                          ))
                    ], series: <CircularSeries>[
                      RadialBarSeries<ChartData2, String>(
                          dataSource: chartData2,
                          innerRadius: '90%',
                          maximumValue: 100,
                          pointColorMapper: (ChartData2 data, _) =>
                              type == HealthDataType.sleep
                                  ? mainColor
                                  : Colors.orangeAccent,
                          xValueMapper: (ChartData2 data, _) => data.x,
                          yValueMapper: (ChartData2 data, _) => data.y)
                    ]),
                  ),

                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Frame.myText(
                                text: type == HealthDataType.sleep
                                    ? '수면시간'
                                    : '걸음 수'
                            ),
                            const Gap(5),
                            const Icon(Icons.arrow_drop_down, size: 20)
                          ],
                        ),
                        Frame.myText(
                            text: mainValue,
                            fontWeight: FontWeight.w600,
                            fontSize: 1.6),
                        const Gap(20),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Frame.myText(
                                text: type == HealthDataType.sleep
                                    ? '목표 수면 시간'
                                    : '목표 걸음 수'),
                            const Gap(5),
                            const Icon(Icons.arrow_drop_down, size: 20)
                          ],
                        ),
                        Frame.myText(
                            text: targetValue,
                            fontWeight: FontWeight.w600,
                            fontSize: 1.6)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData2 {
  late String x;
  late double y;

  ChartData2(this.x, this.y);
}
