

import 'package:flutter/material.dart';
import 'package:ghealth_app/common/data/validate/auth_validation_mixin.dart';
import 'package:ghealth_app/layers/presentation/widgets/frame_scaffold.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../../../main.dart';
import '../../model/authorization_test.dart';
import '../../model/enum/tab_item_type.dart';
import 'vm_tab_frame.dart';
import 'w_navigation_bar_item.dart';


/// 앱 실행 후 첫 화면 Frame
class TabFrameViewTest extends StatefulWidget {
  const TabFrameViewTest({super.key});

  @override
  State<TabFrameViewTest> createState() => _TabFrameViewTestState();
}

class _TabFrameViewTestState extends State<TabFrameViewTest> with WidgetsBindingObserver, AuthValidationMixin {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    AuthorizationTest().fetchDataIfLoggedIn(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TabFrameViewModelTest(),
      child: Consumer<TabFrameViewModelTest>(
        builder: (context, provider, child) {
          return FrameScaffold(
            appBarTitle: provider.title,
            isActions: true,
            body: provider.widgetOptions.elementAt(provider.selectedIndex),

            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.brightGrey,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: AppColors.white,
                  showUnselectedLabels: true,
                  items: <BottomNavigationBarItem>
                  [
                    _barItem(TabItemType.home),
                    _barItem(TabItemType.checkup),
                    _barItem(TabItemType.daily),
                    _barItem(TabItemType.aihealth),
                    _barItem(TabItemType.urine),
                  ],
                  currentIndex: provider.selectedIndex,
                  selectedItemColor: AppColors.primaryColor,
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  unselectedItemColor: AppColors.grey,
                  onTap: (index) => provider.onItemTapped(index, context),
                )
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _barItem(TabItemType type) {
    return BottomNavigationBarItem(
        icon: NavigationBarItemIcon(type: type),
        label: ''
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    /// 앱이 백그라운드에 있다가 다시 재개되었을때(하루, 이틀)
    /// 이상 기간이 지나고 앱을 실행했을때 출석기능을 활성화하기위한 로직
    /// TODO: 이슈: 퍼미션 거절되었을때 라이프사이클 때문에 resumed 로직이 수행되어 무한으로 [fetchDataIfLoggedIn]가 실행된다.
    ///
    /// AccessToken 유효기간 체크
    if(state == AppLifecycleState.resumed) {
      // 로그인 상태일경우에만 Health 데이터를 가져온다.
      if(mounted){
        AuthorizationTest().fetchDataIfLoggedIn(context);
      }

      // AccessToken 확인
      if(AuthorizationTest().token.isNotEmpty && mounted){
        checkAuthToken(context);
      }
    }
  }
}
