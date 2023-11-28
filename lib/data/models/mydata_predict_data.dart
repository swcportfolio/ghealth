
/// 나의 건강검진 기록
class MyDataPredictData {
  /// 관절건강 예측값(0:정상, 1:비정상)
  final String? bone;

  /// 당뇨병  예측값(0:정상, 1:비정상)
  final String? diabetes;

  /// 눈건강  예측값(0:정상, 1:비정상)
  final String? eye;

  /// 고혈압  예측값(0:정상, 1:비정상)
  final String? highpress;

  /// 면역  예측값(0:정상, 1:비정상)
  final String? immune;

  MyDataPredictData(
      {this.bone,
       this.diabetes,
       this.eye,
       this.highpress,
       this.immune});

  factory MyDataPredictData.fromJson(Map<String, dynamic>? json) {
    if(json == null){
      return MyDataPredictData(
        bone:  '-',
        diabetes:  '-',
        eye:  '-',
        highpress:  '-',
        immune:  '-',
      );
    } else {
      return MyDataPredictData(
      bone: json['bone'] ?? '-',
      diabetes: json['diabetes'] ?? '-',
      eye: json['eye'] ?? '-',
      highpress: json['highpress'] ?? '-',
      immune: json['immune'] ?? '-',
      );
    }
  }
}
