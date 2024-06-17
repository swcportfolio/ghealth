

import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/vm_reservation.dart';

import '../../../../common/common.dart';
import '../../widgets/style_text.dart';

class TimeItem extends StatelessWidget {
  final String time;
  final ReservationViewModelTest provider;
  final bool selected;
  final int index;

  const TimeItem({
    super.key,
    required this.time,
    required this.provider,
    required this.selected,
    required this.index,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => provider.onTapSelectItem(index),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : AppColors.white,
          border: Border.all(
            color: selected ? AppColors.primaryColor : AppColors.grey,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: AppConstants.borderRadius,
        ),
        child: Center(
          child: StyleText(
              text: time,
              fontWeight: selected ? AppDim.weightBold : AppDim.weightLight,
              color: selected ? AppColors.whiteTextColor : AppColors.blackTextColor
          ),
        ),
      ),
    );
  }

}
