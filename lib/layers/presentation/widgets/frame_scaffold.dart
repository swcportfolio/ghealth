import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_dimensions.dart';
import '../../../common/util/app_keyboard_util.dart';
import 'custom_app_bar.dart';

class FrameScaffold extends StatelessWidget {
  final String appBarTitle;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool isKeyboardHide;
  final bool isActions;

  const FrameScaffold({
    super.key,
    required this.appBarTitle,
    this.backgroundColor = AppColors.white,
    this.isKeyboardHide = false,
    required this.body,
    this.bottomNavigationBar,
    this.isActions = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {if (isKeyboardHide) AppKeyboardUtil.hide(context)},
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(title: appBarTitle, isActions: isActions,),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: body,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
