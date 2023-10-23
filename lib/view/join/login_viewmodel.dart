

import 'package:flutter/cupertino.dart';

import '../../widgets/dialog.dart';

class LoginViewModel extends ChangeNotifier {
  late BuildContext context;

  /// 아이디 입력 필드 컨트롤러
  final _idController = TextEditingController();

  /// 비밀번호 입력 필드 컨트롤러
  final _passwordController = TextEditingController();

  TextEditingController get idController => _idController;
  TextEditingController get passwordController => _passwordController;


  handleLogin() {

  }


  /// 사용자의 로그인 정보(아이디,비밀번호) 유효성을 검사하는 함수.
  ///
  /// 이 함수는 사용자가 제출한 로그인 정보의 유효성을 확인합니다. 현재는 아이디와 비밀번호 필드를 검사하며,
  /// 아무 값도 입력되지 않은 경우에는 알림 다이얼로그를 표시하고, 유효하지 않은 로그인 시도로 처리됩니다.
  ///
  /// return value: 로그인 정보가 유효한 경우 true를 반환하고, 그렇지 않으면 false를 반환합니다.
  bool checkLoginValidity() {
    if(_idController.text.isEmpty){
      CustomDialog.showMyDialog(
        title: '로그인 확인',
        content: "아이디를 입력해주세요.",
        mainContext: context,
      );
      return false;
    } else if( _idController.text.isNotEmpty){
      CustomDialog.showMyDialog(
          title: '로그인 확인',
          content: '비밀번호를 입력해주세요.',
          mainContext: context
      );
      return false;
    }
    return true;
  }

}