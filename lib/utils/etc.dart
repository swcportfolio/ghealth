import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:intl/intl.dart';
import '../widgets/frame.dart';
import 'colors.dart';
import '../main.dart';
import 'constants.dart';
import 'enum/blood_type.dart';


class Etc{

  /// 스낵바
  static showSnackBar(String meg, BuildContext context, {int seconds = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: seconds),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white,
            content: Frame.myText(
              text: meg,
              fontSize: 1.0,
              color: Colors.black
            ),
            ));
    }

  /// BG White 스낵바
  static commonSnackBar(String content, BuildContext context, {int seconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: seconds),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Container(
            padding: const EdgeInsets.all(8.0),
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, size: 30),
                const Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Frame.myText(
                          text: content,
                          fontSize: 1.1,
                          fontWeight: FontWeight.w600
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }

  ///성공 스낵바
  static successSnackBar(String content, BuildContext context, {int seconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: seconds),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Container(
            padding: const EdgeInsets.all(8.0),
            height: 55,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, size: 30, color: Colors.white),
                const Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Frame.myText(
                          text: content,
                          fontSize: 1.1,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }


  ///실패 스낵바
  static failureSnackBar(String content, BuildContext context, {int seconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: seconds),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Container(
            padding: const EdgeInsets.all(8.0),
            height: 55,
            decoration: BoxDecoration(
              color: Colors.orange.shade500,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.error, size: 30, color: Colors.white),
                const Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Frame.myText(
                          text: content,
                          fontSize: 1.1,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      ),
                    ],
                  ),
                ),

              ],
            ),
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
      if(dateInput == ''){
        return '';
      }
    // 날짜 부분 추출
    String dateString = dateInput.replaceAll(RegExp(r'[^0-9]'), '');

    // DateTime 객체로 변환
    DateTime date = DateTime.parse(dateString);

    // 원하는 형식으로 날짜 포맷
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return formattedDate;
  }

  static pointDateFormat(String inputDateTimeString) {
      if(inputDateTimeString == ''){
        return '';
      }
      // 입력된 날짜와 시간 문자열을 DateTime 객체로 변환
      DateTime inputDateTime = DateTime.parse(inputDateTimeString);

      // 출력 형식을 지정
      String outputFormat = 'yyyy-MM-dd';

      return DateFormat(outputFormat).format(inputDateTime);
  }

  static chartDateFormat(String dateInput) {
    if(dateInput == ''){
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
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.0,
        color: Colors.grey,
      ),
    );
  }

  /// 가로 라인 줄
  static solidLineWhite(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 0.5,
        color: Colors.white,
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

  static solidLineWearableBox(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.5,
        color: Colors.grey[300],
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
    String replaceText = input.replaceAll('(', ' ');
    int spaceIndex = replaceText.indexOf(' ');

    // 띄워쓰기 이후의 부분을 제거하고 결과를 반환합니다.
    return spaceIndex != -1 ? input.substring(0, spaceIndex) : replaceText;
  }

  static Color calculateBloodStatusColor(BloodDataType type, double value,
      {required Color badColor, required Color goodColor}){
      switch(type) {
        case BloodDataType.hemoglobin:
          if(Authorization().gender == 'M'){
            if(13.0 <= value && 16.5 >= value){
              return goodColor;
            } else {
              return badColor;
            }
          } else { // 여자
            if (12.0 <= value && 15.5 >= value) {
              return goodColor;
            } else {
              return badColor;
            }
          }
        case BloodDataType.fastingBloodSugar:
          if (100 > value) {
            return goodColor;
          } else {
            return badColor;
          }
        case BloodDataType.totalCholesterol:
          if (200 > value) {
            return goodColor;
          } else {
            return badColor;
          }
        case BloodDataType.highDensityCholesterol:
          if (60 < value) {
            return goodColor;
          } else {
            return badColor;
          }
        case BloodDataType.neutralFat:
          if (150 > value) {
            return goodColor;
          } else {
            return badColor;
          }
        case BloodDataType.lowDensityCholesterol:
          if (130 > value) {
            return goodColor;
          } else {
            return badColor;
          }
        case BloodDataType.serumCreatinine:
          if (1.5 >= value) {
            return goodColor;
          } else {
            return badColor;
          }
        case BloodDataType.shinsugularFiltrationRate:
          if (60 <= value) {
            return goodColor;
          } else {
            return badColor;
          }
        case BloodDataType.astSgot:
          if (40 >= value) {
            return goodColor;
          } else {
            return badColor;
          }
        case BloodDataType.altSGpt:
          if (35 >= value) {
            return goodColor;
          } else {
            return badColor;
          }
        case BloodDataType.gammaGtp:
          if(Authorization().gender == 'M'){
            if(63.0 >= value) {
              return goodColor;
            } else {
              return badColor;
            }
          } else { // 여자
            if(35.0 >= value) {
              return goodColor;
            } else {
              return badColor;
            }
          }
      }
  }

  /// 피 검사 기준 수치 반환
  static double bloodTestStandardValue(BloodDataType type){
    switch(type) {
      case BloodDataType.hemoglobin:
        return 0.0;
      case BloodDataType.fastingBloodSugar:
        return 100.0;
      case BloodDataType.totalCholesterol:
        return 200.0;
      case BloodDataType.highDensityCholesterol:
        return 60.0;
      case BloodDataType.neutralFat:
        return 150.0;
      case BloodDataType.lowDensityCholesterol:
       return 130.0;
      case BloodDataType.serumCreatinine:
        return 1.5;
      case BloodDataType.shinsugularFiltrationRate:
        return 60.0;
      case BloodDataType.astSgot:
       return 40.0;
      case BloodDataType.altSGpt:
        return 35.0;
      case BloodDataType.gammaGtp:
        if(Authorization().gender == 'M'){
          return 63.0;
        } else { // 여자
         return 35.0;
        }
    }
}

  /// urine 상태값으로 이미지 경로 반환
  static resultStatusToImageStr(String dataDesc, String value){
    if(dataDesc == '비타민' || dataDesc == '비중' || dataDesc == '산성도'){
      switch(value){
        case '0' : return 'images/plus_1.png';
        case '1' : return 'images/plus_2.png';
        case '2' : return 'images/plus_3.png';
        case '3' : return 'images/plus_4.png';
        case '4' : return 'images/plus_4.png';
        case '5' : return 'images/plus_4.png';
        default  : return 'images/plus_1.png';
      }
    }
    else {
      switch(value){
        case '0' : return 'images/step_0.png';
        case '1' : return 'images/step_1.png';
        case '2' : return 'images/step_2.png';
        case '3' : return 'images/step_3.png';
        case '4' : return 'images/step_4.png';
        case '5' : return 'images/step_4.png';
        default  : return 'images/step_0.png';
      }
    }
  }

  static resultStatusToText(String dataDesc, String value){
    if(dataDesc == '비타민' || dataDesc == '비중' || dataDesc == '산성도'){
      switch(value){
        case '0' : return '낮음';
        case '1' : return '낮음';
        case '2' : return '보통';
        case '3' : return '높음';
        case '4' : return '다소 높음';
        case '5' : return '다소 높음';
        default  : return '미 측정';
      }
    }
    else {
      switch(value){
        case '0' : return '안심';
        case '1' : return '관심';
        case '2' : return '주위';
        case '3' : return '위험';
        case '4' : return '심각';
        case '5' : return '심각';
        default  : return '미 측정';
      }
    }
  }

  static resultStatusToTextColor(String dataDesc, String value) {
    if (dataDesc == '비타민' || dataDesc == '비중' || dataDesc == '산성도') {
      return urineResultColor6;
    }
    else {
      switch (value) {
        case '0':
          return urineResultColor1;
        case '1':
          return urineResultColor2;
        case '2':
          return urineResultColor3;
        case '3':
          return urineResultColor4;
        case '4':
          return urineResultColor5;
        case '5':
          return urineResultColor5;
        default:
          return urineResultColor1;
      }
    }
  }

  /// 예약 현황에서 예약취소버튼 활성화/비활성화
 static bool possibleToCancel(String status){
      if(status == '요청' || status == '확인'){
        return true;
      } else {
        return false;
      }
  }

  /// 차트 x축 갯수에 따른 bar차트 폭 비율 리턴
  static double calculateChartWidthRatio(int length) {
    switch (length) {
      case 1:
        return 0.2;
      case 2:
        return 0.2;
      case 3:
        return 0.25;
      case 4:
        return 0.3;
      default:
        return 0.35;
    }
  }

  /// 반응형으로 생각하면 현재 디바이스 스크린의 길이를 구하는 유틸 함수
  static double getHeightByPercentOfScreen(double percent,  BuildContext context) {
    return MediaQuery.of(context).size.height * percent / 100;
  }

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

  /// 백단위로 ,(콤마) 생성
  static String formatNumberWithCommas(int number) {
    final format = NumberFormat("#,###");
    return format.format(number);
  }

  /// 달성률 계산
  static calculateAchievementRate(int value, int target){
    if (target == 0 || value == 0) {
      return 0.0;
    }

    if (value > target) {
      return 100.0;
    }

    // 달성률 계산
    double rate = (value / target) * 100;
    return rate;
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
