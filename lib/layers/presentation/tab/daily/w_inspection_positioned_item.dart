

import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../../model/enum/lifelog_data_type.dart';
import '../../widgets/style_text.dart';
import 'd_daily_bottom_sheet_view.dart';

class InspectionPositionedItem extends StatelessWidget {
  final double? left;
  final double? top;
  final double? right;
  final String label;
  final LifeLogDataType type;
  final String date;

  const InspectionPositionedItem({
    super.key,
    this.left,
    this.top,
    this.right,
    required this.label,
    required this.type,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left,
        top: top,
        right: right,
        bottom: null,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return DailyBottomSheetView(type: type, selectedDate: date,);
                });
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                width: AppConstants.borderLightWidth,
                color: AppColors.primaryColor,
              ),
              borderRadius: AppConstants.borderRadius,
            ),

            padding: const EdgeInsets.all(AppDim.xSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(
                  text: label,
                  color: AppColors.primaryColor,
                  size: AppDim.fontSizeSmall,
                  softWrap: true,
                  maxLinesCount: 2,
                  align: TextAlign.center,
                  fontWeight: AppDim.weightBold,
                ),
              ],
            ),
          ),
        ));
  }
}
