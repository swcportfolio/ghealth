import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/common/data/validate/auth_validation_mixin.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/point/vm_my_health_point.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/point/w_point_history_box.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/point/w_shop_banner.dart';
import 'package:provider/provider.dart';

import '../../../../model/authorization_test.dart';
import '../../../widgets/frame_scaffold.dart';
import '../../../widgets/w_future_handler.dart';
import 'w_point_accumulate.dart';
import 'w_point_box.dart';
import 'w_point_description.dart';



/// 나의 건강 포인트 화면
class MyHealthPointViewTest extends StatefulWidget {
  const MyHealthPointViewTest({
    super.key,
    required this.totalPoint
  });
  final String totalPoint;

  @override
  State<MyHealthPointViewTest> createState() => _MyHealthPointViewTestState();
}

class _MyHealthPointViewTestState extends State<MyHealthPointViewTest>
    with TickerProviderStateMixin, AuthValidationMixin{

  String get title => '나의 건강 포인트';

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return FrameScaffold(
      appBarTitle: title,
      body: ChangeNotifierProvider(
        create: (BuildContext context) => MyHealthPointViewModelTest(),
        child: Consumer<MyHealthPointViewModelTest>(
          builder: (context, provider, child) {
            return FutureHandler(
              isLoading: provider.isLoading,
              isError: provider.isError,
              errorMessage: provider.errorMessage,
              onRetry: () {  },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children:
                  [
                    /// 포인트 설명
                    const PointDescription(),

                    /// 건강 포인트 위젯
                    PointBox(
                        totalPoint: widget.totalPoint,
                        isOnTap: false,
                    ),
                    const Gap(AppDim.large),

                    /// 포인트 적립 / 차감 내역
                    PointHistoryBox(pointHistoryList: provider.pointHistoryList),
                    const Gap(AppDim.large),

                    /// 포인트 Q&A
                    const PointAccumulate(),

                    /// GHealth 쇼핑몰 광고 및 웹 링크 전환
                    ShopBanner(productList: provider.productList),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

