import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/auth/vm_login.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'common/data/preference/app_preferences.dart';
import 'common/data/preference/prefs.dart';
import 'common/di/di.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'layers/model/attendance_data.dart';
import 'layers/model/authorization_test.dart';
import 'my_app.dart';

var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        )
);


Future<void> main() async {
  // 플랫폼 채널의 위젯 바인딩을 보장해야한다.
  WidgetsFlutterBinding.ensureInitialized();

  // HttpOverrides 등록
  //HttpOverrides.global = NoCheckCertificateHttpOverrides();

  // SharedPreferences 초기화
  await AppPreferences.init();

  // Hive 초기화
  await initHive();

  // Locator 초기화
  initLocator();

  // 사용자 정보 초기화
  await initAuthorization();

  // 신체활동 데이터 접근 퍼미션 요청
  await Permission.activityRecognition.request();

  // 날짜 형식 초기화 후 runApp 실행
  initializeDateFormatting().then((_) => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginViewModelTest()),
        ],
        child: MyApp(),
      ),
  ));
}


/// Hive 데이터베이스 초기화
///
/// /// 경로 추가 이후: [flutter packages pub run build_runner build]
/// 이 메소드는 Hive를 설정하여 애플리케이션 문서 디렉터리로 초기화하고
/// [AttendanceData] 클래스에 대한 어댑터를 등록합니다.
Future<void> initHive() async {
  // Hive 초기화
  Hive.initFlutter();

  // 애플리케이션 문서 디렉터리 경로 가져오기
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // AttendanceData 클래스에 대한 어댑터 등록
  Hive.registerAdapter(AttendanceDataAdapter());
}


/// 사용자 정보 초기화 함수
Future<void> initAuthorization() async {
  // 사용자 정보 가져오기
  final userID = Prefs.userID.get();
  final userName = Prefs.userName.get();
  final token = Prefs.token.get();
  final gender = Prefs.gender.get();
  final userIDOfD = Prefs.userIDOfD.get();
  final userIDOfG = Prefs.userIDOfG.get();

  // 목표 및 설정 정보 가져오기
  final targetStep = Prefs.targetStep.get();
  final targetSleep = Prefs.targetSleep.get();
  final isToDayAttendance = Prefs.isToDayAttendance.get();
  final permissionDenied = Prefs.permissionDenied.get();
  final isCompletedPermission = Prefs.isCompletedPermission.get();

  // 사용자 정보 AuthorizationTest에 저장
  AuthorizationTest().userID = userID;
  AuthorizationTest().userName = userName;
  AuthorizationTest().token = token;
  AuthorizationTest().gender = gender;
  AuthorizationTest().userIDOfD = userIDOfD;
  AuthorizationTest().userIDOfG = userIDOfG;

  // 목표 및 설정 정보 AuthorizationTest에 저장
  AuthorizationTest().targetStep = targetStep;
  AuthorizationTest().targetSleep = targetSleep;
  AuthorizationTest().isToDayAttendance = isToDayAttendance;
  AuthorizationTest().permissionDenied = permissionDenied;
  AuthorizationTest().isCompletedPermission = isCompletedPermission;
}
