import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/utils/nocheck_certificate_http.dart';
import 'package:ghealth_app/view/home/home_frame_view.dart';
import 'package:ghealth_app/view/join/login_view.dart';
import 'package:ghealth_app/view/join/login_viewmodel.dart';
import 'package:ghealth_app/view/report/report_bottom_sheet_viewmodel.dart';
import 'package:ghealth_app/widgets/girdview/gridview_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
    ));

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized(); // 플랫폼 채널의 위젯 바인딩을 보장해야한다.
  HttpOverrides.global = NoCheckCertificateHttpOverrides(); // 생성된 HttpOverrides 객체 등록

  await Permission.activityRecognition.request(); // 수면시간, 걷음 수 데이터 접근 퍼미션
  //await Permission.location.request();

  var pref = await SharedPreferences.getInstance();
  String? userID = pref.getString('userID') ?? '';
  String? userName = pref.getString('userName') ?? '';
  String? token = pref.getString('token') ?? '';
  String? gender = pref.getString('gneder') ?? '';
  String? targetSleep = pref.getString('targetSleep') ?? '0';
  String? targetStep = pref.getString('targetStep') ?? '0';

  Authorization().setValues(
    newUserID: userID,
    newUserName: userName,
    newToken: token,
    newGender: gender,
  );

  Authorization().targetSleep = targetSleep;
  Authorization().targetStep = targetStep;

  initializeDateFormatting().then((_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => LoginViewModel()
          ),
          ChangeNotifierProvider(
              create: (BuildContext context) => ReservationTime()
          ),

          ChangeNotifierProvider(
              create: (BuildContext context) => ReportBottomSheetViewModel()
          ),
        ],
        child: MyApp(),
      )
  ));
}

class MyApp extends StatelessWidget {
  final themeData = ThemeData();
  MyApp({super.key});
  // /// 앱 화면 세로 위쪽 방향으로 고정
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GHealth',
      debugShowCheckedModeBanner: false,
      theme:Theme.of(context).copyWith(
        colorScheme: themeData.colorScheme.copyWith(primary: mainColor),
      ),

      initialRoute:'home_frame_view',
      routes:
      {
        'login_view': (context) => const LoginView(),
        'home_frame_view': (context) => const HomeFrameView(),
      },
    );
  }
}

