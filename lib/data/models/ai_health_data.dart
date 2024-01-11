
class AiHealthData{
  late String bone; // 관절
  late String boneProb; // 관절 예측 확률
  late String diabetes; // 당뇨
  late String diabetesProb; // 당뇨 예측 확률
  late String eye; // 눈건강
  late String eyeProb; // 눈건강 예측 확률
  late String highpress; // 고혈압
  late String highpressProb; // 고혈압 예측 확률
  late String immune; // 면역
  late String immuneProb; // 면역 예측 확률
  late String hypertensionAge; // 고혈압 발병 예측 나이
  late String diabetesAge; // 당뇨병 발병 얘측 나이
  late String obesityAge; // 비만 발병 예측 나이
  late String liverAge; // 간 질환 발병 예측 나이

  AiHealthData(
      {required this.bone,
      required this.boneProb,
      required this.diabetes,
      required this.diabetesProb,
      required this.eye,
      required this.eyeProb,
      required this.highpress,
      required this.highpressProb,
      required this.immune,
      required this.immuneProb,
      required this.hypertensionAge,
      required this.diabetesAge,
      required this.obesityAge,
      required this.liverAge});

  factory AiHealthData.fromJson(Map<String, dynamic>? json){
    return AiHealthData(
        bone: json?['bone'] ?? '0',
        boneProb: json?['boneProb'] ?? '0',
        diabetes: json?['diabetes'] ?? '0',
        diabetesProb: json?['diabetesProb'] ?? '0',
        eye: json?['eye'] ?? '0',
        eyeProb: json?['eyeProb'] ?? '0',
        highpress: json?['highpress'] ?? '0',
        highpressProb: json?['highpressProb'] ?? '0',
        immune: json?['immune'] ?? '0',
        immuneProb: json?['immuneProb'] ?? '0',
        hypertensionAge: json?['hypertensionAge'] ?? '-',
        diabetesAge: json?['diabetesAge'] ?? '-',
        obesityAge: json?['obesityAge'] ?? '-',
        liverAge: json?['liverAge'] ?? '-',
    );
  }
}