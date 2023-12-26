import 'package:flutter/material.dart';


/// 로그인 editingController class
class LoginTextEditingController{

  TextEditingController idController   = TextEditingController(); // 아이디
  TextEditingController passController = TextEditingController(); // 비밀번호
  TextEditingController fcmController = TextEditingController(); // fcm 토큰

  Map<String, dynamic> toMap() {
    Map<String, dynamic> toMap = {
      'userId'   : idController.text,
      'password' : passController.text,
      'fcmToken' : fcmController.text,
    };
    return toMap;
  }
}

/// 회원가입 editingController class
class SignEdit{

  TextEditingController emailController = TextEditingController(); // 아메일
  TextEditingController pwdController = TextEditingController(); // 비밀번호
  TextEditingController pwd2Controller = TextEditingController();// 비밀번호 확인

  TextEditingController nameController = TextEditingController(); // 차주 이름
  TextEditingController nickNameController = TextEditingController(); // 닉네임
  TextEditingController carNumberController = TextEditingController(); // 자동차 번호
  TextEditingController cardNumberController1 = TextEditingController();
  TextEditingController cardNumberController2 = TextEditingController();
  TextEditingController cardNumberController3 = TextEditingController();
  TextEditingController cardNumberController4 = TextEditingController();
  TextEditingController cardPeriodController = TextEditingController(); // 카드 유효기간
  TextEditingController cardCVVController = TextEditingController(); // 뒷면 3자리 cvv
  TextEditingController disCountTypeController = TextEditingController(); // 할인 유형

  Map<String, dynamic> toMap() {
    Map<String, dynamic> toMap = {
    'userId': emailController.text,
    "password": pwdController.text,
    "userName": nameController.text,
    "nickName": nickNameController.text,
    "carNo": carNumberController.text,
    "cardNum": cardNumberController1.text + cardNumberController2.text + cardNumberController3.text + cardNumberController4.text,
    "expirationYear": cardPeriodController.text.substring(3, 5),
    "expirationMonth": cardPeriodController.text.substring(0, 2),
    "cardCVC": cardCVVController.text,
    "cardPass": '00'

  };
    return toMap;
  }
  //
  // /// 개인정보 수정 toMap
  // Map<String, dynamic> toMapEditInfo() {
  //   Map<String, dynamic> toMap = {
  //     'userID'      : idController.text,
  //     'gender'      : gender,
  //     'dateOfBirth' : dateOfBirth,
  //     'jobName'     : jobName,
  //   };
  //   return toMap;
  // }
}



/// 비밀번호 변경 editingController class
class PasswordEdit {
  TextEditingController beforePassController = TextEditingController(); // 현재 비밀번호
  TextEditingController newPassController    = TextEditingController(); // 새 비밀번호
  TextEditingController newPass2Controller   = TextEditingController(); // 새 비밀번호 확인

  Map<String, dynamic> toMap(String userID) {
    Map<String, dynamic> toMap =
    {
      'userID'      : userID,
      'password'    : beforePassController.text,
      'npassword'   : newPassController.text,
    };

    return toMap;
  }
}