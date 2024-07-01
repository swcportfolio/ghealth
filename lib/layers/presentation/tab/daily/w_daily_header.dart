

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../model/authorization_test.dart';
import '../../widgets/style_text.dart';

class DailyHeader extends StatelessWidget {
  const DailyHeader({super.key});

  String get subTitle => '계측검사 • 걸음 수 • 심박수에 대한\n정보를 제공합니다.';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDim.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StyleText(
                  text: '${AuthorizationTest().userName}님의 ',
                  size: AppDim.fontSizeXLarge,
                  fontWeight: AppDim.weightBold,
              ),
              StyleText(
                text: '일상 기록',
                size: AppDim.fontSizeXLarge,
                fontWeight: AppDim.weightBold,
                color: AppColors.primaryColor,
              )
            ],
          ),
          const Gap(AppDim.xSmall),

          StyleText(
              text: subTitle,
              maxLinesCount: 2
          ),
        ],
      ),
    );
  }
}
