import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utlis/colors.dart';
import '../../utlis/etc.dart';
import 'login_viewmodel.dart';

enum LoginInput {
  identifier,
  password
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              // 아이디 입력 필드
              buildLoginTextField(
                  iconData: Icons.account_circle_outlined,
                  hint: '아이디를 입력해주세요.',
                  inputType: LoginInput.identifier,
                  controller: _viewModel.idController
              ),

              // 비밀번호 입력 필드
              buildLoginTextField(
                  iconData: Icons.account_circle_outlined,
                  hint: '아이디를 입력해주세요.',
                  inputType: LoginInput.identifier,
                  controller: _viewModel.passwordController
              ),
            ],
          ),
        ),
      ),
    );
  }


  /// 로그인 화면에서 사용되는 텍스트 입력 위젯을 생성하는 함수.
  ///
  /// [iconData]: 입력란 왼쪽에 표시할 아이콘.
  /// [hint]: 입력란에 사용자에게 표시할 힌트 텍스트.
  /// [inputType]: 입력란의 유형을 지정하는 열거형 (예: LoginInput.identifier, LoginInput.password).
  /// [controller]: 입력란의 데이터를 관리하기 위한 TextEditingController.
  ///
  /// retrun value: 텍스트 입력 위젯을 포함한 컨테이너 위젯.
  ///
  /// 이 함수는 로그인 화면에서 사용되며, 주어진 아이콘, 힌트, 입력 유형 및 컨트롤러를 기반으로
  /// 사용자에게 표시되는 입력란을 생성합니다. [inputType]이 LoginInput.password인 경우
  /// 입력란은 비밀번호 입력을 위한 것으로 처리되며 텍스트가 가려진다.
  /// TODO: 입력시 띄워쓰기는 지워줘야된다.
  Widget buildLoginTextField({
    required IconData iconData,
    required String hint,
    required LoginInput inputType,
    required TextEditingController controller
  }){
    return Container(
        alignment: Alignment.centerLeft,
        height: 60.0,
        child: MediaQuery(
          data: Etc.getScaleFontSize(context, fontSize: 0.75),
          child: TextField(
            autofocus: false,
            obscureText: inputType == LoginInput.password? true : false,
            controller: controller,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                fillColor: mainColor,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: textFieldBorderColor, width: 1.0)),
                contentPadding: const EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(iconData, color: mainColor),
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)
            ),
          ),
        )
    );
  }
}

