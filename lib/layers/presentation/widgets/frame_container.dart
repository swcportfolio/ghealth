
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ghealth_app/common/constants/app_constants.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_height_and_width.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_dimensions.dart';

class FrameContainer extends StatelessWidget {
  final double? height;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsets? margin;
  final Widget child;

  const FrameContainer({
    super.key,
    this.height,
    required this.backgroundColor,
    this.margin = const EdgeInsets.all(0.0),
    this.borderColor =  AppColors.transparent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: AppDim.paddingLarge,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(AppConstants.radius),
          border: Border.all(
              width: AppConstants.borderMediumWidth, color: borderColor,
          ),
        boxShadow: const [
          BoxShadow(
              color: AppColors.middleGrey, //New
              blurRadius: 1.0,
              offset: Offset(0, 1))
        ],
      ),
      child: child,
    );
  }
}