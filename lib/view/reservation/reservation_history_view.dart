import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/reservation/reservation_history_viewmodel.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:provider/provider.dart';

import '../../data/models/reservation_data.dart';
import '../../widgets/dialog.dart';


/// 예약 내역 화면
class ReservationHistoryView extends StatefulWidget {
  const ReservationHistoryView({super.key});

  @override
  State<ReservationHistoryView> createState() => _ReservationHistoryViewState();
}

class _ReservationHistoryViewState extends State<ReservationHistoryView> {
  late ReservationHistoryViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ReservationHistoryViewModel(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: '예약내역 조회', isIconBtn: false),

      body: ChangeNotifierProvider<ReservationHistoryViewModel>(
        create: (BuildContext context) => _viewModel,
        child: FutureBuilder(
          future: _viewModel.handleReservationHistory(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
          {
            return Consumer<ReservationHistoryViewModel>(
              builder: (BuildContext context, value, Widget? child)
              {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: value.reservationDataList.isEmpty
                      ? buildEmptyReservation()
                      :
                  ListView.builder(
                    controller: value.scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: value.reservationDataList.length,
                    itemBuilder: (BuildContext context, int index)
                    {
                      return ReservedCardItem(
                          reservationData: value.reservationDataList[index], value: value,);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// 예약 내역이 없을 시 보여주는 화면
  Widget buildEmptyReservation() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/empty_search_image.png',
              height: 60,
              width: 60),
          const Gap(10),
          Frame.myText(
            text: '현재 예약하신 내역이 없습니다.',
            fontSize: 1.0,
          ),
          const Gap(15),
        ],
      ),
    );
  }
}

/// 예약내역 리스트 아이템
class ReservedCardItem extends StatelessWidget {
  const ReservedCardItem({
    super.key,
    required this.reservationData,
    required this.value
  });

  final ReservationData reservationData;
  final ReservationHistoryViewModel value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/reservation_background_image.png'),
            fit: BoxFit.fill
        ),
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.start,
        children: [
          /// 타이틀, 예약 취소 버튼
          Row(
            children: [
              const Gap(5),

              Frame.myText(
                text: '나의 예약 현황',
                fontSize: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Gap(15),
          Etc.solidLine(context),

          /// 예약 날짜, 시간
          /// 예약장소
          Padding(
            padding: const EdgeInsets.only(left:10, top:15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Frame.myText(
                    text: '방문 장소',
                    fontSize: 1.1
                ),
                const Gap(10),
                Frame.myText(
                  text: '${reservationData.orgType?.name} 건강관리소',
                  fontWeight: FontWeight.w600,
                  fontSize: 1.1,
                ),
              ],
            ),
          ),

          /// 예약 날짜, 시간
          Padding(
            padding: const EdgeInsets.only(left:10, top:10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Frame.myText(
                    text: '예약 일시',
                    fontSize: 1.1
                ),
                const Gap(10),
                Frame.myText(
                  text: '${reservationData.reservationDate} / '
                      '${reservationData.reservationTime}',
                  fontWeight: FontWeight.w500,
                  fontSize: 1.1,
                ),
              ],
            ),
          ),

          /// 예약 상태
          Padding(
            padding: const EdgeInsets.only(left:10, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Frame.myText(
                    text: '예약 상태',
                    fontSize: 1.1
                ),
                const Gap(10),

                Frame.myText(
                  text: '${reservationData.reservationStatus}',
                  fontWeight: FontWeight.w600,
                  fontSize: 1.1,
                ),
              ],
            ),
          ),
          const Gap(15),

          Etc.solidLine(context),

          Visibility(
            visible: Etc.possibleToCancel(reservationData.reservationStatus!),
            child: InkWell(
              onTap: () => {
                CustomDialog.showCancelReservationDialog(
                    mainContext: context,
                    reservationDate: reservationData.reservationDate!,
                    reservationTime: reservationData.reservationTime!,
                    type: reservationData.orgType!,
                    cancelReservationFunction: () =>
                        value.handleCancelReservation(int.parse(
                            reservationData.reservationIdx.toString()),
                            reservationData.orgType!
                        ),
                )
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Frame.myText(
                      text: '예약 취소',
                      fontSize: 0.9,
                      fontWeight: FontWeight.w600,
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

