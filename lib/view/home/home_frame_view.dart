
import 'package:flutter/material.dart';
import 'package:ghealth_app/view/home/home_view.dart';

import '../../utlis/colors.dart';
import '../../widgets/custom_appbar.dart';
import '../health/health_view.dart';
import '../reservation/reservation_history_view.dart';
import '../reservation/reservation_view.dart';
import '../result/myinfo_result_sheet_view.dart';

class HomeFrameView extends StatefulWidget {
  const HomeFrameView({super.key});

  @override
  State<HomeFrameView> createState() => _HomeFramePageState();
}

class _HomeFramePageState extends State<HomeFrameView> {

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const ReservationHistoryView(),
    const MyInfoResultSheetView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'GHealth'),

      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[ // 그림자효과
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          showUnselectedLabels: true, // 선택되지 않은 항목 라벨 항상 표시
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '홈으로',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: '예약',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_information_outlined),
              label: '내건강 보고서',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: mainColor,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
