import 'package:ghealth_app/data/models/summary_response.dart';

class HealthScreeningData {
  /// 최근 검진일
  late String issuedDate;

  /// 검진명
  late String dataName;

  /// 검진값
  late String dataValue;

  HealthScreeningData(
      {required this.issuedDate,
      required this.dataName,
      required this.dataValue});

  factory HealthScreeningData.fromJson(Map<String, dynamic> json) {
    return HealthScreeningData(
        issuedDate: json['issuedDate'] ?? '-',
        dataName: json['dataName'] ?? '-',
        dataValue: json['dataValue'] ?? '-');
  }

  static List<HealthScreeningData> jsonList(dynamic json) {
    var tagObjsJson = json as List;

    return tagObjsJson
        .map((json) => HealthScreeningData.fromJson(json))
        .toList();
  }
}
