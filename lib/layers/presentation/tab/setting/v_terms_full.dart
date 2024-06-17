import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/model/terms_vo.dart';
import 'package:ghealth_app/layers/presentation/widgets/frame_scaffold.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_view_padding.dart';


/// 전체 이용약관 화면
class TermsFullView extends StatelessWidget {
  TermsFullView({super.key});

  final termsText = TermsContent();

  String get title => '이용 약관 및 정책';

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            ViewPadding(
              child: Container(
                  width:MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(border: Border.all(
                      width: AppConstants.borderMediumWidth,
                      color: AppColors.primaryColor,
                  ),
                    borderRadius: AppConstants.borderLightRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppDim.mediumLarge),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        /// 서비스 이용약관
                        Padding(
                          padding: const EdgeInsets.all(AppDim.small),
                          child: StyleText(
                            text: termsText.serviceTitle,
                            size: AppDim.fontSizeXLarge,
                            fontWeight: AppDim.weightBold,
                          ),
                        ),
                        Text(termsText.serviceContent),

                        /// 개인정보 처리 방침
                        Padding(
                          padding: const EdgeInsets.all(AppDim.small),
                          child: StyleText(
                            text: termsText.privacyTitle,
                            size: AppDim.fontSizeXLarge,
                            fontWeight: AppDim.weightBold,
                          ),
                        ),
                        Text(termsText.privacyContent),

                      ],
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
