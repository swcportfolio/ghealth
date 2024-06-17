
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/data/preference/prefs.dart';
import '../../common/service/health_service.dart';
import '../../services/attendance_checker.dart';
import '../../widgets/dialog.dart';

/// Attributes to store user authorization information
class AuthorizationTest{
  late String userID; // ex)U00000
  late String userName; // ex)강**
  late String token; // ex)eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJV
  late String gender; // ex)(M:남자,F:여자)
  late String userIDOfD; // 동구 아이디
  late String userIDOfG; // 광산구 아이디
  late String targetSleep; // 목표 수면
  late String targetStep; // 목표 걸음수
  late bool isToDayAttendance;// 당일 출석 여부
  late bool permissionDenied;   // 퍼미션 거부 이력, 재요청을 위한 flag
  late bool isCompletedPermission; // 최초 퍼미션 허용 되었는지?

  @override
  String toString() {
    return 'AuthorizationTest{userID: $userID, userName: $userName, token: $token, gender: $gender, userIDOfD: $userIDOfD, userIDOfG: $userIDOfG, targetSleep: $targetSleep, targetStep: $targetStep, isToDayAttendance: $isToDayAttendance, permissionDenied: $permissionDenied, isCompletedPermission: $isCompletedPermission}';
  }





  // Authorization 클래스의 싱글톤 인스턴스
  static final AuthorizationTest _authInstance = AuthorizationTest.internal();

  // 싱글톤 패턴을 위한 비공개 생성자
  factory AuthorizationTest(){
    return _authInstance;
  }

  /// Authorization의 단일 인스턴스를 제공하기 위한 팩토리 메서드
  AuthorizationTest.internal() {
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


  /// 사용자 정보 저장
  saveOfLocalPerf() {
    Prefs.userID.set(userID);
    Prefs.userName.set(userName);
    Prefs.token.set(token);
    Prefs.gender.set(gender);
    Prefs.userIDOfD.set(userIDOfD);
    Prefs.userIDOfG.set(userIDOfG);
  }

  /// SharedPreferences clear
  clearSetStringData() async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
  }


  /// Authorization 토큰 유효성 체크
  /// 서버에서 발급된 토큰은 30일간 유효하다.
  // Future<void> checkAuthToken(BuildContext context) async {
  //   try{
  //     final response = await CheckTokenUseCase().execute();
  //     if(response?.status.code == '200'){
  //       logger.i('=> 현재 유효한 Authorization Token 입니다');
  //     }
  //     else {
  //       logger.e('=> 토큰 유효성 체크 response.status.code not 200');
  //
  //       SnackBarUtils.showBGWhiteSnackBar('권한 만료, 재 로그인 필요합니다.', context);
  //       Nav.doAndRemoveUntil(context, const LoginViewTest());
  //     }
  //   } on DioException catch (dioError){
  //     logger.e('=> CheckAuthorizationToken: $dioError');
  //
  //     if(dioError.message.toString().contains('500')){
  //       SnackBarUtils.showBGWhiteSnackBar('권한 만료, 재 로그인 필요합니다.', context);
  //       Nav.doAndRemoveUntil(context, const LoginViewTest());
  //     }
  //   }
  // }


  /// 로그인 상태일때, HealthService 퍼미션 수락시
  /// 로컬에 저장된 출석데이터를 이용하여 수집된 건강데이터를 전송한다.
  Future<void> fetchDataIfLoggedIn(BuildContext context) async {

    if (AuthorizationTest().token.isNotEmpty && !AuthorizationTest().permissionDenied) {
      bool permissionRequired = await HealthService().requestPermission();

      if (permissionRequired) {
        AttendanceChecker().checkAttendance(); // 출석 기능
      } else {
        CustomDialog.showMyDialog(
          title: '헬스데이터',
          content: '권한및 데이터 접근 퍼미션이\n 미 허용되었습니다.',
          mainContext: context,
        );

        AuthorizationTest().permissionDenied = true;
        Prefs.permissionDenied.set(true); // 미허용 이력 저장
      }
    }
  }
}