import 'package:flutter/material.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/utils/constants.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/frame.dart';

class VersionView extends StatelessWidget {
  const VersionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metrologyInspectionBgColor,
      appBar: const CustomAppBar(title: '앱 버전', isIconBtn: false),

      body: Center(
        child: Frame.myText(
          text: '현재 앱 버전 ${Constants.appVersion}',
          fontSize: 1.3,
          color: Colors.grey
        ),
      ),
    );
  }
}
