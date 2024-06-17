import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/point/v_my_health_point.dart';
import 'package:ghealth_app/view/point/my_health_point_view.dart';

import '../../../../../common/common.dart';
import '../../../../../common/util/text_format.dart';
import '../../../widgets/style_text.dart';

class PointBox extends StatelessWidget {
  final String totalPoint;
  final bool isOnTap;

  const PointBox({
    super.key,
    required this.totalPoint,
    required this.isOnTap,
  });

  double get boxHeight => 140;
  double get boxHeaderHeight => 50;
  double get boxContentHeight => 80;

  String get title => '나의 건강 포인트';
  String get pointContent1 => '나의 건강 포인트 확인하고';
  String get pointContent2 => '저럼하게 진료받으세요!';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (isOnTap){
          Nav.doPush(context, MyHealthPointViewTest(totalPoint: totalPoint)),
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: boxHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: boxHeaderHeight,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDim.large,
                vertical: AppDim.medium,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: AppConstants.mediumRadius,
                  topRight: AppConstants.mediumRadius,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: StyleText(
                  text: title,
                  color: AppColors.white,
                  fontWeight: AppDim.weightBold,
                ),
              ),
            ),

            /// 포인트 이미지, 포인트 점수
            Container(
              height: boxContentHeight,
              padding: const EdgeInsets.symmetric(horizontal: AppDim.large),
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: AppConstants.mediumRadius,
                  bottomLeft: AppConstants.mediumRadius,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(-1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/point.png',
                    color: AppColors.primaryColor,
                    height: 40,
                    width: 40,
                  ),
                  const Gap(AppDim.small),

                  StyleText(
                    text:
                        '${TextFormat.formatNumberWithCommas(int.parse(totalPoint))}P',
                    size: AppDim.fontSizeXxLarge,
                    fontWeight: AppDim.weight500,
                  ),
                  const Gap(AppDim.xSmall),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyleText(
                        text: pointContent1,
                        size: AppDim.fontSizeSmall
                      ),
                      StyleText(
                        text: pointContent2,
                        fontWeight: AppDim.weightBold,
                        size: AppDim.fontSizeSmall,
                      ),
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
