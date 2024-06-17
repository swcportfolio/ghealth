import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/widgets/frame_container.dart';

import '../../../../common/common.dart';
import '../../widgets/style_text.dart';

/// 건강검진 종합 소견
class ComprehensiveExamination extends StatelessWidget {

  final String issuedDate;
  final String resultTitleText;
  final String additionalText;

  const ComprehensiveExamination({
    super.key,
    required this.issuedDate,
    required this.resultTitleText,
    required this.additionalText,
  });

  String get title => '건강 검진 종합 소견';

  @override
  Widget build(BuildContext context) {
    return FrameContainer(
      backgroundColor: AppColors.white,
      borderColor: AppColors.lightGreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyleText(
                text: title,
                fontWeight: AppDim.weightBold,
              ),
              StyleText(
                text: '최근 검진일 : $issuedDate',
                size: AppDim.fontSizeXSmall,
              )
            ],
          ),
          const Gap(AppDim.medium),

          Container(
            padding: AppDim.paddingSmall,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(AppConstants.lightRadius),
              color: AppColors.lightGreen,
            ),
            child: Center(
              child: StyleText(
                text: resultTitleText,
                color: AppColors.white,
                softWrap: true,
                maxLinesCount: 7,
                fontWeight: AppDim.weightBold,
                size: AppDim.fontSizeLarge,
              ),
            ),
          ),
          const Gap(AppDim.medium),
          SizedBox(
            width: double.infinity,
            child: StyleText(
                text: '• $additionalText',
                maxLinesCount: 4,
                size: AppDim.fontSizeSmall,
                softWrap: true),
          ),
        ],
      ),
    );
  }
}