import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/vm_reservation.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';
import 'package:provider/provider.dart';

import '../../../../common/common.dart';

import 'w_time_item.dart';

class SelectTime extends StatelessWidget {
  const SelectTime({super.key});

  String get title => '시간을 선택해 주세요.';
  String get emptyTimeText => '예약가능한 시간이 없습니다.';

  @override
  Widget build(BuildContext context) {
    return Consumer<ReservationViewModelTest>(
      builder: (BuildContext context, value, Widget? child) {
        return Visibility(
          visible: value.isVisibleSelectTime,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDim.small),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: AppColors.primaryColor,
                      size: AppDim.iconSmall,
                    ),
                    const Gap(AppDim.xSmall),
                    StyleText(
                      text: title,
                      size: AppDim.fontSizeLarge,
                      fontWeight: AppDim.weight500,
                    ),
                  ],
                ),
                const Gap(AppDim.medium),
                _buildSelectTimeGridview(value.possibleDateTime)
              ],
            ),
          ),
        );
      },
    );
  }

  /// 선택할 시간 그리드뷰
  _buildSelectTimeGridview(List<String> possibleDateTimeList) {
    return Consumer<ReservationViewModelTest>(
      builder: (context, provider, child) {
        return possibleDateTimeList.isEmpty
            ? Container(
                height: 45,
                padding: const EdgeInsets.all(AppDim.medium),
                margin: const EdgeInsets.only(bottom: AppDim.xLarge),
                decoration: BoxDecoration(
                    color: AppColors.signupTextFieldBg,
                    borderRadius: AppConstants.borderLightRadius),
                child: StyleText(
                  text: emptyTimeText,
                  size: AppDim.fontSizeSmall,
                ))
            : SizedBox(
                width: double.infinity,
                child: GridView.builder(
                  itemCount: possibleDateTimeList.length,
                  scrollDirection: Axis.vertical,
                  reverse: false,
                  controller: ScrollController(),
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(AppDim.xSmall),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 3.1,
                  ),
                  semanticChildCount: 3,
                  cacheExtent: 0.0,
                  dragStartBehavior: DragStartBehavior.start,
                  clipBehavior: Clip.hardEdge,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  itemBuilder: (BuildContext context, int index) {
                    return TimeItem(
                        time: possibleDateTimeList[index],
                        provider: provider,
                        selected: provider.isSelectedList[index],
                        index: index,
                    );
                  },
                  // List of Widgets
                ),
              );
      },
    );
  }
}
