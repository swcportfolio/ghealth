import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../model/enum/daily_health_type.dart';


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
  final DailyHealthType type;

  final Function(DailyHealthType tpye) function;

  final List<ChartData2> chartData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDim.large,
            vertical: AppDim.small,
          ),
          child: Row(
            children: [
              Image.asset(
                height: 25, width: 25,
                type == DailyHealthType.sleep
                    ? '${AppStrings.imagePath}/tab/daily/sleeping.png'
                    : '${AppStrings.imagePath}/tab/daily/footstep.png',
              ),
              const Gap(AppDim.xSmall),

              StyleText(
                  text: type == DailyHealthType.sleep
                      ? '수면'
                      : '걸음 수',
                  size: AppDim.fontSizeLarge,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greyTextColor,
              ),
              const Gap(AppDim.medium),

              // StyleText(
              //     text: type == DailyHealthType.sleep
              //         ? '목표 수면 시간을 설정해보세요'
              //         : '목표 걸음 수를 설정해보세요',
              //     size: AppDim.fontSizeXSmall,
              //     color: AppColors.greyTextColor
              // ),
            ],
          ),
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
                          StyleText(
                              text: mainValue,
                              size: AppDim.fontSizeLarge,
                              fontWeight: AppDim.weightBold,
                              color: type == DailyHealthType.sleep
                                  ? AppColors.primaryColor
                                  : AppColors.blackTextColor
                          ),

                          Container(
                              width: 90,
                              height: 1,
                              color: Colors.grey.shade300,
                              margin: const EdgeInsets.symmetric(vertical: AppDim.xSmall)
                          ),

                          StyleText(
                              text: '$targetValue${type == DailyHealthType.sleep? '시간': ''}',
                              size: AppDim.fontSizeLarge,
                              color: AppColors.grey
                          ),
                          const Gap(AppDim.medium),

                          StyleText(
                              text: type == DailyHealthType.sleep
                                  ? '목표 수면 시간'
                                  : '목표 걸음 수',
                              color: AppColors.grey,
                            size: AppDim.fontSizeSmall,
                          )
                        ]
                    ))
              ], series: <CircularSeries>[
                RadialBarSeries<ChartData2, String>(
                    dataSource: chartData,
                    innerRadius: '85%',
                    maximumValue: 100,
                    pointColorMapper: (ChartData2 data, _) =>
                    type == DailyHealthType.sleep
                        ? AppColors.primaryColor
                        : AppColors.stepChartColor,
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
                      StyleText(
                          text: type == DailyHealthType.sleep
                              ? '수면시간'
                              : '걸음 수',
                          color: Colors.grey
                      ),
                    ],
                  ),
                  const Gap(5),

                  StyleText(
                      text: mainValue,
                      fontWeight: FontWeight.w600,
                      size: AppDim.fontSizeLarge),
                  const Gap(20),

                  InkWell(
                    onTap: ()=> function(type),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StyleText(
                                text: type == DailyHealthType.sleep
                                    ? '목표 수면 시간'
                                    : '목표 걸음 수',
                                color: Colors.grey,
                                size: AppDim.fontSizeSmall,
                            ),
                            const Gap(AppDim.xSmall),

                            const Icon(Icons.arrow_drop_down, size: 20, color: AppColors.grey)
                          ],
                        ),

                        StyleText(
                            text: '$targetValue${type == DailyHealthType.sleep? '시간': ''}',
                            fontWeight: AppDim.weightBold,
                            size: AppDim.fontSizeLarge,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }


}

class ChartData2 {
  late String x;
  late double y;

  ChartData2(this.x, this.y);
}
