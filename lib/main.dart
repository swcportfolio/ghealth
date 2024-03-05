// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/utils/nocheck_certificate_http.dart';
import 'package:ghealth_app/view/home/home_frame_view.dart';
import 'package:ghealth_app/widgets/girdview/gridview_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/models/attendance_data.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


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

  WidgetsFlutterBinding.ensureInitialized(); // 플랫폼 채널의 위젯 바인딩을 보장해야한다.
  HttpOverrides.global = NoCheckCertificateHttpOverrides(); // 생성된 HttpOverrides 객체 등록

  /// Hive local DB 초기화
  /// 경로 추가 이후: [flutter packages pub run build_runner build]
  await Hive.initFlutter();
  initHive();

  await Permission.activityRecognition.request(); // 신체활동 데이터 접근 퍼미션

  var pref = await SharedPreferences.getInstance();
  String? userID = pref.getString('userID') ?? '';
  String? userName = pref.getString('userName') ?? '';
  String? token = pref.getString('token') ?? '';
  String? gender = pref.getString('gneder') ?? '';
  String? targetSleep = pref.getString('targetSleep') ?? '0';
  String? targetStep = pref.getString('targetStep') ?? '0';
  bool? isToDayAttendance = pref.getBool('isToDayAttendance') ?? false;

  Authorization().setValues(
    newUserID: userID,
    newUserName: userName,
    newToken: token,
    newGender: gender,
  );

  Authorization().isToDayAttendance = isToDayAttendance;
  Authorization().targetSleep = targetSleep;
  Authorization().targetStep = targetStep;

  initializeDateFormatting().then((_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => ReservationTime()
          ),
        ],
        child: MyApp(),
      )
  ));
}


/// Hive를 데이터 저장을 위해 초기화합니다.
///
/// 이 메소드는 Hive를 설정하여 애플리케이션 문서 디렉터리로 초기화하고
/// [AttendanceData] 클래스에 대한 어댑터를 등록합니다.
Future<void> initHive() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(AttendanceDataAdapter());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeData = ThemeData();

  @override
  Widget build(BuildContext context) {
    /// 앱 화면 세로 위쪽 방향으로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'GHealth',
      debugShowCheckedModeBanner: false,
      theme:Theme.of(context).copyWith(
        colorScheme: themeData.colorScheme.copyWith(primary: mainColor),
      ),

      initialRoute:'home_frame_view',
      routes: {
        'home_frame_view': (context) => const HomeFrameView(),
      },
    );
  }
}

