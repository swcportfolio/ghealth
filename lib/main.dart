import 'package:flutter/material.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/view/home/home_frame_view.dart';
import 'package:ghealth_app/view/join/login_view.dart';
import 'package:ghealth_app/view/join/login_viewmodel.dart';
import 'package:ghealth_app/view/results/my_result_report_viewmodel.dart';
import 'package:ghealth_app/widgets/girdview/gridview_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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

  await Permission.activityRecognition.request(); // 수면시간, 걷음 수 데이터 접근 퍼미션
  await Permission.location.request();

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
              create: (BuildContext context) => MyHealthReportViewModel()
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
        //primaryTextTheme: themeData.textTheme.apply(fontFamily: 'nanum_square')
      ),
      // localizationsDelegates:
      // const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],

      // supportedLocales:
      // const [
      //   Locale('ko', ''),
      //   Locale('en', ''),
      // ],

      initialRoute:'login_view',
      routes:
      {
        'login_view': (context) => const LoginView(),
        'home_frame_view': (context) => const HomeFrameView(),
      },
    );
  }
}

