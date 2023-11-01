import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/view/home/home_frame_view.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/etc.dart';
import 'login_viewmodel.dart';

enum LoginInput {
  phone,
  certification
}

/// 로그인 화면 view
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = LoginViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = Provider.of<LoginViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: mainColor,

      body: SafeArea(
        child: GestureDetector(
          onTap: ()=> FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                [
                  // 메인 BI 이미지
                  buildBiImage(),
                  const Gap(40),

                  // 휴대폰 번호 입력 필드
                  buildLoginTextField(
                      hint: '휴대폰 번호 \'-\'제외한 11자리',
                      inputType: LoginInput.phone,
                      controller: _viewModel.phoneController
                  ),
                  const Gap(15),

                  // 인증번호 입력 필드
                    buildLoginTextField(
                      hint: '휴대폰 인증번호',
                      inputType: LoginInput.certification,
                      controller: _viewModel.certificationController
                  ),

                  // 로그인 버튼
                  buildLoginButton(),
                ],
              ),
              // 라이센스 마크
              licenseText()
            ],
          ),
        ),
      ),
    );
  }

  /// 메인 BI 이미지
  Widget buildBiImage() {
    return Image.asset(
      'images/bi_white.png',
      height: 100,
      width: 200,
    );
  }

  /// 로그인 정보 입력 필드를 만드는 위젯을 생성하는 함수.
  ///
  /// [hint]: 입력 필드 내에 나타낼 힌트 텍스트.
  /// [inputType]: 입력 필드의 유형을 나타내는 열거형(LoginInput) 값. 비밀번호 입력 여부 등을 결정하는 데 사용됩니다.
  /// [controller]: 입력 필드의 텍스트 상태를 관리하는 데 사용되는 컨트롤러.
  ///
  /// return value: 위젯(Widget)으로서 전화번호, 인증번호 입력 필드를 포함하는 컨테이너를 반환합니다.
  /// TODO: 입력시 띄워쓰기는 지워줘야된다.
  Widget buildLoginTextField({
    required String hint,
    required LoginInput inputType,
    required TextEditingController controller
  }){
    return Container(
        height: 60.0,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),

        child: Row(
          children: [
            Expanded(
              child: MediaQuery(
                data: Etc.getScaleFontSize(context, fontSize: 1.0),
                child: TextField(
                  autofocus: false,
                  controller: controller,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.black, decorationThickness: 0),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 30.0),
                      hintText: hint,
                      hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)
                  ),
                ),
              ),
            ),
            Visibility(
              visible: inputType == LoginInput.phone? true : false,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: sendBackgroundColor,
                      foregroundColor: sendBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Frame.myText(
                        text: '전송',
                        color: sendTextColor,
                        fontSize: 1.1,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

  /// 로그인 버튼
  Widget buildLoginButton(){
    return InkWell(
      onTap: ()=> Frame.doPagePush(context, const HomeFrameView()),
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(
            color: Colors.white,
            width: 2.0
          )
        ),
        child: Center(
          child: Frame.myText(
              text: '로그인',
              color: Colors.white,
              fontSize: 1.2,
              fontWeight: FontWeight.w600
          ),
        )
      ),
    );
  }

  /// 라이센스 마크
  Widget licenseText(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Frame.myText(
          text: '©2021 KIMIRo, Inc. All rights reserved.',
          color: Colors.grey.shade400,
          fontSize: 1.0,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}

