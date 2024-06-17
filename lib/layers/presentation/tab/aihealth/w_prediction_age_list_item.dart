import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';

import '../../widgets/style_text.dart';

class PredictAgeListItem extends StatelessWidget {

  final String title;
  final String age;

  const PredictAgeListItem({
    super.key,
    required this.title,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.boxItemHeight60,
      padding: const EdgeInsets.symmetric(horizontal: AppDim.large),
      margin: const EdgeInsets.only(bottom: AppDim.small),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppConstants.borderRadius,
          border: Border.all(
              color: AppColors.greyBoxBorder,
              width: AppConstants.borderMediumWidth,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StyleText(
            text: title,
          ),

          Padding(
            padding: const EdgeInsets.only(right: AppDim.medium),
            child: StyleText(
                text: '$age세 발생 예상',
                size: AppDim.fontSizeSmall,
                fontWeight: AppDim.weightBold,
            ),
          ),
        ],
      ),
    );
  }
}