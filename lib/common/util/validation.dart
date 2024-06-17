import 'package:flutter/material.dart';
import '../../layers/presentation/widgets/w_custom_dialog.dart';

class Validation {
  /// 휴대폰 번호 유효성 체크
  static bool isValidTelNumber(TextEditingController controller, BuildContext context) {
    // 한국 휴대폰 번호 정규식 패턴
    final regExp = RegExp(r'^01[0-9]-?\d{3,4}-?\d{4}$');

    if (controller.text.isEmpty) {
      _showTelNumberErrorDialog(context, '휴대폰 번호를 입력해주세요.');
      return false;
    } else if (controller.text.length < 10) {
      _showTelNumberErrorDialog(context, '휴대폰 번호 10~11자리 입력해주세요.');
      return false;
    } else if (!regExp.hasMatch(controller.text)) {
      _showTelNumberErrorDialog(context, '유효하지 않는 휴대폰 번호입니다.');
      return false;
    }

    return true;
  }


  /// 인증코드 유효성 체크
  static bool isValidCertificationCode(TextEditingController controller, BuildContext context) {
    if (controller.text.isEmpty) {
      _showCertificationCodeErrorDialog(context, '인증코드를 입력해주세요.');
      return false;
    } else if (controller.text.length < 5) {
      _showCertificationCodeErrorDialog(context, '인증코드 5자리 입력해주세요.');
      return false;
    }

    return true;
  }


  /// 휴대폰 번호 오류 메시지 표시
  static void _showTelNumberErrorDialog(BuildContext context, String message) {
    CustomDialog.showMyDialog(
      title: '휴대폰 번호',
      content: message,
      mainContext: context,
    );
  }


  /// 인증코드 오류 메시지 표시
  static void _showCertificationCodeErrorDialog(BuildContext context, String message) {
    CustomDialog.showMyDialog(
      title: '인증 코드',
      content: message,
      mainContext: context,
    );
  }
}
