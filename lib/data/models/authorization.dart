
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/reservation_default_response.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../services/attendance_checker.dart';
import '../../services/health_service.dart';
import '../../widgets/dialog.dart';

/// Attributes to store user authorization information
class Authorization{
  late String userID; //ex)U00000
  late String userName; //ex)강**
  late String token; //ex)eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJV
  late String gender; //ex)(M:남자,F:여자)

  late String targetSleep;
  late String targetStep;
  late bool isToDayAttendance;// 당일 출석 여부


  @override
  String toString() {
    return 'Authorization{userID: $userID, userName: $userName, token: $token, gender: $gender, targetSleep: $targetSleep, targetStep: $targetStep}';
  }

  // Authorization 클래스의 싱글톤 인스턴스
  static final Authorization _authInstance = Authorization.internal();

  // 싱글톤 패턴을 위한 비공개 생성자
  factory Authorization(){
    return _authInstance;
  }

  // 사용자 권한 값을 설정하는 메서드
  void setValues({
    required String newUserID,
    required String newUserName,
    required String newToken,
    required String newGender,
  }) {
    userID = newUserID;
    userName = newUserName;
    token = newToken;
    gender = newGender;
  }

  /// Authorization의 단일 인스턴스를 제공하기 위한 팩토리 메서드
  Authorization.internal() {
    init();
  }

  /// 권한 값을 초기화하는 메서드
  clean() => init();

  /// 권한 값을 초기화하는 메서드
  init() {
    userID = '';
    userName = '';
    token = '';
    gender = '';
    targetSleep = '0';
    targetStep = '0';
    //isToDayAttendance = false;
  }


  /// 로컬 데이터 저장
  void setStringData() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('userID',userID);
    pref.setString('userName',userName);
    pref.setString('token',token);
    pref.setString('gender',gender);
    pref.setString('targetSleep',targetSleep);
    pref.setString('targetStep',targetStep);
  }

  /// SharedPreferences clear
  void clearSetStringData() async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
  }


  /// Authorization 토큰 유효성 체크
  /// 서버에서 발급된 토큰은 30일간 유효하다.
  Future<bool> checkAuthToken() async {
   try{
     DefaultResponse response = await PostRepository().checkAuthDio();
     if(response.status.code == '200'){
       logger.i('=> 현재 유효한 Authorization Token 입니다');
       return true;
     } else {
       logger.e('=> 토큰 유효성 체크 response.status.code not 200');
       return false;
     }
   } on DioException catch (dioError){
     logger.e('=> CheckAuthorizationToken: $dioError');
     return false;
   }
  }


  /// 로그인 상태일때, HealthService 퍼미션 수락시
  /// 로컬에 저장된 출석데이터를 이용하여 수집된 건강데이터를 전송한다.
  Future<void> fetchDataIfLoggedIn(BuildContext context) async {
    if (Authorization().token.isNotEmpty) {
      bool permissionRequired = await HealthService().requestPermission();

      if (permissionRequired) {
        AttendanceChecker().checkAttendance(); // 출석 기능
      } else {
        CustomDialog.showMyDialog(
          title: '헬스데이터',
          content: '권한및 데이터 접근 퍼미션이\n 미 허용되었습니다.',
          mainContext: context,
        );
      }
    }
  }
}