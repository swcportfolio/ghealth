import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/reservation/reservation_history_view.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:ghealth_app/widgets/girdview/gridview_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/colors.dart';
import '../../widgets/girdview/gridview_provider.dart';

/// 예약 화면
class ReservationView extends StatefulWidget {
  const ReservationView({super.key});

  @override
  State<ReservationView> createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {

  late DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();

  late int? selectedIndex = 0;

  late ReservationTime _reservationTime;

  @override
  Widget build(BuildContext context) {
    _reservationTime = Provider.of<ReservationTime>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '방문 예약하기',
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle(),
            buildCalendar(context),
            buildTimeTitle(),
            const SelectTimeGridview(
                mWidth: double.infinity, mHeight: 140, childAspectRatio: 3.1),
            buildReservationBtn()
          ],
        ),
      ),
    );
  }

  /// 예약 타이틀
  Widget buildTitle() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20,30,20, 0),
      child: Frame.myText(
        text: '날짜를 선택하세요.',
        fontSize: 1.6,
        fontWeight: FontWeight.bold
      ),
    );
  }

  /// 예약 달력
  Widget buildCalendar(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TableCalendar(
            locale: 'ko_KR',

            /// week Text Style
            calendarBuilders: CalendarBuilders(
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
                  return const Center(child: Text('일',style: TextStyle(color: Colors.red),),);
              }
              return null;
            }),

            /// 달력 타이틀 해드 스타일 옵션
            headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(color: mainColor, fontSize: 18),
                leftChevronIcon: Icon(Icons.chevron_left, color: mainColor),
                rightChevronIcon: Icon(Icons.chevron_right, color: mainColor),
              formatButtonVisible: false,
              titleCentered: true
            ),

            /// 특정 날짜 비활성화
            enabledDayPredicate: (DateTime date){
              final disabledDate = DateTime(2023, 10, 30);
              return !isSameDay(disabledDate, date);
            },
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: focusedDay,
            calendarStyle: CalendarStyle(
                outsideDaysVisible: true,
                weekendTextStyle: TextStyle().copyWith(color: Colors.red),
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


            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
             // 선택된 날짜의 상태를 갱신합니다.
              setState((){
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime day) {
              // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
              return isSameDay(selectedDay, day);
            },
          ),
        ),
      ),
    );
  }

  /// 시간 타이틀
  Widget buildTimeTitle() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20,30,20, 0),
      child: Frame.myText(
          text: '시간을 선택하세요.',
          fontSize: 1.4,
          fontWeight: FontWeight.w500
      ),
    );
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

  /// 예약 버튼
  Widget buildReservationBtn(){
    return GestureDetector(
      onTap: ()=> {
        if(_reservationTime.selectTime == null){
        Etc.showSnackBar('방문 시간을 선택해주세요.', context)
      }  else {
        reservationList.add(Reservation(userID: 'admin', date: DateFormat('yy-MM-dd(EE)', 'ko_KR').format(selectedDay), time: _reservationTime.selectTime!)),
        Etc.showSnackBar('방문 예약이 완료 되었습니다.', context),
        Navigator.pop(context),
      }
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
    );
  }
}

