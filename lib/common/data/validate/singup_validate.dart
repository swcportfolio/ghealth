import 'package:flutter/material.dart';
import 'package:ghealth_app/common/dart/extension/snackbar_context_extension.dart';

/// 회원가입 유효성 확인 클래스
class SignValidate{

  /// 아이디(이메일) 체크
  static bool checkID(String value, BuildContext context){
    if(value.isEmpty) {
      context.showSnackbar('아이디를 입력해주세요.');
      return false;
    }
    else {
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);

      if(!regExp.hasMatch(value)) {
        context.showSnackbar('잘못된 이메일 형식입니다. 사용중인 이메일를 작성해주세요.');
        return false;
      }
      else {
        return true;
      }
    }
  }


  /// 비밀번호 체크
  static bool checkPassword(String value, BuildContext context){
    if(value.isEmpty){
      context.showSnackbar('비밀번호를 입력해주세요.');
      return false;
    }
    else {
      String pattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\\W).{7,15}";
      RegExp regExp = RegExp(pattern);

      if(!regExp.hasMatch(value)){
        context.showSnackbar('특수,대소문자,숫자 포함 7~15자로 입력해주세요.');
        return false;
      }
      else{
        return true;
      }
    }
  }


  /// 비밀번호2 체크
  static bool checkPassword2(String value, BuildContext context){
    if(value.isEmpty){
      context.showSnackbar('비밀번호를 재입력해주세요.');
      return false;
    }
    else {
      return true;
    }
  }


  /// 비밀번호 일치 체크
  static bool checkSamePassword(String value, String value2, BuildContext context){
    if(value != value2){
      context.showSnackbar('비밀번호가 일치하지 않습니다.');
      return false;
    }
    else {
      return true;
    }
  }


  /// 성별 체크
  static bool checkGender(String? value, BuildContext context){
    if(value == null){
      context.showSnackbar('성별을 선택해주세요.');
      return false;
    }
    else {
      return true;
    }
  }

  ///  닉네임 체크
  static bool checkNickName(String value, BuildContext context){
    if(value.isEmpty){
      context.showSnackbar('닉네임을 입력해주세요.');
      return false;
    }
    else if(value.length >=7){
      context.showSnackbar('닉네임 7자 이내로 작성해주세요.');
      return false;
    }
    else {
      return true;
    }
  }

  /// 생년월일 체크
  static bool checkDateOfBirth(String? value, BuildContext context){
    if(value == null){
      context.showSnackbar('생년월일을 입력해주세요.');
      return false;
    }
    else {
      return true;
    }
  }




  ///  이용약관 체크
  static bool checkTerms(bool value, BuildContext context){
    if(value){
      context.showSnackbar('이용약관 모두 동의해주세요.');
      return false;
    }
    else {
      return true;
    }
  }

}