import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';

/// 포인트 설명 글 헬퍼
class PointDescription extends StatelessWidget {
  const PointDescription({super.key});

  String get title => '건강 포인트란?';
  String get subTitle => '건강포인트는 G-Health 플랫폼에서 제공되는 \n다양한 재화와 서비스를 구매·이용할 수있는 현금처럼\n사용가능한 가상의 화폐입니다.';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppDim.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          const Gap(AppDim.medium),

          StyleText(
            text: title,
            color: AppColors.primaryColor,
            fontWeight: AppDim.weightBold,
            size: AppDim.fontSizeXxLarge,
            align: TextAlign.start,
          ),
          const Gap(AppDim.small),

          StyleText(
            text: subTitle,
            size: AppDim.fontSizeSmall,
            align: TextAlign.start,
            maxLinesCount: 5,
            softWrap: true,
          )
        ],
      ),
    );
  }
}
