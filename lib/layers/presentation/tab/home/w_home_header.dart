
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';

import '../../../../common/common.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String get appName => 'GHealth';
  String get healthServiceText => '건강관리 서비스란?';
  String get subTitle => '3개의 건강 주제와 헬스케어 장비를 중심으로\n시민 개인의 건강기록 통합 • 관리 및 전문인력이\n맞춤형 상담을 제공하는 서비스';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children:
          [
            /// 메인 타이틀
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(
                    text: appName,
                    fontWeight: AppDim.weightBold,
                    size: AppDim.fontSizeXxxLarge,
                    color: AppColors.primaryColor,
                ),
                StyleText(
                  text: healthServiceText,
                  fontWeight: AppDim.weightLight,
                  size: AppDim.fontSizeXxxLarge,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            const Gap(AppDim.small),

            /// 오른쪽 상단 최고 이미지
            Image.asset(
                '${AppStrings.imagePath}/tab/home/best_image.png',
                height: 100,
                width: 100
            )

          ],
        ),
        const Gap(AppDim.small),

        /// 서브 타이틀
        SizedBox(
          width: size.width/2,
          child: StyleText(
              text: subTitle,
              maxLinesCount: 3,
          ),
        ),
        const Gap(AppDim.large),

      ],
    );
  }
}
