

import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_dimensions.dart';

class DefaultButton extends StatelessWidget {
  final String btnName;
  final Function() onPressed;

  const DefaultButton({
    super.key,
    required this.btnName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, AppConstants.buttonHeight),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppConstants.radius)
        ),
      ),
      child: StyleText(
        text: btnName,
        color: AppColors.whiteTextColor,
        fontWeight: AppDim.weightBold,
      ),
    );
  }
}
