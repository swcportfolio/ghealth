
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/data/validate/auth_validation_mixin.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/vm_reservation_history.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/w_reservation_card_item.dart';
import 'package:ghealth_app/layers/presentation/widgets/frame_scaffold.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_future_handler.dart';
import 'package:provider/provider.dart';

import '../../../../common/common.dart';
import '../../../model/authorization_test.dart';

/// 예약 내역 화면
class ReservationHistoryViewTest extends StatefulWidget {

  const ReservationHistoryViewTest({super.key});

  @override
  State<ReservationHistoryViewTest> createState() => _ReservationHistoryViewTestState();
}

class _ReservationHistoryViewTestState extends State<ReservationHistoryViewTest> with AuthValidationMixin{

  String get title => '예약 더보기';

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,
      body: ChangeNotifierProvider(
        create: (context) => ReservationHistoryViewModelTest(context),
        child: Consumer<ReservationHistoryViewModelTest>(
          builder: (context, provider, child) {
            return FutureHandler(
              isLoading: provider.isLoading,
              isError: provider.isError,
              errorMessage: provider.errorMessage,
              onRetry: () {  },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDim.medium,
                    vertical: AppDim.small,
                ),
                child: provider.historyList.isEmpty
                    ? buildEmptyReservation()
                    :
                ListView.builder(
                  controller: provider.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.historyList.length,
                  itemBuilder: (BuildContext context, int index)
                  {
                    return ReservationCardItem(
                      reservationData: provider.historyList[index],
                      provider: provider,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 예약 내역이 없을 시 보여주는 화면
  Widget buildEmptyReservation() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Image.asset(
              '${AppStrings.imagePath}/tab/daily/empty_search_image.png',
              height: 60,
              width: 60,
          ),
          const Gap(AppDim.small),

          const StyleText(
            text: '현재 예약하신 내역이 없습니다.',
          ),
          const Gap(AppDim.medium),
        ],
      ),
    );
}



