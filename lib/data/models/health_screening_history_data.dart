import 'package:ghealth_app/data/models/summary_response.dart';

class HealthScreeningHistoryData {
  /// 최근 검진일
  late String issuedDate;

  /// 검진명
  late String dataName;

  /// 검진값
  late String dataValue;

  HealthScreeningHistoryData(
      {required this.issuedDate,
        required this.dataName,
        required this.dataValue});

  factory HealthScreeningHistoryData.fromJson(Map<String, dynamic> json) {
    return HealthScreeningHistoryData(
        issuedDate: json['issuedDate'] ?? '-',
        dataName: json['dataName'] ?? '-',
        dataValue: json['dataValue'] ?? '-');
  }

  static List<HealthScreeningHistoryData> jsonList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => HealthScreeningHistoryData.fromJson(json))
        .toList();
  }


  static Map<String, List<HealthScreeningHistoryData>> groupDataByDate(dynamic json) {
    List<HealthScreeningHistoryData> historyList =  HealthScreeningHistoryData.jsonList(json);

    Map<String, List<HealthScreeningHistoryData>> groupedData = {};

    for (var history in historyList) {
      if (groupedData.containsKey(history.issuedDate)) {
        groupedData[history.issuedDate]!.add(history);
      } else {
        groupedData[history.issuedDate] = [history];
      }
    }

    return groupedData;
  }
}
