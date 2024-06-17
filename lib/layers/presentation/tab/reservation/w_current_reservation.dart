import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/v_reservation_history.dart';


import '../../../../common/common.dart';
import '../../../entity/reservation_dto.dart';
import '../../widgets/style_text.dart';
import '../../widgets/w_line.dart';
import 'd_reservation.dart';

class CurrentReservation extends StatelessWidget {
  final ReservationDataDTO? reservationRecent;
  final Function cancelFunction;
  final VoidCallback screenInitCallBack;

  const CurrentReservation({
    super.key,
    this.reservationRecent,
    required this.cancelFunction,
    required this.screenInitCallBack,
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               const Row(
                children: [
                  Gap(AppDim.xSmall),

                  StyleText(
                    text: '나의 예약 현황',
                    size: AppDim.fontSizeLarge,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),

              InkWell(
                onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)
                => const ReservationHistoryViewTest())).then((_){
                  screenInitCallBack();
                }),//Nav.doPush(context, const ReservationHistoryView()),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyleText(
                        text: '예약 내역 조회',
                        color: AppColors.grey,
                        size: AppDim.fontSizeSmall,
                    ),
                    Gap(AppDim.xSmall),

                    Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.grey,
                        size: AppDim.iconXSmall,
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(15),
          const Line(),

          SizedBox(
              width: double.infinity,
              child: reservationRecent!.reservationIdx == ''
                  ? Center(
                  child: Container(
                      height: 45,
                      margin: const EdgeInsets.symmetric(vertical: AppDim.small),
                      child: const Center(
                          child: StyleText(
                            text: '방문예약 내역이 없습니다.',
                            size: AppDim.fontSizeSmall,
                          ))))
                  : Container(
                height: 150,
                margin: const EdgeInsets.only(bottom: AppDim.medium),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Gap(AppDim.medium),

                    /// 예약장소
                    Padding(
                      padding: const EdgeInsets.only(left: AppDim.small),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:
                        [
                          const StyleText(
                            text: '방문 장소',
                          ),
                          const Gap(AppDim.small),

                          StyleText(
                            text: '${reservationRecent?.orgType?.name ?? '동구'} 건강관리소',
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
                            text: '${reservationRecent?.reservationDate ?? '-'} / '
                                '${reservationRecent?.reservationTime ?? '-'}',
                            fontWeight: AppDim.weight500,
                          ),
                        ],
                      ),
                    ),
                    const Gap(AppDim.small),

                    /// 예약 상태
                    Padding(
                      padding: const EdgeInsets.only(left: AppDim.small),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const StyleText(
                            text: '예약 상태',
                          ),
                          const Gap(AppDim.small),

                          StyleText(
                            text: reservationRecent?.reservationStatus ?? '-',
                            fontWeight: AppDim.weightBold,
                          ),
                        ],
                      ),
                    ),
                    const Gap(AppDim.medium),

                    const Line(),
                    const Gap(AppDim.small),

                    Visibility(
                      visible: Branch.possibleToCancel(reservationRecent?.reservationStatus ?? '요청'),
                      child: InkWell(
                        onTap: () =>
                        {
                          ReservationDialogTest.showCancelReservationDialog(
                              mainContext: context,
                              reservationDate: reservationRecent!.reservationDate!,
                              reservationTime: reservationRecent!.reservationTime!,
                              type: reservationRecent!.orgType!,
                              cancelReservationFunction: () => cancelFunction()
                          )
                        },
                        child: const StyleText(
                          text: '예약 취소',
                          size: AppDim.fontSizeSmall,
                          fontWeight: AppDim.weightBold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
