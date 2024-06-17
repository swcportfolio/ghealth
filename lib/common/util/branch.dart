
import 'package:flutter/material.dart';
import '../../layers/model/enum/blood_data_type.dart';

/// 분기 계산 클래스
class Branch {


  static resultStatusToPercent(List<String> statusResult, int index) {
      switch (statusResult[index]) {
        case '0':
          return 0.1;
        case '1':
          return 0.3;
        case '2':
          return 0.4;
        case '3':
          return 0.6;
        case '4':
          return 1.0;
        case '5':
          return 1.0;
        default:
          return 0.1;
      }
  }

  static Color calculateBloodStatusColor(BloodDataType type, double value,
      {required Color badColor, required Color goodColor}) {
    switch (type) {
      case BloodDataType.hemoglobin:
        //TODO: gender 부분 수정해줘야됨 (type.label임시)
        if (type.label == 'M') {
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
        //TODO: (type.label) 임시
        if (type.label == 'M') {
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
        //TODO: 임시
       // if (Authorization().gender == 'M') {
          return 63.0;
       // } else {
          // 여자
          return 35.0;
       // }
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


  /// 예약 현황에서 예약취소버튼 활성화/비활성화
  static bool possibleToCancel(String status) {
    if (status == '요청' || status == '확인') {
      return true;
    } else {
      return false;
    }
  }

  /// 메인화면 버튼 이미지
  static String buttonImageSwitch(String value){
    switch(value){
      case '검사하기':  return 'first_btn.png';
      case '검사 내역':  return 'second_btn.png';
      case '성분 분석':  return 'third_btn.png';
      case '나의 추이':  return 'second_btn.png';
      default : return 'first_btn.png';
    }
  }
}