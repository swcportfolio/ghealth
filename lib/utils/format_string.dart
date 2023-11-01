
import 'dart:math';

class FormatString{

  /// 고양이 성별 String 확장
  static formatGender(String txt) {
    if(txt == 'female'){
      return '(여아)';
    } else {
      return '(남아)';
    }
  }

  /// 중성화 String 확장
  static formatNeutered(String txt) {
    if(txt == '안했어요'){
      return '중성화 안했어요';
    } else {
      return '중성화 했어요';
    }
  }


  /// 고양이 다묘경험
  static formatFewCats(String txt) {
    if(txt != '다묘경험 없음'){
      return '${txt} 다묘';
    } else {
      return '${txt}';
    }
  }

  /// 고양이 제공가능한 놀이 1개만
  static formatOnePlayProvided(String txt) {
    String replace = txt.replaceAll('[','').replaceAll(']','').replaceAll(' ','');
    if(replace.isNotEmpty){
      List<String> splitList = replace.split(',').toList();
      return splitList[0];
    } else {
      return '놀이 가능';
    }
  }
}