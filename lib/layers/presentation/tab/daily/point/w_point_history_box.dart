
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/entity/point_history_dto.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/point/v_point_detail.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/point/w_point_history_list_frame.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';


/// 포인트 사용/적립 내역을 나타내는 위젯박스
class PointHistoryBox extends StatelessWidget {
  final List<PointHistoryDataDTO> pointHistoryList;

  const PointHistoryBox({
    super.key,
    required this.pointHistoryList,
  });

  String get title => '포인트 적립 / 차감 내역';
  String get seeMoreText => '더보기';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDim.small),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              StyleText(
                text: title,
                size: AppDim.fontSizeLarge,
                fontWeight: AppDim.weightBold,
              ),

              InkWell(
                onTap: ()=> Nav.doPush(context, const PointDetailView()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StyleText(
                        text: seeMoreText,
                        size: AppDim.fontSizeSmall,
                        color: AppColors.grey
                    ),
                    const Gap(AppDim.xSmall),

                    const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.grey,
                        size: AppDim.iconXxSmall,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Gap(AppDim.xSmall),

        SizedBox(
            height: pointHistoryList.length < 2 ? 95 : 190,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: AppConstants.borderMediumRadius),
              child: Padding(
                  padding:  const EdgeInsets.symmetric(
                    horizontal: AppDim.large,
                    vertical: AppDim.small,
                  ),
                  child: PointHistoryListFrame(
                    pointHistoryList: pointHistoryList,
                    listCount: 2,
                  )),
            )),
      ],
    );
  }
}
