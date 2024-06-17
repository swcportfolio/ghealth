import 'package:flutter/material.dart';
import '../../../common/common.dart';
import '../widgets/style_text.dart';

class LoginButton extends StatelessWidget {

  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.onPressed,
  });

  String get btnText => '로그인';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDim.medium),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(double.infinity, AppConstants.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppConstants.radius)
          ),
          side: BorderSide(
              color: AppColors.white,
              width: AppConstants.borderBordWidth
          ),
        ),
        child: StyleText(
          text: btnText,
          color: AppColors.whiteTextColor,
          size: AppDim.fontSizeMedium,
          fontWeight: AppDim.weightBold,
        ),
      ),
    );
  }
}
