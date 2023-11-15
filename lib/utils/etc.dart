import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../widgets/frame.dart';
import 'colors.dart';
import '../main.dart';


class Etc{

  /// 스낵바
  static showSnackBar(String meg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(milliseconds: 2000),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white,
            content: Frame.myText(
              text: meg,
              fontSize: 1.0,
              color: Colors.black
            ),
            ));
    }

  static var snackBarWidget = SnackBar(
    content: SizedBox(
      height: 30,
      child: Center(
        child: Frame.myText(
            text: '네트워크 연결을 확인해주세요',
            fontSize: 1.0,
            color: Colors.white),
      ),
    ),
    duration: const Duration(days: 1), // 예: 1일 동안 유지
    behavior: SnackBarBehavior.floating, // 상단에 위치하도록 설정
  );

    static timeAgoDisplay(DateTime? targetDate){
      final now = DateTime.now();
      final difference = now.difference(targetDate?? now);

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
        return DateFormat('yyyy년 MM월 dd일').format(targetDate?? now);
      }
    }

  static defaultDateFormat(String dateInput) {
    // 날짜 부분 추출
    String dateString = dateInput.replaceAll(RegExp(r'[^0-9]'), '');

    // DateTime 객체로 변환
    DateTime date = DateTime.parse(dateString);

    // 원하는 형식으로 날짜 포맷
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return formattedDate;
  }

  /// chart x축 날짜 format(MM/dd)
  static String setDateTime(int duration) {
    final now = DateTime.now();
    final returnDate = now.subtract(Duration(days:duration));

    return DateFormat('MM/dd').format(returnDate);
  }


  /// 채팅 메시지 생성 날짜
  static chatTimeAgoDisplay(DateTime? targetDate){
    final now = DateTime.now();
    final difference = now.difference(targetDate?? now);

    if (difference.inSeconds < 60) {
      return DateFormat('a hh:mm', 'ko_KR').format(targetDate?? now);
    } else if (difference.inMinutes < 60) {
      return DateFormat('a hh:mm', 'ko_KR').format(targetDate?? now);
    } else if (difference.inHours < 24) {
      return DateFormat('a hh:mm', 'ko_KR').format(targetDate?? now);
    } else if (difference.inDays < 10) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 30) {
      return DateFormat('MM. dd.').format(targetDate?? now);
    } else if (difference.inDays < 60) {
      return '1개월 전';
    } else if (difference.inDays < 180) {
      final monthsAgo = (difference.inDays / 30).floor();
      return '$monthsAgo개월 전';
    } else {
      return DateFormat('yyyy. MM. dd.').format(targetDate?? now);
    }
  }

  /// 주소 가공
  static processAddress(String address) {
      List<String> list = address.split(' ').toList();
      return '${list[1]} ${list[2]}';
  }

  /// 주소 가공
  static processAddressToRegion(String address) {
    List<String> list = address.split(' ').toList();
    return list[2];
  }

  /// 주소 가공
  static processFrontAddress(String address) {
    List<String> list = address.split('/').toList();
    return list[0];
  }

  static String setSearchDateView(DateTime dateTime) {
    // int year     = int.parse(dateTime.substring(0, 4));
    // int month    = int.parse(dateTime.substring(4, 6));
    // int day      = int.parse(dateTime.substring(6, 8));

    final mDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);

    return DateFormat('yyyy년 MM월 dd일').format(mDateTime);
  //'yyyy년MM월dd일 (EEEE)', 'ko_KR'
  }


  //    ProvideService('홈캠촬영 동의', false, 'home_cam.png'),
  //     ProvideService('신분증확인 가능', false, 'identification.png'),
  //     ProvideService('놀이제공 가능', false, 'fishing.png'),
  //     ProvideService('사전만남 가능', false, 'meeting.png'),
  //     ProvideService('단기돌봄 가능', false, 'short_term.png'),
  //     ProvideService('장기돌봄 가능', false, 'long.png'),
  //     ProvideService('긴급돌봄 가능', false, 'emergency.png'),

  /// 제공가능한 서비스 이름으로 이미지 이름 반환
  static String serviceNameToImageName(String serviceName) {
    String imageName = '';

    switch (serviceName) {
      case '홈캠촬영동의':{
          imageName = 'home_cam.png';
          break;
        }
      case '단기돌봄가능':{
          imageName = 'short_term.png';
          break;
        }
      case '신분증확인가능':{
          imageName = 'identification.png';
          break;
        }
      case '놀이제공가능':{
          imageName = 'fishing.png';
          break;
        }
      case '사전만남가능':{
          imageName = 'meeting.png';
          break;
        }
      case '장기돌봄가능':{
          imageName = 'long.png';
          break;
        }
      case '긴급돌봄가능':{
          imageName = 'emergency.png';
          break;
        }
    }
    return imageName;
  }
  /// 가로 두꺼운 회식 줄
  static solidGreyLine(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 10.0,
      color: Color(0xFFF3F3F3),
    );
  }


  /// 가로 라인 줄
  static solidLine(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.0,
        color: Colors.grey.shade200,
      ),
    );
  }

  /// 가로 라인 줄
  static solidLineCustom(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0))
        ),
        child: Container(
          height: 10,
        ),
      ),
    );
  }

  /// 가로 라인 줄
  static solidNotPaddingLine(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.0,
        color: Colors.grey,
      ),
    );
  }


  /// 세로 라인 줄
  static buildVerticalDivider(Color color){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: 0.5,
        height: 25,
        color: color,
      ),
    );
  }

  static solidLineSetting(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.0,
        color: Colors.grey[100],
      ),
    );
  }

    
  /// 날짜 ' '기준으로 자르기
  static String  dateParsing(String value) {
    int targetNum = value.indexOf(' ');

    String date = value.substring(0, targetNum);
    String time = value.substring(targetNum, value.length);

    String sum = '$date\n$time';
    return sum;
  }

  /// List<int> to String('A,B,C...')
  static String intListToString(List<int> list){
    return list.map((item) => item)
        .toList()
        .join(',');
  }

  /// map() print
  static void getValuesFromMap(Map map) {
      logger.f(map);
    // Get all values
    // mLog.i('\n-----------------------');
    // mLog.i('Map Get values:');
    // map.entries.forEach((entry){
    //   mLog.d('${entry.key} : ${entry.value}');
    // });
    // mLog.i('-----------------------\n');
  }

  /// font size fixation
  static MediaQueryData getScaleFontSize(BuildContext context, {double fontSize = 1.0}){
    final mqData = MediaQuery.of(context);
    return mqData.copyWith(textScaleFactor: fontSize);
  }


  /// 홈 화면에 상담진행률에 따른 이미지 설정
  static String setProgressImage(int allProgress) {
    if(allProgress == 0){
      return 'images/progress_0.png';
    }
    else if(allProgress <= 15){
      return 'images/progress_10.png';
    }
    else if(allProgress <= 25){
      return 'images/progress_20.png';
    }
    else if(allProgress <= 35){
      return 'images/progress_30.png';
    }
    else if(allProgress <= 45){
      return 'images/progress_40.png';
    }
    else if(allProgress <= 55){
      return 'images/progress_50.png';
    }
    else if(allProgress <= 65){
      return 'images/progress_60.png';
    }
    else if(allProgress <= 75){
      return 'images/progress_70.png';
    }
    else if(allProgress <= 85){
      return 'images/progress_80.png';
    }
    else if(allProgress <= 95){
      return 'images/progress_90.png';
    }
    else if(allProgress == 100){
      return 'images/progress_100.png';
    }else{
      return 'images/progress_0.png';
    }

  }


  /// 채팅 그룹 아이디 생성시 사용된다.
  /// 두 개의 아이디를 정렬한 후에 조합하여 채팅 그룹 아이디를 만듭니다.
  /// 오름차순으로 정렬하여 서로 같은 유저아이디가 바뀌여도 동일한 groupId를 생성한다.
  static String generateChatGroupId(String userId1, String userId2) {
    final beforeSortedIds = [userId1, userId2];
    beforeSortedIds.sort();

    return '${beforeSortedIds[0]}_${beforeSortedIds[1]}';
  }

  ///MetrologyInspection 계측 검사 결과 불필요한 String 자르기
  static String removeAfterSpace(String input) {
    // 문자열에서 첫 번째 띄워쓰기의 인덱스를 찾습니다.
    int spaceIndex = input.indexOf(' ');

    // 띄워쓰기 이후의 부분을 제거하고 결과를 반환합니다.
    return spaceIndex != -1 ? input.substring(0, spaceIndex) : input;
  }
}

class NoSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // 입력된 텍스트에서 공백 제거
    String text = newValue.text.replaceAll(' ', '');
    return newValue.copyWith(text: text, composing: TextRange.empty);
  }
}
