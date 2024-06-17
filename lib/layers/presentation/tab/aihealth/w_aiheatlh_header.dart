

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';

import '../../widgets/style_text.dart';

class AiHealthHeader extends StatelessWidget {
  const AiHealthHeader({super.key});

  String get title =>'AI 건강 예측';
  String get subTitle =>'발병 예측 확률을 보여줍니다.';

  @override
  Widget build(BuildContext context) {
    return  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              StyleText(
                text: title,
                color: AppColors.primaryColor,
                fontWeight: AppDim.weightBold,
                size: AppDim.fontSizeXxLarge,
              ),
              const Gap(AppDim.xSmall),

              StyleText(
                text: subTitle,
              ),
            ],
          )
        ]
    );
  }
}
