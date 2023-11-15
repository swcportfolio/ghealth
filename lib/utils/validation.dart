
import 'package:flutter/material.dart';

import '../widgets/dialog.dart';
import 'etc.dart';

class Validation {

  /// 휴대폰 번호 유효성 체크
  static bool isValidTelNumber(TextEditingController controller, BuildContext context) {
    // 한국 휴대폰 번호 정규식 패턴
    RegExp regExp = RegExp(r'^01[0-9]-?\d{3,4}-?\d{4}$');
    if(controller.text.isEmpty){
      CustomDialog.showMyDialog(
        title: '휴대폰 번호',
        content: "휴대폰 번호를 입력해주세요.",
        mainContext: context,
      );
      return false;
    }
    else if(controller.text.length <10){
      CustomDialog.showMyDialog(
          title: '휴대폰 번호',
          mainContext: context,
          content: '휴대폰 번호 10~11자리 입력해주세요.'
      );
      return false;
    }
    else if(!regExp.hasMatch(controller.text)){
      CustomDialog.showMyDialog(
          title: '휴대폰 번호',
          mainContext: context,
          content: '유효하지 않는 휴대폰 번호 입니다.'
      );
      return false;
    }
    return true;
  }


  /// 인증코드 유효성 체크
  static bool isValidCertificationCode(TextEditingController controller, BuildContext context){

    if(controller.text.isEmpty){
      CustomDialog.showMyDialog(
          title: '인증 코드',
          mainContext: context,
          content: '인증코드를 입력해주세요.'
      );
      return false;
    }
    else if(controller.text.length < 5){
      CustomDialog.showMyDialog(
          title: '인증 코드',
          mainContext: context,
          content: '인증코드 5자리 입력해주세요.'
      );
      return false;
    } else {
      return true;
    }
  }
}