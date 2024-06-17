import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/common/constants/app_constants.dart';
import 'package:ghealth_app/layers/presentation/tab/setting/v_setting.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_custom_dialog.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_dimensions.dart';
import '../../../view/setting/setting_view.dart';
import '../../model/authorization_test.dart';



/// 커스텀된 AppBar를 나타내는 위젯 클래스.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isActions;

  const CustomAppBar({
    super.key,
    this.title, required this.isActions,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: AppConstants.radius),
        child: AppBar(
          title: StyleText(
            text: title ?? '',
            size: AppDim.fontSizeLarge,
            color: AppColors.whiteTextColor,
            fontWeight: AppDim.weightBold,
          ),
          actions: [
            Visibility(
              visible: isActions,
              child: GestureDetector(
                onTap: ()=>
                {
                  if (AuthorizationTest().token.isEmpty){
                      CustomDialog.showLoginDialog(
                          title: '로그인',
                          content: '인증이 필요합니다.\n 로그인화면으로 이동합니다.',
                          mainContext: context)
                    } else {
                    Nav.doPush(context, const SettingViewTest())
                  }
                }, // 설정화면으로 이동
                child: const Padding(
                  padding: EdgeInsets.all(AppDim.medium),
                  child: Icon(Icons.settings, color: AppColors.white,),
                ),
              ),
            )
          ],
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.white),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
