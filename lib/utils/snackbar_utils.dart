import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../data/enum/snackbar_status_type.dart';
import '../widgets/frame.dart';
import 'colors.dart';

class SnackBarUtils {

  /// 일반 스낵바
  static showDefaultSnackBar(
      String message,
      BuildContext context,
      {int seconds = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: seconds),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      content: Frame.myText(text: message, fontSize: 1.0, color: Colors.black),
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
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, size: 30),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Frame.myText(
                      text: message,
                      fontSize: 1.1,
                      fontWeight: FontWeight.w600),
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
        backgroundColor = mainColor;
        break;
      case SnackBarStatusType.failure:
        icon = Icons.error;
        backgroundColor = Colors.orange.shade500;
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
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Frame.myText(
                    text: message,
                    fontSize: 1.1,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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
