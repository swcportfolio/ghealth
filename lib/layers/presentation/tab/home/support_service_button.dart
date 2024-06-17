import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';

import '../../widgets/style_text.dart';

class SupportServiceButton extends StatelessWidget {
  const SupportServiceButton({super.key});

  String get btnLabel => '지원 서비스 더 알아보기';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: OutlinedButton(
        onPressed: () => {
          Nav.doLaunchUniversalLink(Uri(
            scheme: 'https',
            host: 'www.ghealth.or.kr',
            path: '/service/healthCare',
          ))
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          elevation: 3,
          minimumSize: Size(double.infinity, AppConstants.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppConstants.radius),
          ),
          side: BorderSide(
              color: AppColors.primaryColor,
              width: AppConstants.borderBordWidth,
          ),
        ),
        child: StyleText(
          text: btnLabel,
          color: AppColors.primaryColor,
          size: AppDim.fontSizeMedium,
          fontWeight: AppDim.weightBold,
        ),
      ),
    );
  }
}
