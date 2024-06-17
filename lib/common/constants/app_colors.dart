import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xff5c80fb);
  static Color secondColor = const Color(0xff496acc);

  static Color greenColor = const Color(0xff64d683);
  static Color greenDarkColor = const Color(0xff56b870);

  static Color whiteTextColor = const Color.fromARGB(255, 255, 255, 255);
  static Color greyTextColor = const Color.fromARGB(255, 139, 139, 139);
  static Color blackTextColor = const Color.fromARGB(255, 15, 15, 15);

  static Color signupTextFieldBg = const Color(0xffF2F2F2);
  static Color shadowColor = Colors.grey.withOpacity(0.4);
  static Color aiHealthBg = const Color(0xffADC2FF);

  static Color selectedCalenderColor = const Color(0xFF000000);
  static Color lightBackgroundColor = const Color(0xFFF1F0F5);
  static Color toDayCalenderColor = const Color.fromARGB(255, 139, 139, 139);

  static const Color transparent = Color(0x00FFFFFF);
  static const Color veryDarkGrey = Color.fromARGB(255, 25, 25, 25);
  static const Color darkGrey = Color.fromARGB(255, 45, 45, 45);
  static const Color heightGrey = Color.fromARGB(255, 80, 80, 80);
  static const Color grey = Color.fromARGB(255, 139, 139, 139);
  static const Color middleGrey = Color.fromARGB(255, 180, 180, 180);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color brightGrey = Color.fromARGB(255, 243, 243, 243);
  static const Color blueGreen = Color.fromARGB(255, 0, 185, 206);
  static const Color green = Color.fromARGB(255, 132, 206, 191);
  static const Color lightGreen = Color.fromARGB(255, 85, 200, 77);
  static const Color darkGreen = Color.fromARGB(255, 101, 160, 149);
  static const Color blue = Color.fromARGB(255, 0, 125, 203);
  static const Color brightBlue = Color(0xffe5ecff);
  static const Color lightBlue = Color.fromARGB(255, 245, 247, 255);
  static const Color darkBlue = Color.fromARGB(255, 0, 70, 111);
  static const Color mediumBlue = Color.fromARGB(255, 60, 140, 180);
  static const Color darkOrange = Color.fromARGB(255, 222, 112, 48);
  static Color lightOrange = Colors.orange.shade500;
  static const Color faleBlue = Color.fromARGB(255, 160, 206, 222);
  static const Color salmon = Color(0xffff6666);
  static const Color red = Color(0xffff0000);

  static const LinearGradient buttonGradient = LinearGradient(
      colors: [
        Color.fromRGBO(143, 148, 251, 1),
        Color.fromRGBO(143, 148, 251, .7),
      ]
  );
  // blood result box background color
  static const bloodResultBgColor = Color(0xFFfcedee);


  // health chart
  static const sleepChartColor = Color(0xFF9BA3EA);
  static const stepChartColor = Color(0xFFEFC568);

  // 인증번호 버튼
  static const sendTextColor = Color(0xff6387ff);
  static const sendBgColor = Color(0xffbecefd);

  // grey box colors
  static Color greyBoxBg = Colors.grey.shade100;
  static Color greyBoxBorder = Colors.grey.shade200;
  static Color greyDarkBoxBorder = const Color(0xffbdbdbd);

  // 소변 분석 단계별 컬러 값
  static const urineStageColor1 = Color(0xFF7FD697); // 안심
  static const urineStageColor2 = Color(0xFF5B85FF); // 관심
  static const urineStageColor3 = Color(0xFFFFD864); // 주의
  static const urineStageColor4 = Color(0xFF905BFF); // 위험
  static const urineStageColor5 = Color(0xFFFF5B65); // 심각
  static const urineExceptColor = Color(0xFFFF95A0); // 이외(PH, 비중, 비타민)

}
