

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';

/// 포인트 Q&A
class PointAccumulate extends StatelessWidget {
  const PointAccumulate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDim.small),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyleText(
                text: '포인트 Q&A',
                size: AppDim.fontSizeLarge,
                fontWeight: AppDim.weightBold,
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(AppDim.mediumLarge),
          margin: const EdgeInsets.all(AppDim.small),
          decoration: BoxDecoration(
              borderRadius: AppConstants.borderMediumRadius,
              color: const Color(0xfff4f4f4)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: AppDim.xSmall,
                    horizontal: AppDim.small,
                ),
                decoration: BoxDecoration(
                    borderRadius: AppConstants.borderRadius,
                    border: Border.all(
                        color: AppColors.greyDarkBoxBorder,
                        width: AppConstants.borderLightWidth,
                    ),
                    color: Colors.white
                ),
                child: const StyleText(
                    text: "포인트 어떻게 적립하나요?",
                    fontWeight: AppDim.weightBold,
                ),
              ),
              const Gap(AppDim.small),

              const Padding(
                padding: EdgeInsets.only(left: AppDim.small),
                child: StyleText(
                    text: '<포인트 정책>\n- 회원가입 및 라이프로그 장비 측정 : 5,000p\n- 마이데이터 제공 : 5,000p\n- 진단서, 처방전 등록 : 5,000p(유효기간 3년 이내 고혈압, 당뇨 진단서, 처방전 한하며 1인 1회 포인트 제공)\n- 일일 출석체크 : 30p\n- 일일 건강퀴즈 :  20p\n- 걷기 챌린지 : 200p(1일 목표걸음 8천보, 1주일 중 4일 이상 달성 시 지급)\n- 영상시청 후 퀴즈풀기 : 50p',
                    size: AppDim.fontSizeSmall,
                    softWrap: true,
                    maxLinesCount: 700
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
