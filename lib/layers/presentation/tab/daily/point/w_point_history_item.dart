
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/entity/point_history_dto.dart';

import '../../../../../common/util/text_format.dart';
import '../../../widgets/style_text.dart';


/// 포인트 적립, 사용 내역 리스트 아이템
class PointHistoryItem extends StatelessWidget {
  const PointHistoryItem({
    super.key,
    required this.pointHistory
  });

  final PointHistoryDataDTO pointHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(5, 20, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyleText(
                  text: pointHistory.pointDesc,
                  fontWeight: AppDim.weightBold,
              ),
              const Gap(5),

              StyleText(
                  text: TextFormat.pointDateFormat(pointHistory.createDT),
                  size: AppDim.fontSizeSmall,
                  color: AppColors.greyTextColor,
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StyleText(
                text: '${pointHistory.pointType == '적립' ? '+' : '-'}${pointHistory.point}P',
                size: AppDim.fontSizeLarge,
                color: pointHistory.pointType == '적립'
                    ? Colors.blueAccent
                    : Colors.redAccent,
                fontWeight: AppDim.weightBold,
              ),
              const Gap(AppDim.small),

              StyleText(
                  text: pointHistory.pointType,
                  color: AppColors.greyTextColor
              ),
            ],
          ),
        ],
      ),
    );
  }
}