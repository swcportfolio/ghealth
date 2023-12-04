import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/view/wearable/wearable_week_chart_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/colors.dart';
import '../view/wearable/health_view.dart';
import 'frame.dart';

class HealthCircularChart extends StatelessWidget {
  const HealthCircularChart({
    super.key,
    required this.mainValue,
    required this.targetValue,
    required this.type,
    required this.function,
    required this.chartData,
  });

  /// 실제 수면시간, 실제 걸음
  final String mainValue;

  /// 목표 수면시간, 목표 걸음
  final String targetValue;

  /// 수집된 건강 데이터 타입
  final HealthDataType type;

  final Function(HealthDataType tpye) function;

  final List<ChartData2> chartData;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20  ),
                    child: Row(
                      children: [
                        Image.asset(
                            height: 25, width: 25,
                            type == HealthDataType.sleep
                                ? 'images/sleeping.png'
                                : 'images/footstep.png',
                        ),
                        const Gap(5),
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

                  InkWell(
                    onTap: ()=> Frame.doPagePush(context, WearableWeekChartView(type: type)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Frame.myText(
                        text: '더보기',
                        color: Colors.grey
                      ),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  SizedBox(
                    height: 220,
                    width: 220,
                    child: SfCircularChart(annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Frame.myText(
                                text: mainValue,
                                fontSize: 1.4,
                                fontWeight: FontWeight.w600,
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
                                text: '$targetValue${type == HealthDataType.sleep? '시간': ''}',
                                fontSize: 1.4,
                                color: Colors.grey
                              ),
                              const Gap(15),

                              Frame.myText(
                                text: type == HealthDataType.sleep
                                    ? '목표 수면 시간'
                                    : '목표 걸음 수',
                                color: Colors.grey,
                                fontSize: 0.9
                              )
                          ]
                          ))
                    ], series: <CircularSeries>[
                      RadialBarSeries<ChartData2, String>(
                          dataSource: chartData,
                          innerRadius: '85%',
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
                                    : '걸음 수',
                                color: Colors.grey
                            ),
                          ],
                        ),
                        const Gap(5),

                        Frame.myText(
                            text: mainValue,
                            fontWeight: FontWeight.w600,
                            fontSize: 1.4),
                        const Gap(20),

                        InkWell(
                          onTap: ()=> function(type),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Frame.myText(
                                      text: type == HealthDataType.sleep
                                          ? '목표 수면 시간'
                                          : '목표 걸음 수',
                                      color: Colors.grey
                                  ),
                                  const Gap(5),
                                  const Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey)
                                ],
                              ),

                              Frame.myText(
                                  text: '$targetValue${type == HealthDataType.sleep? '시간': ''}',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 1.4
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Frame.myText(
                      text: type == HealthDataType.sleep
                          ? '목표 수면 시간을 설정해보세요'
                          : '목표 걸음 수를 설정해보세요',
                      color: Colors.grey
                    ),
                  ],
                ),
              )
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
