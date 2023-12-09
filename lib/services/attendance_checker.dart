import 'package:hive/hive.dart';

import '../data/models/attendance_data.dart';
import '../main.dart';
import 'health_service.dart';


/// `AttendanceChecker` 클래스는 출석과 관련된 작업을 수행하는 데 사용됩니다.
class AttendanceChecker {
  late Box<AttendanceData> attendanceBox;

  /// 출석을 확인하고, 필요에 따라 데이터를 추가하고
  /// 서버에서 이전 날짜의 건강 데이터를 가져옵니다.
  Future<void> checkAttendance() async {
    attendanceBox = await Hive.openBox<AttendanceData>('attendance_data');

    final now = DateTime.now();
    final nowDate = DateTime(now.year, now.month, (now.day));

    final specificDateAttendance = attendanceBox.values
        .where((attendance) => attendance.date.isAtSameMomentAs(nowDate))
        .toList();

    // final attendanceDay = AttendanceData(date: nowDate);
    // attendanceBox.add(attendanceDay);

    if (specificDateAttendance.isNotEmpty) {
      logger.i('=> 출석이 완료 되었습니다.');
      logger.i('=> 마지막 출석 날짜: ${specificDateAttendance[0].date}');
    } else {
      logger.i('=> 금일 날짜에 출석되어 있지 않습니다.');

      final allAttendanceList = attendanceBox.values.toList();
      logger.i('=>All Attendance Data: ${allAttendanceList.length}');

      if (allAttendanceList.isEmpty) {
        logger.i('=>앱 설치 후 첫 실행!!');
        addAttendanceAndFetchData(nowDate);
      } else {
        checkAndFetchMissingDates(allAttendanceList, nowDate);
      }
    }
  }

  /// 출석 데이터를 추가하고, 해당 날짜에 대한 이전 날짜의 건강 데이터를 가져옵니다.
  void addAttendanceAndFetchData(DateTime nowDate) {
    final todayAttendance = AttendanceData(date: nowDate);
    attendanceBox.add(todayAttendance);
    HealthService().fetchPreviousDayData(nowDate);
  }

  /// 누락된 날짜를 확인하고, 해당 날짜에 대한 이전 날짜의 건강 데이터를 가져옵니다.
  void checkAndFetchMissingDates(List<AttendanceData> allAttendanceList, DateTime nowDate) {
    final lastAttendanceDate = allAttendanceList.last.date;
    final datesInRangeList = getDatesInRange(lastAttendanceDate, nowDate);

    if (datesInRangeList.isNotEmpty) {
      logger.i('=> 미출석한 날짜가 있습니다.');
      for (var date in datesInRangeList) {
        logger.i('=>미 출석한 날짜(당일 포함): $date');
        HealthService().fetchPreviousDayData(date);

        final attendanceDay = AttendanceData(date: date);
        attendanceBox.add(attendanceDay);
      }
    } else {
      logger.i('=> 미출석한 날짜가 없습니다. 오늘 출석체크 하시면 됩니다.');
      addAttendanceAndFetchData(nowDate);
    }
  }

  /// 두 날짜 사이의 모든 날짜를 가져오는 함수입니다.
  ///
  /// [startDate]: 시작 날짜
  /// [endDate]: 종료 날짜
  List<DateTime> getDatesInRange(DateTime startDate, DateTime endDate) {
    logger.i('=>$startDate / $endDate');
    List<DateTime> dates = [];
    // start부터 end까지의 날짜를 추가
    for (DateTime date = startDate.add(const Duration(days: 1)) ; date.isBefore(endDate) || date.isAtSameMomentAs(endDate); date = date.add(const Duration(days: 1))) {
      dates.add(date);
    }

    return dates;
  }
}
