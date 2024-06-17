import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';

import '../../layers/model/enum/snackbar_status_type.dart';

class SnackBarUtils {

  /// 일반 스낵바
  static showDefaultSnackBar(
      String message,
      BuildContext context,
      {int seconds = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: seconds),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.white,
      content: StyleText(
          text: message,
          size: AppDim.fontSizeSmall,
          color: AppColors.blackTextColor,
      ),
    ));
  }

  /// BG White 스낵바
  static showBGWhiteSnackBar(
      String message,
      BuildContext context,
      {int seconds = 5}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: seconds),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Container(
        padding: const EdgeInsets.all(8.0),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppConstants.borderLightRadius,
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, size: AppDim.iconSmall),
            const Gap(AppDim.mediumLarge),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleText(
                    text: message,
                    fontWeight: AppDim.weightBold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  /// Shows a custom SnackBar with specified message and status type.
  ///
  /// This method displays a SnackBar with an icon and background color
  /// determined by the provided [statusType]. It allows customization of
  /// the display duration through the optional [seconds] parameter.
  static void showStatusSnackBar({
    required BuildContext context,
    required String message,
    required SnackBarStatusType statusType,
    int seconds = 3,
  }) {
    IconData icon;
    Color backgroundColor;

    switch (statusType) {
      case SnackBarStatusType.success:
        icon = Icons.check_circle;
        backgroundColor = AppColors.primaryColor;
        break;
      case SnackBarStatusType.failure:
        icon = Icons.error;
        backgroundColor = AppColors.lightOrange;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: seconds),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Container(
        padding: const EdgeInsets.all(8.0),
        height: 55,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: AppConstants.borderLightRadius,
        ),
        child: Row(
          children: [
            Icon(icon,  color: Colors.white, size: AppDim.iconSmall),
            const Gap(AppDim.mediumLarge),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleText(
                    text: message,
                    color: AppColors.white,
                    fontWeight: AppDim.weightBold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}