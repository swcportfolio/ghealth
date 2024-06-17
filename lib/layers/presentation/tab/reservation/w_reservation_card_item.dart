import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/vm_reservation_history.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_line.dart';

import '../../../../common/common.dart';
import '../../../entity/reservation_dto.dart';
import '../../widgets/style_text.dart';
import 'd_reservation.dart';

/// 예약내역 리스트 아이템
class ReservationCardItem extends StatelessWidget {
  final ReservationDataDTO reservationData;
  final ReservationHistoryViewModelTest provider;

  const ReservationCardItem({
    super.key,
    required this.reservationData,
    required this.provider,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDim.mediumLarge),
      margin: const EdgeInsets.symmetric(vertical: AppDim.small),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('${AppStrings.imagePath}/tab/daily/reservation_background_image.png'),
            fit: BoxFit.fill
        ),
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.start,
        children: [
          /// 타이틀, 예약 취소 버튼
          const Row(
            children: [
              Gap(5),

              StyleText(
                text: '나의 예약 현황',
                size: AppDim.fontSizeLarge,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Gap(AppDim.medium),
          const Line(),
          const Gap(AppDim.medium),

          /// 예약 날짜, 시간
          /// 예약장소
          Padding(
            padding: const EdgeInsets.only(left:AppDim.small),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const StyleText(
                  text: '방문 장소',
                ),
                const Gap(AppDim.small),

                StyleText(
                  text: '${reservationData.orgType?.name} 건강관리소',
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          const Gap(AppDim.small),


          /// 예약 날짜, 시간
          Padding(
            padding: const EdgeInsets.only(left: AppDim.small),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
                const StyleText(
                  text: '예약 일시',
                ),
                const Gap(AppDim.small),

                StyleText(
                  text: '${reservationData.reservationDate} / '
                      '${reservationData.reservationTime}',
                  fontWeight: FontWeight.w500,

                ),
              ],
            ),
          ),
          const Gap(AppDim.small),


          /// 예약 상태
          Padding(
            padding: const EdgeInsets.only(left:AppDim.small),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const StyleText(
                  text: '예약 상태',),
                const Gap(AppDim.small),

                StyleText(
                  text: '${reservationData.reservationStatus}',
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          const Gap(AppDim.medium),
          const Line(),

          Visibility(
            visible: Branch.possibleToCancel(reservationData.reservationStatus!),
            child: InkWell(
              onTap: () => {
                ReservationDialogTest.showCancelReservationDialog(
                  mainContext: context,
                  reservationDate: reservationData.reservationDate!,
                  reservationTime: reservationData.reservationTime!,
                  type: reservationData.orgType!,
                  cancelReservationFunction: () =>
                      provider.handleCancelReservation(
                        int.parse(reservationData.reservationIdx!),
                        reservationData.orgType!,
                      ),
                )
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppDim.small),
                    child: StyleText(
                      text: '예약 취소',
                      size: AppDim.fontSizeSmall,
                      fontWeight: AppDim.weightBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}