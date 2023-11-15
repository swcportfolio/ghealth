import 'package:ghealth_app/data/models/summary_response.dart';

class MedicationInfoData {
  /// 제조일자
  late String whenPrepared;

  /// 제조명
  late String medicationName;

  MedicationInfoData(
      {required this.whenPrepared, required this.medicationName});

  factory MedicationInfoData.fromJson(Map<String, dynamic> json) {
    return MedicationInfoData(
        whenPrepared: json['whenPrepared'] ?? '-',
        medicationName: json['medicationName'] ?? '-');
  }

  static List<MedicationInfoData> jsonList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => MedicationInfoData.fromJson(json))
        .toList();
  }
}
