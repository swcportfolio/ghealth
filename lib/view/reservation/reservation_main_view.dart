import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/reservation/reservation_history_view.dart';
import 'package:ghealth_app/view/reservation/reservation_viewmodel.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/models/authorization.dart';
import '../../utils/colors.dart';
import '../../utils/snackbar_utils.dart';
import '../../widgets/dialog.dart';
import '../login/login_view.dart';

/// 예약 화면
class ReservationMainView extends StatefulWidget {
  const ReservationMainView({super.key});

  @override
  State<ReservationMainView> createState() => _ReservationMainViewState();
}

class _ReservationMainViewState extends State<ReservationMainView> {
  late ReservationViewModel _viewModel;

  late Size size;

  @override
  void initState() {
    super.initState();
    _viewModel = ReservationViewModel(context);
  }

  @override
  Widget build(BuildContext context) {

    /// AccessToken 확인
    Authorization().checkAuthToken().then((result) {
      if(!result){
        SnackBarUtils.showBGWhiteSnackBar(
            '권한 만료, 재 로그인 필요합니다.', context);
        Frame.doPagePush(context, const LoginView());
      }
    });

    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      body: ChangeNotifierProvider(
        create: (BuildContext context) => _viewModel,
        child: SingleChildScrollView(
          controller: _viewModel.controller,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              buildTitle(),

              buildMyCurrentReservation(),

              buildCalendar(context),

              buildSelectTime(),

              buildReservationBtn()
            ],
          ),
        ),
      ),
    );
  }
  /// 예약 타이틀
  Widget buildTitle() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Frame.myText(
          text: '언제 건강관리소에\n방문하시나요?',
          maxLinesCount: 2,
          fontSize: 1.6,
          fontWeight: FontWeight.bold
      ),
    );
  }

  /// 내 현재 예약 현황
  /// 가장 최신 예약 내역 1개만 보여준다.
  Widget buildMyCurrentReservation(){
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      margin: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/reservation_background_image.png'),
            fit: BoxFit.fill
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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

              InkWell(
                onTap: ()=> Frame.doPagePush(context, const ReservationHistoryView()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Frame.myText(
                        text: '예약 내역 조회',
                        color: Colors.grey
                    ),
                    const Gap(5),
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 15,),
                  ],
                ),
              )
            ],
          ),
          const Gap(15),
          Etc.solidLine(context),

          SizedBox(
            width: double.infinity,
            child: FutureBuilder(
              future: _viewModel.handleRecentReservation(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasError){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Frame.myText(
                          text: '방문 예약 내역을 불러오지 못했습니다.',

                      ),
                    ),
                  );
                }
                else if(snapshot.connectionState == ConnectionState.waiting){
                  return Frame.buildFutureBuildProgressIndicator();
                }
                else {
                  return Consumer<ReservationViewModel>(
                    builder: (BuildContext context, value, Widget? child) {
                      return value.recentReservationData.reservationStatus == ''
                          ? Center(
                          child: Container(
                              height: 45,
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: reservedCardBgColor,
                                  borderRadius:
                                  BorderRadius.circular(20.0)),
                              child: Frame.myText(text: '방문예약 내역이 없습니다.')))
                          : Container(
                        height: 150,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [

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
                                    text: '동구라이프로그 건강관리소',
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
                                    text: '${value.recentReservationData.reservationDate} / '
                                        '${value.recentReservationData.reservationTime}',
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
                                    text: '${value.recentReservationData.reservationStatus}',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 1.1,
                                  ),
                                ],
                              ),
                            ),
                            const Gap(15),

                            Etc.solidLine(context),

                            Visibility(
                              visible: Etc.possibleToCancel(value.recentReservationData.reservationStatus!),
                              child: InkWell(
                                onTap: () => {
                                  CustomDialog.showCancelReservationDialog(
                                      mainContext: context,
                                      reservationDate: value.recentReservationData.reservationDate!,
                                      reservationTime: value.recentReservationData.reservationTime!,
                                      cancelReservationFunction: () =>
                                          value.handleCancelReservation(int.parse(value
                                              .recentReservationData
                                              .reservationIdx
                                              .toString()))
                                  )
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Frame.myText(
                                    text: '예약 취소',
                                    fontSize: 0.9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      );

                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  /// 예약 달력 위젯
  Widget buildCalendar(BuildContext context){
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined, color: mainColor, size: 30),
              const Gap(5),

              Frame.myText(
                text: '예약 날짜 선택',
                fontSize: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Gap(15),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Consumer<ReservationViewModel>(
                  builder: (BuildContext context, value, Widget? child) {
                    return SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: TableCalendar(
                        locale: 'ko_KR',
                        calendarBuilders: CalendarBuilders(
                          /// week Text Style
                            dowBuilder: (context, day) {
                              switch(day.weekday){
                                case 1:
                                  return const Center(child: Text('월'),);
                                case 2:
                                  return const Center(child: Text('화'),);
                                case 3:
                                  return const Center(child: Text('수'),);
                                case 4:
                                  return const Center(child: Text('목'),);
                                case 5:
                                  return const Center(child: Text('금'),);
                                case 6:
                                  return const Center(child: Text('토',style: TextStyle(color: Colors.red)),);
                                case 7:
                                  return const Center(child: Text('일',style: TextStyle(color: Colors.red)));
                              }
                              return null;
                            }),

                        /// 달력 타이틀 해드 스타일 옵션
                        headerStyle: const HeaderStyle(
                            titleTextStyle: TextStyle(color: mainColor, fontSize: 18, fontWeight: FontWeight.w600),
                            leftChevronIcon: Icon(Icons.chevron_left, color: mainColor),
                            rightChevronIcon: Icon(Icons.chevron_right, color: mainColor),
                            formatButtonVisible: false,
                            titleCentered: true
                        ),

                        /// 특정 날짜 비활성화
                        enabledDayPredicate: (DateTime dateTime){
                          // 주말인 경우 선택을 비활성화합니다.
                          if (dateTime.weekday == 6 || dateTime.weekday == 7) {
                            return false;
                          }

                          // 추가적인 휴일 설정
                          return !value.dayOffDateList.any((date) =>isSameDay(date, dateTime));
                        },
                        firstDay: DateTime.now().add(const Duration(days: 1)),
                        lastDay: DateTime.utc(2030, 1, 1),
                        focusedDay: value.focusedDay,
                        calendarStyle: CalendarStyle(
                            outsideDaysVisible: true,
                            weekendTextStyle: const TextStyle().copyWith(color: Colors.red),
                            todayDecoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(color: mainColor, width: 3)),
                            selectedDecoration: const BoxDecoration(
                              color: mainColor,
                              shape: BoxShape.circle,
                            ),
                            todayTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: mainColor
                            )),

                        onDaySelected: (DateTime selectedDay, DateTime focusedDay) =>
                            value.onDaySelectedCalendar(selectedDay, focusedDay),
                        selectedDayPredicate: (DateTime day) {
                          // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                          return isSameDay(value.selectedDay, day);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildSelectTime() {
    return Consumer<ReservationViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        return Visibility(
          visible: value.isVisibleSelectTime,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined,
                        color: mainColor, size: 30),
                    const Gap(5),
                    Frame.myText(
                      text: '시간을 선택해주세요.',
                      fontSize: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const Gap(15),
                buildSelectTimeGridview(value.possibleDateTime)
              ],
            ),
          ),
        );
      },
    );
  }

  /// 예약 버튼 위젯
  ///
  Widget buildReservationBtn(){
    return Consumer<ReservationViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        return Visibility(
          visible: value.isVisibleReservationBtn,
          child: InkWell(
            onTap: ()=>{
              CustomDialog.showReservationDialog(
                  width: size.width,
                  mainContext: context,
                  reservationDate: DateFormat('yyyy-MM-dd').format(value.selectedDay),
                  reservationTime: value.selectedTime!,
                  saveReservationFunction: ()=> value.handleSaveReservation()
              )
            },
            child: Container(
              height: 55,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              decoration: const BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Center(
                child: Frame.myText(
                  text: '예약하기',
                  fontSize: 1.4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSelectTimeGridview(List<String> possibleDateTimeList){
    return  Consumer<ReservationViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        return possibleDateTimeList.isEmpty
            ? Container(
            height: 45,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
                color: reservedCardBgColor,
                borderRadius: BorderRadius.circular(20.0)
            ),
            child: Frame.myText(text: '선택하신 날짜에 예약할 수 있는 시간이 없습니다.'))
            : Container(
          //height: 140,
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
          child: GridView.builder(
            itemCount: possibleDateTimeList.length,
            scrollDirection: Axis.vertical,
            //default
            reverse: false,
            //default
            controller: ScrollController(),
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(5.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 3.1,
            ),
            semanticChildCount: 3,
            cacheExtent: 0.0,
            dragStartBehavior: DragStartBehavior.start,
            clipBehavior: Clip.hardEdge,
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.manual,
            itemBuilder: (BuildContext context, int index) {
              return _buildSortOption(possibleDateTimeList[index], value,
                  value.isSelectedList[index], index);
            },
            // List of Widgets
          ),
        );
      },
    );
  }

  Widget _buildSortOption(
      String time,
      ReservationViewModel value,
      bool selected,
      int index) {
    return GestureDetector(
      onTap: () {
        value.onTapSelectItem(index);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: selected ?  mainColor : Colors.white,
          border: Border.all(
            color:  selected ? mainColor : Colors.grey.shade400,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Frame.myText(
              text: time,
              fontSize: 1.0,
              fontWeight: selected? FontWeight.w600 : FontWeight.w400,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
// Widget buildMultiSelectTime(){
//   return Container(
//     height: 140,
//     margin: const EdgeInsets.all(15),
//     child: GridView.builder(
//       itemCount: sampleTimeList.length,
//       scrollDirection: Axis.vertical,           //default
//       reverse: false,                           //default
//       controller: ScrollController(),
//       primary: false,
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       padding: const EdgeInsets.all(5.0),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 3,
//     mainAxisSpacing: 10.0,
//     crossAxisSpacing: 10.0,
//           childAspectRatio:3.1
//     ),
//     semanticChildCount: 3,
//     cacheExtent: 0.0,
//     dragStartBehavior: DragStartBehavior.start,
//     clipBehavior: Clip.hardEdge,
//     keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
//     itemBuilder: (BuildContext context, int index) {
//         return _buildSortOption(sampleTimeList[index], isSelected[index], index);
//     },
//       // List of Widgets
//     ),
//   );
// }
// Widget _buildSortOption(String time, bool selected, int index) {
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         isSelected = List.filled(7, false); // Unselect all
//         if(selected){
//           isSelected[index] = false;
//           selectedIndex == null;
//         } else {
//           isSelected[index] = true; // Select the tapped item
//           selectedIndex = index;
//         }
//
//       });
//     },
//     child: Container(
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: selected ? mainColor : Colors.white,
//         border: Border.all(
//           color: selected ? mainColor : Colors.grey.shade400,
//           width: 1.5,
//           style: BorderStyle.solid,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: Center(
//           child: Frame.myText(
//             text: time,
//             fontSize: 1.1,
//             fontWeight: FontWeight.w400,
//             color: selected ? Colors.white : Colors.black,
//             ),
//           ),
//         ),
//       ),
//   );
// }


