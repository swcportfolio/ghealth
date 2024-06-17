

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/vm_daily.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/w_health_circular_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../../../model/authorization_test.dart';
import '../../../model/enum/daily_health_type.dart';
import '../../widgets/style_text.dart';

class WearableChats extends StatelessWidget {
  const WearableChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: AppConstants.borderMediumRadius,
            border: Border.all(
                width: AppConstants.borderMediumWidth,
                color: AppColors.greyBoxBorder,
            )),
        child: Consumer<DailyViewModelTest>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                const Gap(AppDim.large),

                /// 웨어러블 박스 상단 타이틀
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDim.large),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StyleText(
                              text: '${AuthorizationTest().userName} 님의 웨어러블',
                              size: AppDim.fontSizeLarge,
                              fontWeight: AppDim.weightBold
                          ),
                          const Gap(AppDim.xSmall),
                          const StyleText(
                              text: '목표 걸음, 수면시간을 설정해보세요.',
                              size: AppDim.fontSizeSmall,
                          ),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: provider.permissionDenied,
                      child: GestureDetector(
                        onTap: ()=> provider.retryHealthPermission(context),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StyleText(
                                text: '접근 권한\n재 요청',
                                size: AppDim.fontSizeXSmall,
                                color: AppColors.darkOrange,
                                maxLinesCount: 2,
                                align: TextAlign.center,
                                fontWeight: AppDim.weightBold,
                            ),
                            Icon(Icons.refresh,
                              color: AppColors.darkOrange,
                            ),
                            Gap(AppDim.large),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(AppDim.small),

                /// 걸음 수 진행
                HealthCircularChart(
                  mainValue: provider.dayStep,
                  targetValue: provider.targetStep,
                  type: DailyHealthType.step,
                  function: (type)=> provider.showCustomDialog(type, context),
                  chartData: [ChartData2('B', Branch.calculateAchievementRate(int.parse(provider.dayStep) , int.parse(provider.targetStep)))],
                ),

                /// 수면 시간 진행
                HealthCircularChart(
                  mainValue:'${(provider.daySleep) ~/ 60}시간',
                  targetValue: provider.targetSleep,
                  type: DailyHealthType.sleep,
                  function: (type)=> provider.showCustomDialog(type, context),
                  chartData: [ChartData2('A', Branch.calculateAchievementRate((provider.daySleep) ~/ 60, int.parse(provider.targetSleep)))],
                ),

                /// 최근 심박동 표시
                Padding(
                  padding: const EdgeInsets.all(AppDim.mediumLarge),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                              Icons.monitor_heart_outlined,
                              color: Colors.redAccent,
                          ),
                          const Gap(AppDim.small),

                          StyleText(
                            text: '심박수',
                            size: AppDim.fontSizeLarge,
                            fontWeight: AppDim.weight500,
                            color: AppColors.greyTextColor,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Gap(AppDim.small),

                          Image.asset(
                            '${AppStrings.imagePath}/tab/daily/heart_rate.png',
                            height: 100,
                            width: 100,
                          ),
                          const Gap(AppDim.xSmall),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StyleText(
                                text: provider.dayHeartRate,
                                size: AppDim.fontSizeXLarge,
                                fontWeight: AppDim.weight500,
                              ),
                              const StyleText(
                                text: 'BPM',
                                size: AppDim.fontSizeLarge,
                                fontWeight: AppDim.weight500,
                                color: Colors.redAccent,
                              )
                            ],
                          ),
                          const Gap(AppDim.xLarge),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StyleText(
                                text: '측정 일시',
                                fontWeight: AppDim.weight500,
                                color: AppColors.greyTextColor,
                              ),
                              StyleText(
                                  text: DateFormat('yyyy-MM-dd\nHH:mm').format(provider.heartRateDate),
                                  softWrap: true,
                                  align: TextAlign.start,
                                  size: AppDim.fontSizeSmall,
                                  fontWeight: AppDim.weightBold,
                                  maxLinesCount: 3,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(AppDim.small),

              ],
            );
          },
        )
    );
  }

}
