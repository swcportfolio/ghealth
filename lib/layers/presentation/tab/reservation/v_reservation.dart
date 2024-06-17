



import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/data/validate/auth_validation_mixin.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/vm_reservation.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/w_current_reservation.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/w_region_choice.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/w_reservation_button.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/w_reservation_calendar.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/w_reservation_header.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_future_handler.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_view_padding.dart';
import 'package:provider/provider.dart';

import '../../../../common/common.dart';
import '../../../model/authorization_test.dart';
import 'w_select_time.dart';


/// 예약 화면
class ReservationViewTest extends StatefulWidget {
  const ReservationViewTest({super.key});

  @override
  State<ReservationViewTest> createState() => _ReservationViewTestState();
}

class _ReservationViewTestState extends State<ReservationViewTest> with AuthValidationMixin{
  String get title => '예약하기';

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ViewPadding(
      child: ChangeNotifierProvider(
        create: (context) => ReservationViewModelTest(context),
        child: Consumer<ReservationViewModelTest>(
          builder: (context, provider, child) {
            return FutureHandler(
              isLoading: provider.isLoading,
              isError: provider.isError,
              errorMessage: provider.errorMessage,
              onRetry: () { },
              child: SingleChildScrollView(
                controller: provider.controller,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    const Gap(AppDim.medium),

                    /// 예약 헤더
                    const ReservationHeader(),

                    /// 현재 예약 정보
                    CurrentReservation(
                      reservationRecent: provider.reservationRecent,
                      cancelFunction: () {
                        provider.handleCancelReservation(
                            int.parse(provider.reservationRecent!
                                .reservationIdx
                                .toString()),
                            provider.reservationRecent!.orgType!
                        );
                      },
                      screenInitCallBack: () => provider.initScreen(),
                    ),
                    const Gap(AppDim.small),

                    /// 건강관리소 지역(동구, 광산구) 선택
                    const RegionChoice(),
                    const Gap(AppDim.large),


                    /// 방문예약 달력 선택
                    const ReservationCalendar(),
                    const Gap(AppDim.large),


                    /// 방문예약 시간 선택
                    const SelectTime(),
                    const Gap(AppDim.large),


                    /// 방문예약 버튼
                    const ReservationButton(),
                    const Gap(AppDim.large),

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


