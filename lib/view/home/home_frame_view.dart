
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/view/aihealth/aihealth_main_view.dart';
import 'package:ghealth_app/view/home/home_view.dart';
import 'package:ghealth_app/widgets/dialog.dart';

import '../../data/enum/snackbar_status_type.dart';
import '../../main.dart';
import '../../services/connectivity_observer.dart';
import '../../utils/colors.dart';
import '../../utils/etc.dart';
import '../../utils/network_connectivity_observer.dart';
import '../../utils/snackbar_utils.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/frame.dart';
import '../login/login_view.dart';
import '../mydata/mydata_main_view.dart';
import '../myrecords/myrecord_main_view.dart';
import '../reservation/reservation_main_view.dart';

/// 홈 프레임 화면
/// AppBar, Bottom Navigation, 출석 확인 으로 구성되어 있다.
class HomeFrameView extends StatefulWidget {
  const HomeFrameView({super.key});

  @override
  State<HomeFrameView> createState() => _HomeFramePageState();
}

class _HomeFramePageState extends State<HomeFrameView> with WidgetsBindingObserver {
  //final _connectivity = NetworkConnectivityObserver();

  /// BottomNavigationBar의 선택된 항목 인덱스
  int _selectedIndex = 0;

  /// BottomNavigationBar 아이템 구성
  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const ReservationMainView(),
    const AiHealthMainView(),
    const MyDataMainView(),
    const MyRecordMainView(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Authorization().fetchDataIfLoggedIn(context); // 출석 체크

    // 네트워크 연결 상태 observe 등록
    // _connectivity.observe().listen((status) {
    //   logger.i('네트워크 상태: $status');
    //   if(status == NetWorkStatus.unavailable){
    //     SnackBarUtils.showStatusSnackBar(message: '네트워크 연결상태를 확인해주세요.', context: context, statusType: SnackBarStatusType.success);
    //   }
    // });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    /// 앱이 백그라운드에 있다가 다시 재개되었을때(하루, 이틀)
    /// 이상 기간이 지나고 앱을 실행했을때 출석기능을 활성화하기위한 로직
    // TODO: 이슈: 퍼미션 거절되었을때 라이프사이클 때문에 resumed 로직이 수행되어 무한으로 [fetchDataIfLoggedIn]가 실행된다.
    ///
    ///
    /// AccessToken 유효기간 체크
    if(state == AppLifecycleState.resumed) {
      /// 로그인 상태일경우에만 Health 데이터를 가져온다.
      Authorization().fetchDataIfLoggedIn(context);

      /// AccessToken 확인
      if(Authorization().token.isNotEmpty){
        Authorization().checkAuthToken().then((result) {
          if(!result){
            SnackBarUtils.showBGWhiteSnackBar(
                '권한 만료, 재 로그인 필요합니다.', context);
            Frame.doPagePush(context, const LoginView());
          }
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'GHealth', isIconBtn: true),

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
            _buildNavigationBarItem('images/navigation_4.png', '홈으로\n', 25, 25, 0),
            _buildNavigationBarItem('images/navigation_3.png', '예약\n', 25, 25, 1),
            _buildNavigationBarItem('images/navigation_2.png', 'AI\n 건강예측', 25, 25, 2),
            _buildNavigationBarItem('images/my_data_icon.png', '나의\n건강검진', 25, 25, 3),
            _buildNavigationBarItem('images/navigation_1.png', '나의\n일상기록', 25, 25, 4),
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
      icon: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ColorFiltered(
            colorFilter: _selectedIndex == itemIndex
                ? const ColorFilter.mode(mainColor, BlendMode.srcIn)
                : const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            child: Image.asset(imagePath, height: iconHeight, width: iconWidth),
          ),
          Frame.myText(
            text: label,
            align: TextAlign.center,
            color: _selectedIndex == itemIndex ? mainColor: Colors.grey,
            fontSize: 0.8,
            maxLinesCount: 2
          )
        ],
      ),
      label: '',

    );
  }

  /// Handles item selection in the bottom navigation bar.
  /// 홈화면을 제외한 나머지 기능들은 로그인이 필요하므로 token empty
  /// check를 한다.
  void _onItemTapped(int index) {
    if(index > 0 && Authorization().token.isEmpty){
      logger.i('=> 로그인이 필요합니다.');
      CustomDialog.showLoginDialog(
          title: '로그인',
          content:'인증이 필요합니다.\n 로그인화면으로 이동합니다.',
          mainContext: context
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}
