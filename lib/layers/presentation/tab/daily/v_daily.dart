
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/data/validate/auth_validation_mixin.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/vm_daily.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/point/w_point_box.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/w_wearable_charts.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_future_handler.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_view_padding.dart';
import 'package:provider/provider.dart';
import 'package:ghealth_app/common/common.dart';

import 'w_daily_header.dart';
import 'w_lifelog_body_analysis.dart';


class DailyViewTest extends StatefulWidget {
  const DailyViewTest({super.key});

  @override
  State<DailyViewTest> createState() => _DailyViewState();
}

class _DailyViewState extends State<DailyViewTest> with AuthValidationMixin{

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => DailyViewModelTest(),
      child: ViewPadding(
        child: Consumer<DailyViewModelTest>(
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
                    const Gap(AppDim.medium),

                    /// 일상 기록 헤더
                    const DailyHeader(),
                    const Gap(AppDim.medium),

                    /// 포인트 박스
                    PointBox(
                        totalPoint: provider.totalPoint,
                        isOnTap: true,
                    ),
                    const Gap(AppDim.medium),

                    /// 라이프로그 검사 결과 자세히 보기 (전신 그림)
                    LifeLogBodyAnalysis(
                      visitDateList: provider.visitDateList,
                      selectedDate: provider.selectedDate,
                      onChanged: provider.onChanged,
                    ),
                    const Gap(AppDim.small),

                    /// 웨어러블 데이터 차트(걸음수, 수면, 최근 심박동)
                    const WearableChats(),
                    const Gap(AppDim.medium),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
