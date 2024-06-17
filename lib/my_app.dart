import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/common.dart';

import 'layers/presentation/tab/v_tab_frame.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeData = ThemeData();

  @override
  Widget build(BuildContext context) {
    // 앱 화면 세로 위쪽 방향으로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'GHealth',
      debugShowCheckedModeBanner: false,
      theme:Theme.of(context).copyWith(
        colorScheme: themeData.colorScheme.copyWith(primary: AppColors.primaryColor),
      ),
      initialRoute:'tab_frame_view_test',
      routes: {
        'tab_frame_view_test': (context) => const TabFrameViewTest(),
      },
    );
  }
}