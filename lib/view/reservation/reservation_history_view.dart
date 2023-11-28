import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/reservation/reservation_history_viewmodel.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:ghealth_app/widgets/horizontal_dashed_line.dart';
import 'package:provider/provider.dart';

import '../../data/models/reservation_data.dart';
import '../../utils/colors.dart';
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
                  ListView.separated(
                    controller: value.scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: value.reservationDataList.length,
                    itemBuilder: (BuildContext context, int index)
                    {
                      return ReservedCardItem(
                          reservationData: value.reservationDataList[index]);
                    },
                    separatorBuilder: (BuildContext context, int index)
                    {
                      return const HorizontalDottedLine(mWidth: double.infinity);
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
  const ReservedCardItem({super.key, required this.reservationData});
  final ReservationData reservationData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.start,
          children: [
            /// 타이틀, 예약 취소 버튼
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Frame.myText(
                  text: '건강관리소 방문 예약',
                  fontWeight: FontWeight.w600,
                  fontSize: 1.5,
                  color: mainColor,
                ),
                Visibility(
                  visible: Etc.possibleToCancel(reservationData.reservationStatus!),
                  child: Frame.myText(
                    text: '예약 취소',
                    fontSize: 1.0,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            const Gap(15),

            /// 예약 날짜, 시간
            Padding(
              padding:
              const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  const Icon(
                      Icons.access_time_outlined,
                      color: mainColor),
                  const Gap(10),
                  Frame.myText(
                    text:
                    '${reservationData.reservationDate} / '
                        '${reservationData.reservationTime}',
                    fontWeight: FontWeight.w500,
                    fontSize: 1.1,
                  ),
                ],
              ),
            ),

            /// 예약 상태
            Padding(
              padding:
              const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  const Icon(
                      Icons.edit_calendar_outlined,
                      color: mainColor),
                  const Gap(10),
                  Row(
                    children: [
                      Frame.myText(
                        text: '예약 상태: ',
                        fontWeight: FontWeight.w500,
                        fontSize: 1.1,
                      ),
                      Frame.myText(
                        text: '${reservationData.reservationStatus}',
                        fontWeight: FontWeight.w600,
                        fontSize: 1.1,
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20, bottom: 10),
            //   child: reservationStatusBtn('예약 취소', const Color(0xFFececec), context),
            // )
          ],
        ),
      ),
    );
  }


  Widget reservationStatusBtn(String text, Color bgColor, BuildContext context){
    return InkWell(
      onTap: ()=>{},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all( width: 1.5, color: Colors.grey)

        ),
        child: Frame.myText(
          text: text,
          fontSize: 1.1,
          color: Colors.grey.shade700
        ),
      ),
    );
  }

}

