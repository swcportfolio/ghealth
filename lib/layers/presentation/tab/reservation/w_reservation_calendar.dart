
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/vm_reservation.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common/common.dart';
import '../../widgets/style_text.dart';

class ReservationCalendar extends StatelessWidget {
  const ReservationCalendar({super.key});

  String get titleText => '예약 날짜 선택';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.calendar_month_outlined,
              color: AppColors.primaryColor,
              size: AppDim.iconSmall,
            ),
            const Gap(AppDim.xSmall),

             StyleText(
              text: titleText,
              size: AppDim.fontSizeLarge,
              fontWeight: AppDim.weight500,
            ),
          ],
        ),
        const Gap(AppDim.medium),

        Container(
          padding: const EdgeInsets.all(AppDim.medium),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppConstants.borderLightRadius,
            border: Border.all(
              width: AppConstants.borderMediumWidth,
              color: AppColors.greyBoxBorder,
            ),
          ),
          child: Consumer<ReservationViewModelTest>(
            builder: (context, provider, child) {
              return TableCalendar(
                locale: 'ko_KR',
                availableGestures: AvailableGestures.horizontalSwipe,
                calendarBuilders: _calendarBuilder,
                headerStyle: _headerStyle, // 달력 타이틀 해드 스타일 옵션

                /// 특정 날짜 비활성화
                enabledDayPredicate: (DateTime dateTime) {
                  // 주말인 경우 선택을 비활성화합니다.
                  if (dateTime.weekday == 6 || dateTime.weekday == 7) {
                    return false;
                  }
                  // 추가적인 휴일 설정
                  return !provider.dayOffDateList.any((date) =>
                      isSameDay(date, dateTime));
                },
                firstDay: DateTime.now().add(1.days),
                lastDay: DateTime.utc(2030, 1, 1),
                focusedDay: provider.focusedDay,
                calendarStyle: _calendarStyle,
                onDaySelected: (selectedDay, focusedDay) =>
                    provider.onDaySelectedCalendar(selectedDay, focusedDay),
                selectedDayPredicate: (DateTime day) {
                  return isSameDay(provider.selectedDay, day); // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                },
              );
            },
          ),
        ),
      ],
    );
  }


  HeaderStyle get _headerStyle => HeaderStyle(
      titleTextStyle: TextStyle(color: AppColors.primaryColor,
          fontSize: 18,
          fontWeight: AppDim.weightBold),
      leftChevronIcon: Icon(
          Icons.chevron_left, color: AppColors.primaryColor),
      rightChevronIcon: Icon(
          Icons.chevron_right, color: AppColors.primaryColor),
      formatButtonVisible: false,
      titleCentered: true
  );


  CalendarBuilders get _calendarBuilder =>
      CalendarBuilders(
        /// week Text Style
          dowBuilder: (context, day) {
            switch (day.weekday) {
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
                return const Center(child: Text('토',
                    style: TextStyle(color: AppColors.red)),);
              case 7:
                return const Center(child: Text('일',
                    style: TextStyle(color: AppColors.red)));
            }
            return null;
          }
      );


  CalendarStyle get _calendarStyle => CalendarStyle(
        outsideDaysVisible: true,
        weekendTextStyle: const TextStyle().copyWith(color: AppColors.red),
        todayDecoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryColor, width: 3)),
        selectedDecoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
            fontWeight: AppDim.weightBold, color: AppColors.primaryColor),
      );
}
