
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/view/home/home_view.dart';
import 'package:ghealth_app/widgets/dialog.dart';

import '../../main.dart';
import '../../services/health_service.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_appbar.dart';
import '../mydata/my_health_report_view.dart';
import '../report/my_health_record_view.dart';
import '../reservation/reservation_view.dart';
import '../wearable/health_view.dart';

class HomeFrameView extends StatefulWidget {
  const HomeFrameView({super.key});

  @override
  State<HomeFrameView> createState() => _HomeFramePageState();
}

class _HomeFramePageState extends State<HomeFrameView> {

  /// BottomNavigationBar selected location
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const ReservationView(),
    const MyHealthRecordView(),
    const MyHealthReportView(),
    const HealthView(),
  ];
  @override
  void initState() {
    super.initState();

    if(Authorization().token.isNotEmpty){
      HealthService().fetchPreviousDayData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'GHealth',
        isIconBtn: true
      ),

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
          type: BottomNavigationBarType.fixed, // 고정 크기 아이템 사용
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            _buildNavigationBarItem('images/navigation_4.png', '홈으로', 25, 25, 0),
            _buildNavigationBarItem('images/navigation_3.png', '예약', 25, 25, 1),
            _buildNavigationBarItem('images/navigation_2.png', '라이프로그', 25, 25, 2),
            _buildNavigationBarItem('images/my_data_icon.png', '나의 건강기록', 25, 25, 3),
            _buildNavigationBarItem('images/navigation_1.png', '웨어러블', 25, 25, 4),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: mainColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          unselectedItemColor: Colors.grey,

          onTap: _onItemTapped,
        )
      ),
    );
  }


  /// 사용자 정의된 BottomNavigationBarItem을 생성하는 함수.
  ///
  /// [imagePath]는 아이템의 이미지 경로입니다.
  /// [label]은 아이템의 라벨(텍스트)입니다.
  /// [iconWidth]와 [iconHeight]는 아이템 이미지의 가로 및 세로 크기입니다.
  /// [itemIndex]는 아이템의 인덱스로, 선택 여부에 따라 이미지 색상이 변경됩니다.
  ///
  /// 반환 값은 구성된 BottomNavigationBarItem입니다.
  BottomNavigationBarItem _buildNavigationBarItem(
      String imagePath,
      String label,
      double iconWidth,
      double iconHeight,
      int itemIndex,
      ) {
    return BottomNavigationBarItem(
      icon: ColorFiltered(
        colorFilter: _selectedIndex == itemIndex
            ? const ColorFilter.mode(mainColor, BlendMode.srcIn)
            : const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        child: Image.asset(imagePath, height: iconHeight, width: iconWidth),
      ),
      label: label,

    );
  }

  void _onItemTapped(int index) {
    if(index > 0 && Authorization().token.isEmpty){
      logger.i('=> 로그인이 필요합니다.');
      CustomDialog.showLoginDialog(
          title: '로그인',
          content:'인증이 필요합니다.\n 로그인화면으로 이동하시겠습니까?',
          mainContext: context
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}
