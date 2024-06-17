

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/aihealth/w_prediction_age_list_item.dart';

import '../../../../common/common.dart';
import '../../../entity/ai_health_dto.dart';
import '../../widgets/style_text.dart';

class PredictionAge extends StatelessWidget {
  final AiHealthData? aiHealthData;

  const PredictionAge({
    super.key,
    this.aiHealthData,
  });

  String get title => 'AI 질환 예측 나이';

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
        children: [
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
                children:
                [
                  PredictAgeListItem(title: '고혈압', age: aiHealthData?.hypertensionAge ?? ''),
                  PredictAgeListItem(title: '당뇨병', age: aiHealthData?.diabetesAge?? ''),
                  PredictAgeListItem(title: '비만', age: aiHealthData?.obesityAge?? ''),
                  PredictAgeListItem(title: '간', age: aiHealthData?.liverAge?? ''),
                ],
              )
          )
        ],
      ),
    );
  }
}
