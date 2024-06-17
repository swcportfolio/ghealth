
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/auth/vm_login.dart';
import 'package:ghealth_app/layers/presentation/auth/w_auth_text_fields.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../../../common/util/app_keyboard_util.dart';
import '../widgets/style_text.dart';
import 'w_login_button.dart';

/// 로그인 화면
class LoginViewTest extends StatefulWidget {
  const LoginViewTest({super.key});

  @override
  State<LoginViewTest> createState() => _LoginViewTestState();
}

class _LoginViewTestState extends State<LoginViewTest> {

  String get licenseText => '©2024 KIMIRo, Inc. All rights reserved.';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModelTest(),
      child: Consumer<LoginViewModelTest>(
        builder: (context, provider, child) {
          return  Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: SafeArea(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () => AppKeyboardUtil.hide(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        /// 메인 BI 이미지 위젯
                        biImage(),
                        const Gap(AppDim.xXLarge),

                        /// 휴대본 인증
                        const AuthTextFields(),

                        /// 로그인 버튼
                        LoginButton(
                            onPressed: () => provider.login(context)
                        ),
                        const Gap(AppDim.xXLarge),
                      ],
                    ),
                  ),

                  /// 라이센스 마크
                  licenseMark()
                ],
              ),
            ),
          );
        }
      )
    );
  }

  /// 메인 BI 이미지
  Widget biImage() => Image.asset(
      'images/bi_white.png',
      height: 100,
      width: 200,
    );


  /// 라이센스 마크
  Widget licenseMark() => Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      margin: const EdgeInsets.only(bottom: AppDim.medium),
      child: StyleText(
        text: licenseText,
        color: AppColors.whiteTextColor,
        size: AppDim.fontSizeSmall,
        fontWeight: AppDim.weightBold,
      ),
    ),
  );
}

