import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/aihealth/w_prediction_result_list_item.dart';

import '../../../../common/common.dart';
import '../../../entity/ai_health_dto.dart';
import '../../widgets/style_text.dart';

class PredictionResult extends StatelessWidget {
  final AiHealthData? aiHealthData;

  const PredictionResult({
    super.key,
    required this.aiHealthData
  });

  String get title => 'AI 예측 결과';
  String get normalText => '정상예측';
  String get impossibleText => '예측 불가';
  String get zeroText => '0';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDim.medium),
      decoration: BoxDecoration(
          color: AppColors.greyBoxBg,
          borderRadius: AppConstants.borderRadius,
          border: Border.all(
              width: AppConstants.borderMediumWidth,
              color: AppColors.greyBoxBorder,
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
            Padding(
             padding: const EdgeInsets.all(AppDim.small),
             child: StyleText(
                 text: title,
                 fontWeight: AppDim.weightBold,
                 size: AppDim.fontSizeLarge
             ),
           ),
          const Gap(AppDim.small),

          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: AppDim.small),
              child: Column(
                children: [
                  PredictListItem(
                    title: '관절',
                    indicatorColor: aiHealthData?.boneState == normalText
                        ? AppColors.aiHealthBg
                        : aiHealthData?.boneState == impossibleText ? Colors.black : Colors.red,
                    state: aiHealthData?.boneState ?? impossibleText,
                    percent: double.parse(
                      aiHealthData?.boneProb ?? zeroText,
                    ),
                  ),
                  PredictListItem(
                    title: '당뇨병',
                    indicatorColor:
                    aiHealthData?.diabetesState == normalText
                        ? AppColors.aiHealthBg
                        : aiHealthData?.diabetesState == impossibleText ? Colors.black : Colors.red,
                    state: aiHealthData?.diabetesState ?? impossibleText,
                    percent: double.parse(
                      aiHealthData?.diabetesProb ?? zeroText,
                    ),
                  ),
                  PredictListItem(
                    title: '눈건강',
                    indicatorColor: aiHealthData?.eyeState == normalText
                        ? AppColors.aiHealthBg
                        : aiHealthData?.eyeState == impossibleText ? Colors.black : Colors.red,
                    state: aiHealthData?.eyeState ?? impossibleText,
                    percent: double.parse(aiHealthData?.eyeProb ?? zeroText),
                  ),
                  PredictListItem(
                    title: '고혈압',
                    indicatorColor:
                    aiHealthData?.highpressState == normalText
                        ? AppColors.aiHealthBg
                        : aiHealthData?.highpressState == impossibleText ? Colors.black : Colors.red,
                    state: aiHealthData?.highpressState ?? impossibleText,
                    percent: double.parse(
                      aiHealthData?.highpressProb ?? zeroText,
                    ),
                  ),
                  PredictListItem(
                    title: '면역',
                    indicatorColor: aiHealthData?.immuneState == normalText
                        ? AppColors.aiHealthBg
                        : aiHealthData?.immuneState == impossibleText ? Colors.black : Colors.red,
                    state: aiHealthData?.immuneState ?? impossibleText,
                    percent: double.parse(
                      aiHealthData?.immuneProb ?? zeroText,
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
