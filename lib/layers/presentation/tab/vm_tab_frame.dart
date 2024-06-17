

import 'package:flutter/material.dart';

import '../../../widgets/dialog.dart';
import '../../model/authorization_test.dart';
import 'aihealth/v_ai_health.dart';
import 'checkup/v_checkup.dart';
import 'daily/v_daily.dart';
import 'home/v_home.dart';
import 'reservation/v_reservation.dart';

class TabFrameViewModelTest extends ChangeNotifier {
  /// BottomNavigationBar의 선택된 항목 인덱스
  int _selectedIndex = 0;

  /// AppBar 타이틀
  String _title = '홈으로';

  /// BottomNavigationBar 아이템 구성
  final List<Widget> widgetOptions = [
    const HomeViewTest(),
    const ReservationViewTest(),
    const AiHealthViewTest(),
    const CheckupViewTest(),
    const DailyViewTest(),
  ];

  final _titleList = ['홈으로', '예약', 'AI 건강예측', '나의 건강검진', '나의 일상기록'];

  int get selectedIndex => _selectedIndex;
  String get title => _title;

  /// Handles item selection in the bottom navigation bar.
  onItemTapped(int index, BuildContext context) {
    if(index > 0 && AuthorizationTest().token.isEmpty){
      CustomDialog.showLoginDialog(
          title: '로그인',
          content:'인증이 필요합니다.\n 로그인화면으로 이동합니다.',
          mainContext: context
      );
    } else {
      _selectedIndex = index;
      _title = _titleList[_selectedIndex];

      notifyListeners();
    }
  }
}