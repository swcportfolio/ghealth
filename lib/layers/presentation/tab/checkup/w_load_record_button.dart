import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../widgets/style_text.dart';

class LoadRecordButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnName;

  const LoadRecordButton({
    super.key,
    required this.onPressed,
    required this.btnName,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, AppConstants.buttonHeight),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppConstants.lightRadius)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            '${AppStrings.imagePath}/tab/checkup/record.png',
            height: AppDim.imageXxSmall,
            width: AppDim.imageXxSmall,
          ),
          const Gap(AppDim.small),

          StyleText(
            text: btnName,
            color: AppColors.whiteTextColor,
            fontWeight: AppDim.weightBold,
          ),
        ],
      ),
    );
  }
}
