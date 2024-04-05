
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../main.dart';

class TextFormatter {

  static defaultDateFormat(String dateInput) {
    if (dateInput == '') {
      return '';
    }
    String dateString = dateInput.replaceAll(RegExp(r'[^0-9]'), '');
    DateTime date = DateTime.parse(dateString);

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return formattedDate;
  }


  static pointDateFormat(String dateInput) {
    if (dateInput == '') {
      return '';
    }
    DateTime date = DateTime.parse(dateInput);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return formattedDate;
  }

  /// 백단위로 ,(콤마) 생성
  static String formatNumberWithCommas(int number) {
    final format = NumberFormat("#,###");
    return format.format(number);
  }

  /// ####-##-## 포멧에 맞춰 변경
  static String myDataFormatDate(String originalDateString) {
    if (originalDateString.length == 8) {
      // 연도, 월, 일로 나누기
      String year = originalDateString.substring(0, 4);
      String month = originalDateString.substring(4, 6);
      String day = originalDateString.substring(6);

      // "-" 추가
      return '$year-$month-$day';
    } else {
      // 유효하지 않은 날짜 문자열 처리
      return '0000-00-00';
    }
  }

  /// chart x축 날짜 format(MM/dd)
  static String setXAxisDateTime(int duration) {
    final now = DateTime.now();
    final returnDate = now.subtract(Duration(days: duration));

    return DateFormat('MM/dd').format(returnDate);
  }


  /// SeriesChart x축 날짜 텍스트 변환 후 출력
  static seriesChartXAxisDateFormat(String dateInput) {
    if (dateInput == '') {
      return '';
    }
    // 날짜 부분 추출
    String dateString = dateInput.replaceAll(RegExp(r'[^0-9]'), '');

    // DateTime 객체로 변환
    DateTime date = DateTime.parse(dateString);

    // 원하는 형식으로 날짜 포맷
    String formattedDate = DateFormat('yyyy.MM').format(date);

    return formattedDate;
  }





  static String setSearchDateView(DateTime dateTime) {
    // int year     = int.parse(dateTime.substring(0, 4));
    // int month    = int.parse(dateTime.substring(4, 6));
    // int day      = int.parse(dateTime.substring(6, 8));

    final mDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);

    return DateFormat('yyyy년 MM월 dd일').format(mDateTime);
  }

  /// targetDate 기준으로 경과시간 출력
  static timeAgoDisplay(DateTime? targetDate) {
    final now = DateTime.now();
    final difference = now.difference(targetDate ?? now);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}초 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 10) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 30) {
      final weeksAgo = (difference.inDays / 7).floor();
      return '$weeksAgo주 전';
    } else if (difference.inDays < 60) {
      return '1개월 전';
    } else if (difference.inDays < 180) {
      final monthsAgo = (difference.inDays / 30).floor();
      return '$monthsAgo개월 전';
    } else {
      return DateFormat('yyyy년 MM월 dd일').format(targetDate ?? now);
    }
  }
}