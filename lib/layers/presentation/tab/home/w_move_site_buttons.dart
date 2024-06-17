import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../model/enum/site_type.dart';
import '../../widgets/style_text.dart';

class MoveSiteButtons extends StatelessWidget {
  const MoveSiteButtons({super.key});

  String get btnLabel => '예약하기';

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
      [
        /// 광주 광산구 버튼
        sitButtonBox(
          SiteType.gwangsangu,
        ),
        const Gap(AppDim.medium),

        /// 광주 광산구 버튼
        sitButtonBox(
          SiteType.donggu,
        ),
      ],
    );
  }


  sitButtonBox(SiteType type) {
    return Expanded(
      child: InkWell(
        onTap: () => {
          Nav.doLaunchUniversalLink(Uri(
            scheme: 'https',
            host: type.host,
          )),
        },
        child: Container(
          height: 330,
          decoration: BoxDecoration(
            borderRadius: AppConstants.borderRadius,
            color: type.bgColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                spreadRadius: 1,
                blurRadius: 9,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(AppDim.xLarge),

                    Image.asset(type.imagePath),
                    const Gap(AppDim.large),

                    StyleText(
                      text: '${type.name}\n라이프로그\n건강관리소',
                      fontWeight: AppDim.weightBold,
                      color: AppColors.whiteTextColor,
                      maxLinesCount: 3,
                      align: TextAlign.center,
                      size: AppDim.fontSizeLarge,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: type.subColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: AppConstants.radius,
                          bottomRight: AppConstants.radius,
                      )),
                  child: Center(
                    child: StyleText(
                      text: btnLabel,
                      color: AppColors.white,
                      fontWeight: AppDim.weightBold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
