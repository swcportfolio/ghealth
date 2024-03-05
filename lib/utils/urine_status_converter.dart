

import 'colors.dart';

class UrineStatusConverter {
  /// urine 상태값으로 이미지 경로 반환
  static resultStatusToImageStr(String dataDesc, String value) {
    if (dataDesc == '비타민' || dataDesc == '비중' || dataDesc == '산성도') {
      switch (value) {
        case '0':
          return 'images/plus_1.png';
        case '1':
          return 'images/plus_2.png';
        case '2':
          return 'images/plus_3.png';
        case '3':
          return 'images/plus_4.png';
        case '4':
          return 'images/plus_4.png';
        case '5':
          return 'images/plus_4.png';
        default:
          return 'images/plus_1.png';
      }
    } else {
      switch (value) {
        case '0':
          return 'images/step_0.png';
        case '1':
          return 'images/step_1.png';
        case '2':
          return 'images/step_2.png';
        case '3':
          return 'images/step_3.png';
        case '4':
          return 'images/step_4.png';
        case '5':
          return 'images/step_4.png';
        default:
          return 'images/step_0.png';
      }
    }
  }

  static resultStatusToText(String dataDesc, String value) {
    if (dataDesc == '비타민' || dataDesc == '비중' || dataDesc == '산성도') {
      switch (value) {
        case '0':
          return '낮음';
        case '1':
          return '낮음';
        case '2':
          return '보통';
        case '3':
          return '높음';
        case '4':
          return '다소 높음';
        case '5':
          return '다소 높음';
        default:
          return '미 측정';
      }
    } else {
      switch (value) {
        case '0':
          return '안심';
        case '1':
          return '관심';
        case '2':
          return '주위';
        case '3':
          return '위험';
        case '4':
          return '심각';
        case '5':
          return '심각';
        default:
          return '미 측정';
      }
    }
  }

  /// 소변분석 결과에 따른 색상 설정
  static resultStatusToTextColor(String dataDesc, String value) {
    if (dataDesc == '비타민' || dataDesc == '비중' || dataDesc == '산성도') {
      return urineResultColor6;
    } else {
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
}