import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import '../data/enum/blood_type.dart';
import '../main.dart';

class Etc {

  /// 가로 두꺼운 회식 줄
  static solidGreyLine(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 10.0,
      color: const Color(0xFFF3F3F3),
    );
  }

  /// 가로 라인 줄
  static solidLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.0,
        color: Colors.grey,
      ),
    );
  }

  /// 가로 흰색 줄
  static solidLineWhite(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 0.5,
        color: Colors.white,
      ),
    );
  }

  /// 세로 라인 줄
  static buildVerticalDivider(Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: 0.5,
        height: 25,
        color: color,
      ),
    );
  }


  /// 나의 건강 일지 화면 라인줄
  static solidLineWearableBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.5,
        color: Colors.grey[300],
      ),
    );
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
  static MediaQueryData getScaleFontSize(BuildContext context,
      {double fontSize = 1.0}) {
    final mqData = MediaQuery.of(context);
    return mqData.copyWith(textScaleFactor: fontSize);
  }

  /// 홈 화면에 상담진행률에 따른 이미지 설정
  static String setProgressImage(int allProgress) {
    if (allProgress == 0) {
      return 'images/progress_0.png';
    } else if (allProgress <= 15) {
      return 'images/progress_10.png';
    } else if (allProgress <= 25) {
      return 'images/progress_20.png';
    } else if (allProgress <= 35) {
      return 'images/progress_30.png';
    } else if (allProgress <= 45) {
      return 'images/progress_40.png';
    } else if (allProgress <= 55) {
      return 'images/progress_50.png';
    } else if (allProgress <= 65) {
      return 'images/progress_60.png';
    } else if (allProgress <= 75) {
      return 'images/progress_70.png';
    } else if (allProgress <= 85) {
      return 'images/progress_80.png';
    } else if (allProgress <= 95) {
      return 'images/progress_90.png';
    } else if (allProgress == 100) {
      return 'images/progress_100.png';
    } else {
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
      {required Color badColor, required Color goodColor}) {
    switch (type) {
      case BloodDataType.hemoglobin:
        if (Authorization().gender == 'M') {
          if (13.0 <= value && 16.5 >= value) {
            return goodColor;
          } else {
            return badColor;
          }
        } else {
          // 여자
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
        if (Authorization().gender == 'M') {
          if (63.0 >= value) {
            return goodColor;
          } else {
            return badColor;
          }
        } else {
          // 여자
          if (35.0 >= value) {
            return goodColor;
          } else {
            return badColor;
          }
        }
    }
  }

  /// 피 검사 기준 수치 반환
  static double bloodTestStandardValue(BloodDataType type) {
    switch (type) {
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
        if (Authorization().gender == 'M') {
          return 63.0;
        } else {
          // 여자
          return 35.0;
        }
    }
  }


  /// 예약 현황에서 예약취소버튼 활성화/비활성화
  static bool possibleToCancel(String status) {
    if (status == '요청' || status == '확인') {
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

  /// 수면, 걷기 달성률 계산
  static calculateAchievementRate(int value, int target) {
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

  static Color getBloodPressureColor(String resultText, String resultLabel) {
    Color borderColor = Colors.blueAccent;

    if(resultLabel == '청력(좌/우)') {
      if(resultText.contains('비정상') || resultText.contains('비 정상')) {
        borderColor = Colors.red;
      }
    } else if(resultLabel == '혈압') {

      List<int> values = resultText
          .split('/')
          .map((value) => int.tryParse(value.trim()) ?? 0)
          .toList();

      // 추출한 혈압 값이 유효한지 확인
      if (values.length == 2) {
        int systolic = values[0];
        int diastolic = values[1];

        // 혈압이 정상 범위인 경우 파랑색 반환
        if (systolic <= 120 && diastolic <= 80) {
          return borderColor;
        }
        // 그 외의 경우 빨간색을 반환
        else {
          return Colors.red;
        }
      } else {
        // 혈압 값이 올바르게 구성되지 않은 경우 파랑색 반환
        return borderColor;
      }
    }
    return borderColor;
  }
}
