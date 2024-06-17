import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PredictListItem extends StatelessWidget {
  final String title;
  final Color indicatorColor;
  final double percent;
  final String state;

  const PredictListItem({
    super.key,
    required this.title,
    required this.indicatorColor,
    required this.percent,
    required this.state,
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
              width: AppConstants.borderMediumWidth)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: StyleText(
              text: title,
            ),
          ),

          Expanded(
            flex: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: LinearPercentIndicator(
                    animation: true,
                    animationDuration: 100,
                    lineHeight: 18.0,
                    percent: double.parse(percent.toStringAsFixed(2)),
                    progressColor: indicatorColor,
                    backgroundColor: AppColors.greyBoxBg,
                    barRadius: const Radius.circular(10),
                  ),
                ),

                StyleText(
                    text: state,
                    color: indicatorColor,
                    size: AppDim.fontSizeSmall,
                    fontWeight: AppDim.weightBold,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}