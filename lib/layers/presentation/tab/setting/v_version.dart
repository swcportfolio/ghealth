import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/widgets/frame_scaffold.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';

import '../../../../common/constants/app_strings.dart';

class VersionView extends StatelessWidget {
  const VersionView({super.key});

  String get title => '앱버전';

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,
      body: Center(
        child: StyleText(
          text: '현재 앱 버전 ${AppStrings.appVersion}',
          color: AppColors.greyTextColor,
          size: AppDim.fontSizeLarge,
        ),
      ),
    );
  }
}
