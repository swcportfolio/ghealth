import 'dart:ui';

class PointHistory {
  late String title;
  late String date;
  late Color textColor; // 사용할지..는..
  late String pointValue; // +2000P, -2000P
  late String pointStatus;

  PointHistory(
      {required this.title,
      required this.date,
      required this.textColor,
      required this.pointValue,
      required this.pointStatus}); // 적립, 사용
}
