import 'package:flutter/material.dart';
import 'package:ghealth_app/common/constants/app_dimensions.dart';
import '../../../common/constants/app_colors.dart';

/// AppBar 가 없을 사용되는 back button
class BackArrowButton extends StatelessWidget {
  final VoidCallback onBackPressed;

  const BackArrowButton({
    super.key,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onBackPressed,
      icon: const Icon(Icons.arrow_back, color: AppColors.darkGrey, size: AppDim.iconMedium,),
    );
  }
}
